//
//  Location.swift
//  evinfo
//
//  Created by yhw on 2021/09/17.
//

import Foundation

class Location: ObservableObject {
    @Published var latitude: Double
    @Published var longitude: Double
    
    init(){
        latitude = 37.55108
        longitude = 126.94096
    }
    
    func setLocation(lat: Double, long: Double) {
        self.latitude = lat
        self.longitude = long
    }
    
    func printLocation(){
        print(self.latitude, self.longitude)
    }
}
