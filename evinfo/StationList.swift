//
//  StationList.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import Foundation

class StationList: ObservableObject  {
    @Published var items: [StationListItem] = []
    init() { }
    
    func getStationInfo(chargerList: ChargerList) {
        var preFlag = false
        var index = 0
        for i in 0..<chargerList.items.count {
            let chargerItem = chargerList.items[i]
            for j in 0..<items.count {
                if chargerItem.stationId == items[j].stationId {
                    preFlag = true
                    index = j
                    break
                }
            }
            // new station
            if preFlag == false{
                let stationItem = StationListItem()
                // set station info
                stationItem.setStationInfo(stationId: chargerItem.stationId, stationName: chargerItem.stationName, address: chargerItem.address, location: chargerItem.location, useTime: chargerItem.useTime, lat: chargerItem.lat, lng: chargerItem.lng, callNumber: chargerItem.callNumber, distance: chargerItem.distance)
                // add charger info
                stationItem.addChargerItem(id: chargerItem.chargerId, chargerType: chargerItem.chargerType, chargerStat: chargerItem.chargerStat)
                items.append(stationItem)
            }
            // the station is already registred
            else {
                // add charger info
                items[index].addChargerItem(id: chargerItem.chargerId, chargerType: chargerItem.chargerType, chargerStat: chargerItem.chargerStat)
                preFlag = false
            }
        }
    }
    
    func clearStationList() {
        for _ in 0..<items.count {
            items.remove(at: 0)
        }
    }
}
