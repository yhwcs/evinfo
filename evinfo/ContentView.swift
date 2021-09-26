//
//  ContentView.swift
//  evinfo
//
//  Created by yhw on 2021/09/17.
//  init

import SwiftUI

struct ContentView: View {
    @StateObject var chargerList = ChargerList()
    @StateObject var stationList = StationList()
    
    var body: some View {
        MapView()
            .environmentObject(chargerList)
            .environmentObject(stationList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
