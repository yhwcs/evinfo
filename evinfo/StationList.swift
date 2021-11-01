//
//  StationList.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import Foundation
import Combine

class StationList: ObservableObject  {
    init() {
        getStationInfo(latitude:37.55108, longitude:126.94096, size:10)
    }
    init(latitude: Double, longitude: Double, size: Int){
        getStationInfo(latitude:latitude, longitude:longitude, size:size)
    }
    
    @Published var items: [StationListItem] = []
    var canclelables = Set<AnyCancellable>()
    
    // Method
    func getStationInfo(latitude: Double, longitude: Double, size: Int) {
        guard let url = URL(string: "http://ec2-3-35-112-56.ap-northeast-2.compute.amazonaws.com:8080/api/stations?latitude=\(latitude)&longitude=\(longitude)&size=\(size)&chargerTypes=1,2,3") else { return }
        
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
        
        print("get Stations Information")
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
    func clearStationList() {
        for _ in 0..<items.count {
            items.remove(at: 0)
        }
        print("clear station list")
    }
}

