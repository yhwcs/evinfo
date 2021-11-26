//
//  LocationListView.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject var locationList: LocationList
    
    var body: some View {
        List{
            ForEach(0..<locationList.items.count){
            index in
                LocationRowView(selectedLocation: $locationList.items[index])
            }
        } // End of List
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
