//
//  StationList.swift
//  evinfo
//
//  Created by yhw on 2021/09/21.
//

import SwiftUI
import Combine

class StationList: ObservableObject {
    init(){
        //getStationInformation()
        items.append(exampleA)
        items.append(exampleB)
        items.append(exampleC)
    }
    var exampleA = StationListItem(id: 1, stationName: "nameA", stationId: "idA", chargerType: "typeA", address: "addrA", location: "locA", useTime: "timeA", lat: 37.40754, lng: 126.95355, callNumber: "numA", chargerStat: "statA", distance: 1.0)
    var exampleB = StationListItem(id: 2, stationName: "nameB", stationId: "idA", chargerType: "typeA", address: "addrA", location: "locA", useTime: "timeA", lat: 37.38845, lng: 126.93124, callNumber: "numA", chargerStat: "statA", distance: 1.0)
    var exampleC = StationListItem(id: 3, stationName: "nameC", stationId: "idA", chargerType: "typeA", address: "addrA", location: "locA", useTime: "timeA", lat: 37.48299, lng: 126.90871, callNumber: "numA", chargerStat: "statA", distance: 1.0)
    
    @Published var items: [StationListItem] = []
    var canclelables = Set<AnyCancellable>()
    
    // Method
    func getStationInformation() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        // subscribe publisher을 background thread로 옮김
            .subscribe(on: DispatchQueue.global(qos: .background))
        // main thread에서 수신
            .receive(on: DispatchQueue.main)
        
            .tryMap(handleOutput)
            .decode(type: [StationListItem].self, decoder: JSONDecoder())
       
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] StationListItem in
                self?.items = StationListItem
            }
        
        // 필요한 경우 취소
            .store(in: &canclelables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
    
    func printStationListItems() {
        for item in items {
            print(item)
        }
    }
    
    func deleteListItem(whichElement: IndexSet){
        items.remove(atOffsets: whichElement)
        print("delete item: ", whichElement)
    }
    
    func moveListItem(whichElement: IndexSet, destination: Int){
        items.move(fromOffsets: whichElement, toOffset: destination)
        print("move item from \(whichElement) to \(destination)")
    }
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let directory = paths[0]
        print("Documents directory is: \(directory)")
        return directory
    }
    
    func dataFilePath() -> URL {
        let filePath = documentsDirectory().appendingPathComponent("StationList.plist")
        print("Data file path is \(filePath)")
        return filePath
    }
    
    func saveStationListItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
            print("StationList items saved")
        } catch {
            print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
}
