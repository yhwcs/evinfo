//
//  LocationList.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//

import Foundation
import Combine

class LocationList: ObservableObject  {
    init() { }
    
    @Published var items: [LocationListItem] = []
    var canclelables = Set<AnyCancellable>()
    
    // Method
    func getLocationInfo(latitude: Double, longitude: Double, category: String) {
        guard let url = URL(string: "http://ec2-3-35-112-56.ap-northeast-2.compute.amazonaws.com:8080/api/locations?latitude=\(latitude)&longitude=\(longitude)&category=\(category)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        // subscribe publisher을 background thread로 옮김
            .subscribe(on: DispatchQueue.global(qos: .background))
        // main thread에서 수신
            .receive(on: DispatchQueue.main)
        
            .tryMap(handleOutput)
            .decode(type: [LocationListItem].self, decoder: JSONDecoder())
       
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnLocationListItem in
                //self?.items = LocationListItem
                self?.items.append(contentsOf: returnLocationListItem)
            }
        
        // 필요한 경우 취소
            .store(in: &canclelables)
        
        print("get Locations Information")
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
    
    func clearLocationList() {
        for _ in 0..<items.count {
            items.remove(at: 0)
        }
        print("clear Location list")
    }
    
    func makeNearbyLocationList(latitude: Double, longitude: Double) {
        clearLocationList()
        getLocationInfo(latitude:latitude,
                       longitude:longitude,
                       category: "CE7")
        getLocationInfo(latitude:latitude,
                       longitude:longitude,
                       category: "MT1")
        getLocationInfo(latitude:latitude,
                       longitude:longitude,
                       category: "CS2")
        getLocationInfo(latitude:latitude,
                       longitude:longitude,
                       category: "CT1")
    }
}

