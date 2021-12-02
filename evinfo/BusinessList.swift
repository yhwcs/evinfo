//
//  BusinessList.swift
//  evinfo
//
//  Created by yhw on 2021/12/02.
//

import Foundation
import Combine

class BusinessList: ObservableObject  {
    init() {
        getBusinessnfo()
    }
    
    @Published var items: [BusinessListItem] = []
    var canclelables = Set<AnyCancellable>()
    
    // Method
    func getBusinessnfo() {
        guard let url = URL(string: "http://ec2-3-35-112-56.ap-northeast-2.compute.amazonaws.com:8080/api/stations/businesses") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        // subscribe publisher을 background thread로 옮김
            .subscribe(on: DispatchQueue.global(qos: .background))
        // main thread에서 수신
            .receive(on: DispatchQueue.main)
        
            .tryMap(handleOutput)
            .decode(type: [BusinessListItem].self, decoder: JSONDecoder())
       
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnBusinessListItem in
                self?.items = returnBusinessListItem
            }
        
        // 필요한 경우 취소
            .store(in: &canclelables)
        
        print("get Business Information")
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
}
