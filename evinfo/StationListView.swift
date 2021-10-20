//
//  StationListView.swift
//  evinfo
//
//  Created by yhw on 2021/09/25.
//

import SwiftUI

struct StationListView: View {

    @EnvironmentObject var stationList: StationList
    @EnvironmentObject var selectedStation: StationListItem
    
    // dismiss view flag
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
            // show station list
            List{
                VStack{
                    ForEach(0..<stationList.items.count){
                    index in
                            StationRowView(stationListItem: $stationList.items[index])
                                .environmentObject(selectedStation)
                                .background(Color.white)
                    } // End of ForEach
                }
            }
        }
        .background(Color.white)
    } // End of View
}
/*
struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView(chargerList: ChargerList())
    }
}
*/
