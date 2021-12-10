//
//  ReviewItem.swift
//  evinfo
//
//  Created by yhw on 2021/12/06.
//

import Foundation

class ReviewItem: Identifiable, Codable {
    var content: String
    var star: Double
    var stationId: String
    
    init(){
        self.content = ""
        self.star = 0.0
        self.stationId = ""
    }
    
    init(content:String, star:Double, stationId: String) {
        self.content = content
        self.star = star
        self.stationId = stationId
    }
}

