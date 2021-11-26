//
//  StationRowView.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import SwiftUI

struct StationRowView: View {
    @Binding var stationListItem: StationListItem
    
    @EnvironmentObject var selectedStation: StationListItem
    
    @EnvironmentObject var startLocation: Location
    
    // station detail view flag
    @State private var showingStationDetailSheet = false
    
    var body: some View {
        VStack{
            HStack{
                Text(stationListItem.stationName)
                    .font(.title3)
                    .foregroundColor(.blue)
                Spacer()
            }
            HStack{
                Text(stationListItem.address)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
            HStack{
                if stationListItem.distance < 1.0 {
                    Text("\(Int(round(stationListItem.distance * 1000)))m | 1kWh당 "+String(format: "%.1f", stationListItem.chargers[0].price)+"원")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                else {
                    Text(String(format: "%.1f", stationListItem.distance) + "km | 1kWh당 "+String(format: "%.1f", stationListItem.chargers[0].price)+"원")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                Spacer()
            }
            if stationListItem.useTime.count > 0 {
                HStack{
                    Image(systemName: "clock")
                    Text(stationListItem.useTime)
                        .font(.callout)
                    Spacer()
                }
            }
            HStack{
                if stationListItem.enableChargers > 0 {
                    Text("충전 가능")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                else if stationListItem.enableChargers == 0 {
                    Text("충전 불가")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                else {
                    Text("확인 불가")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                Spacer()
                if stationListItem.chargers[0].isACSlow {
                    Text("완속 ")
                        .font(.headline)
                }
                else {
                    Text("급속 ")
                        .font(.headline)
                }
                Text("\(stationListItem.enableChargers) / \(stationListItem.chargers.count)")
                    .font(.headline)
            }
            Spacer()
        }
        // onTapGesture occurs even if press the blank space
        .background(Color.white)
        .onTapGesture {
            print(stationListItem.stationName)
            selectedStation.copyStation(toItem: selectedStation, fromItem: stationListItem)
            self.showingStationDetailSheet = true
        }
        .fullScreenCover(isPresented: $showingStationDetailSheet, content: {
            StationTabView()
                .environmentObject(selectedStation)
                .environmentObject(startLocation)
        })
    }
}
/*
struct StationRowView_Previews: PreviewProvider {
    static var previews: some View {
        StationRowView(stationListItem: stationListItem())
    }
}
*/
