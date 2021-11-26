//
//  LocationListItem.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//


import Foundation

class LocationListItem: Identifiable, Codable, ObservableObject {
    var id = UUID()
    var name: String
    var latitude: Double
    var longitude: Double
    var distance: Double
    var callNumber: String
    var address: String
    var placeUrl: String
    var category: String
    
    // Encode/Decode is performed except for id that allows item to be identification
    enum CodingKeys: String, CodingKey {
        case name
        case latitude
        case longitude
        case distance
        case callNumber
        case address
        case placeUrl
        case category
    }
    
    init() {
        self.name = "NULL"
        self.latitude = 37.0
        self.longitude = 126.9
        self.distance = 0.0
        self.callNumber = "NULL"
        self.address = "NULL"
        self.placeUrl = "NULL"
        self.category = "NULL"
    }
    
    func copyLocation(toItem: LocationListItem, fromItem: LocationListItem){
        toItem.name = fromItem.name
        toItem.latitude = fromItem.latitude
        toItem.longitude = fromItem.longitude
        toItem.distance = fromItem.distance
        toItem.callNumber = fromItem.callNumber
        toItem.address = fromItem.address
        toItem.placeUrl = fromItem.placeUrl
        toItem.category = fromItem.category
    }
    
    func setLocation(name: String, latitude: Double, longitude: Double, distance: Double, callNumber: String, address: String, placeUrl: String, category: String){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        self.callNumber = callNumber
        self.address = address
        self.placeUrl = placeUrl
        self.category = category
    }
}
