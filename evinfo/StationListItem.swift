//
//  StationListItem.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import Foundation

class StationListItem: ObservableObject, Identifiable  {
    let id = UUID()
    var stationId: String = "NULL"
    var stationName: String = "NULL"
    var address: String = "NULL"
    var location: String = "NULL"
    var useTime: String = "NULL"
    var lat: Double = 0.0
    var lng: Double = 0.0
    var callNumber: String = "NULL"
    var distance: Float = 0.0
    
    @Published var chargerItems: [ChargerItem] = []
    init() { }
    
    func setStationInfo(stationId: String, stationName: String, address: String, location: String, useTime: String, lat: Double, lng: Double, callNumber: String, distance: Float) {
        self.stationId = stationId
        self.stationName = stationName
        self.address = address
        self.location = location
        self.useTime = useTime
        self.lat = lat
        self.lng = lng
        self.callNumber = callNumber
        self.distance = distance
    }
    
    func addChargerItem(id: String, chargerType: String, chargerStat: String){
        let item = ChargerItem(id: id, chargerType: chargerType, chargerStat: chargerStat)
        self.chargerItems.append(item)
    }
    
    func copyStation(toItem: StationListItem, fromItem: StationListItem) {
        toItem.stationId = fromItem.stationId
        toItem.stationName = fromItem.stationName
        toItem.address = fromItem.address
        toItem.location = fromItem.location
        toItem.useTime = fromItem.useTime
        toItem.lat = fromItem.lat
        toItem.lng = fromItem.lng
        toItem.callNumber = fromItem.callNumber
        toItem.distance = fromItem.distance
        
        for _ in 0..<toItem.chargerItems.count {
            toItem.chargerItems.remove(at: 0)
        }
        
        for i in 0..<fromItem.chargerItems.count {
            let item = fromItem.chargerItems[i]
            toItem.chargerItems.append(item)
        }
    }
}

struct ChargerItem: Identifiable {
    var id: String
    var chargerType: String
    var chargerStat: String
}
