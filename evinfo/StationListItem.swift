//
//  StationListItem.swift
//  evinfo
//
//  Created by yhw on 2021/09/21.
//

import Foundation

struct StationListItem: Identifiable, Codable {
    var lid = UUID()
    var id: Int
    var stationName: String
    var stationId: String
    var chargerType: String
    var address: String
    var location: String
    var useTime: String
    var lat: Double
    var lng: Double
    var callNumber: String
    var chargerStat: String
    var distance: Float
}
