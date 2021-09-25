//
//  StationList.swift
//  evinfo
//
//  Created by yhw on 2021/09/21.
//

import SwiftUI
import Combine

class StationList: ObservableObject {
    init() {}
    init(latitude: Double, longitude: Double, size: Int){
        getStationInformation(latitude:latitude, longitude:longitude, size:size)
    }
    
    @Published var items: [StationListItem] = []
    var canclelables = Set<AnyCancellable>()
    
    // Method
    func getStationInformation(latitude: Double, longitude: Double, size: Int) {
        guard let url = URL(string: "http://ec2-3-35-112-56.ap-northeast-2.compute.amazonaws.com:8080/api/chargers?latitude=\(latitude)&longitude=\(longitude)&size=\(size)") else { return }
        
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
