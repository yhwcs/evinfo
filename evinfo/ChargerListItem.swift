//
//  ChargerListItem.swift
//  evinfo
//
//  Created by yhw on 2021/09/21.
//

import Foundation

struct ChargerListItem: Identifiable, Codable {
    var id = UUID()
    var chargerId: String
    var isDCCombo: Bool
    var isDCDemo: Bool
    var isAC3: Bool
    var isACSlow: Bool
    var chargerStat: String
    
    // Encode/Decode is performed except for id that allows item to be identification
    enum CodingKeys: String, CodingKey {
        case chargerId
        case isDCCombo
        case isDCDemo
        case isAC3
        case isACSlow
        case chargerStat
    }
}
