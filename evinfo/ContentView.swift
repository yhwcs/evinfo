//
//  ContentView.swift
//  evinfo
//
//  Created by yhw on 2021/09/17.
//  init

import SwiftUI
import PartialSheet

struct ContentView: View {
    @StateObject var chargerList = ChargerList()
    @StateObject var stationList = StationList()
    @StateObject var sheetManager: PartialSheetManager = PartialSheetManager()
    
    var body: some View {
        MapView()
            .environmentObject(chargerList)
            .environmentObject(stationList)
            .environmentObject(sheetManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
