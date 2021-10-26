//
//  StationListView.swift
//  evinfo
//
//  Created by yhw on 2021/09/25.
//

import SwiftUI

struct StationListView: View {

    // the list of stations in order of distance
    @EnvironmentObject var stationList: StationList
    
    // station that the user choose to look closely
    @EnvironmentObject var selectedStation: StationListItem
    
    // the list of stations in order of price
    @State var sortedStationList: [StationListItem] = []
    
    // flag indicating whether stations are sorted in order of price
    @State private var sorted = false
    
    // dismiss view flag
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var startLocation: Location
    
    var body: some View {
        VStack{
            // sort criteria selection button (distance / price)
            HStack {
                Spacer()
                Button(action: {
                    sorted.toggle()
                }) {
                    if sorted {
                        Text("▼ 가격순")
                            .fontWeight(.semibold)
                            .font(.subheadline)
                    }
                    else {
                        Text("▼ 거리순")
                            .fontWeight(.semibold)
                            .font(.subheadline)
                    }
                }
                .padding(10)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(30)
                .padding(.trailing, 10)
            }
            // show station list
            List{
                VStack{
                    // order of price
                    if sorted {
                        ForEach(0..<sortedStationList.count){
                        index in
                                StationRowView(stationListItem: $sortedStationList[index])
                                    .environmentObject(selectedStation)
                                    .background(Color.white)
                        }
                    }
                    // order of distance
                    else {
                        ForEach(0..<stationList.items.count){
                        index in
                                StationRowView(stationListItem: $stationList.items[index])
                                    .environmentObject(selectedStation)
                                    .environmentObject(startLocation)
                                    .background(Color.white)
                        }
                    }
                }
            } // End of List
        }
        .background(Color.white)
        .onAppear(){
            sortedStationList = stationList.items.sorted(by: <)
        }
    } // End of View
}
/*
struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView(chargerList: ChargerList())
    }
}
*/
