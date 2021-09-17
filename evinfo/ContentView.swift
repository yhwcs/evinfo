//
//  ContentView.swift
//  evinfo
//
//  Created by yhw on 2021/09/17.
//  init

import SwiftUI

struct ContentView: View {
    // @EnvironmentObject var curLocation: Location
    
    var body: some View {
        MapView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
