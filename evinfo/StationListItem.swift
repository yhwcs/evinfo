//
//  StationListItem.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import Foundation

class StationListItem: Identifiable, Codable, ObservableObject {
    var id = UUID()
    var stationName: String
    var stationId: String
    var address: String
    var location: String
    var useTime: String
    var latitude: Double
    var longitude: Double
    var callNumber: String
    var distance: Float
    var chargers: [ChargerListItem] = []
    @Published var state: Int = 1
    
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
        case distance
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
        self.distance = 0.0
        self.state = 0
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
        toItem.distance = fromItem.distance
        toItem.state = fromItem.state
        
        for _ in 0..<toItem.chargers.count {
            toItem.chargers.remove(at: 0)
        }
        
        for i in 0..<fromItem.chargers.count {
            let item = fromItem.chargers[i]
            toItem.chargers.append(item)
        }
    }
    
    func checkStationState() {
        var waitingCharger = 0
        for i in 0..<self.chargers.count {
            if self.chargers[i].chargerStat == "WAITING" {
                waitingCharger += 1
            }
            else if self.chargers[i].chargerStat == "CHECKING" {
                waitingCharger = -1
                break
            }
        }
        self.state = waitingCharger
    }

}
