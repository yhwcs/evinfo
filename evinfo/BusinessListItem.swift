//
//  BusinessListItem.swift
//  evinfo
//
//  Created by yhw on 2021/12/02.
//

import Foundation

class BusinessListItem: Identifiable, Codable, ObservableObject {
    var id = UUID()
    var businessName: String
    var count: Int
    var isChecked: Bool = true
    
    // Encode/Decode is performed except for id that allows item to be identification
    enum CodingKeys: String, CodingKey {
        case businessName
        case count
    }
    
    init() {
        self.businessName = "NULL"
        self.count = 0
        self.isChecked = true
    }
    
    func toggleStatus() {
        if self.isChecked == true {
            self.isChecked = false
        }
        else {
            self.isChecked = true
        }
    }
}
