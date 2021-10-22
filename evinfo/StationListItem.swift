//
//  StationListItem.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import Foundation

class StationListItem: Identifiable, Codable, ObservableObject, Comparable {
    var id = UUID()
    var stationName: String
    var stationId: String
    var address: String
    var location: String
    var useTime: String
    var latitude: Double
    var longitude: Double
    var callNumber: String
    var businessName: String
    var distance: Float
    var enableChargers: Int
    var chargers: [ChargerListItem] = []
    
    // Encode/Decode is performed except for id that allows item to be identification
    enum CodingKeys: String, CodingKey {
        case stationName
        case stationId
        case address
        case location
        case useTime
        case latitude
        case longitude
        case callNumber
        case businessName
        case distance
        case enableChargers
        case chargers
    }
    
    init(){
        self.stationId = "NULL"
        self.stationName = "NULL"
        self.address = "NULL"
        self.location = "NULL"
        self.useTime = "NULL"
        self.latitude = 37.0
        self.longitude = 126.9
        self.callNumber = "NULL"
        self.businessName = "NULL"
        self.distance = 0.0
        self.enableChargers = 0
    }
    
    func copyStation(toItem: StationListItem, fromItem: StationListItem) {
        toItem.stationId = fromItem.stationId
        toItem.stationName = fromItem.stationName
        toItem.address = fromItem.address
        toItem.location = fromItem.location
        toItem.useTime = fromItem.useTime
        toItem.latitude = fromItem.latitude
        toItem.longitude = fromItem.longitude
        toItem.callNumber = fromItem.callNumber
        toItem.businessName = fromItem.businessName
        toItem.distance = fromItem.distance
        toItem.enableChargers = fromItem.enableChargers
        
        for _ in 0..<toItem.chargers.count {
            toItem.chargers.remove(at: 0)
        }
        
        for i in 0..<fromItem.chargers.count {
            let item = fromItem.chargers[i]
            toItem.chargers.append(item)
        }
    }
    
    // comparison between stations is based on the price
    static func < (lhs: StationListItem, rhs: StationListItem) -> Bool {
        return lhs.chargers[0].price < rhs.chargers[0].price
    }
    
    static func == (lhs: StationListItem, rhs: StationListItem) -> Bool {
        if lhs.chargers.count > 0 && rhs.chargers.count > 0 {
            return lhs.chargers[0].price == rhs.chargers[0].price
        }
        else {
            return false
        }
    }
}
