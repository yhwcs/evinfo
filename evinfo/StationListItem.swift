//
//  StationListItem.swift
//  evinfo
//
//  Created by yhw on 2021/09/21.
//

import Foundation

struct StationListItem: Identifiable, Codable {
    var id: Int
    var statName: String
    var chargerType: Int
    var address: String
    var location: String // address != location?
    var useTime: String
    var lat: Double
    var lng: Double
    var callNumber: String
    var chargerStat: Int
}
