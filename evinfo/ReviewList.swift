//
//  ReviewList.swift
//  evinfo
//
//  Created by yhw on 2021/12/10.
//

import Foundation
import Combine

class ReviewList: ObservableObject  {
    init() {}
    
    @Published var items: [ReviewListItem] = []
    var canclelables = Set<AnyCancellable>()
    
    // Method
    func getReviewInfo(stationId: String) {
        guard let url = URL(string: "http://ec2-3-35-112-56.ap-northeast-2.compute.amazonaws.com:8080/api/reviews?stationId=\(stationId)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
        // subscribe publisher을 background thread로 옮김
            .subscribe(on: DispatchQueue.global(qos: .background))
        // main thread에서 수신
            .receive(on: DispatchQueue.main)
        
            .tryMap(handleOutput)
            .decode(type: [ReviewListItem].self, decoder: JSONDecoder())
       
            .sink { completion in
                print("Completion: \(completion)")
            } receiveValue: { [weak self] returnReviewListItem in
                self?.items = returnReviewListItem
            }
        
        // 필요한 경우 취소
            .store(in: &canclelables)
        
        print("get Review Information")
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
    
    func clearReviewList() {
        for _ in 0..<items.count {
            items.remove(at: 0)
        }
        print("clear Review list")
    }
}

class ReviewListItem: Identifiable, Codable, ObservableObject {
    var id: Int
    var content: String
    var star: Double
    var createdAt: String
    
    init() {
        self.id = 0
        self.content = ""
        self.star = 0.0
        self.createdAt = ""
    }
    
    init(id: Int, content:String, star:Double, createdAt: String) {
        self.id = id
        self.content = content
        self.star = star
        self.createdAt = createdAt
    }
}
