//
//  StationSimpleView.swift
//  evinfo
//
//  Created by yhw on 2021/10/07.
//

import SwiftUI

struct StationSimpleView: View {

    @EnvironmentObject var selectedStation: StationListItem
    
    @EnvironmentObject var startLocation: Location
    
    // station detail view flag
    @State private var showingStationDetailSheet = false
    
    var body: some View {
        Button(action: {
            showingStationDetailSheet = true
        }) {
            VStack(spacing: 10){
                HStack{
                    Text(selectedStation.stationName)
                        .font(.title3)
                        .foregroundColor(.blue)
                    Spacer()
                }.padding(.horizontal, 20)
                HStack{
                    Text(selectedStation.address)
                    .font(.subheadline)
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.horizontal, 20)
                if selectedStation.useTime.count > 0 {
                    HStack{
                        Image(systemName: "clock")
                        Text(selectedStation.useTime)
                            .font(.callout)
                            .foregroundColor(.black)
                        Spacer()
                    }.padding(.horizontal, 20)
                }
                HStack{
                    if selectedStation.distance < 1.0 {
                        Text("\(Int(round(selectedStation.distance * 1000)))m | 1kWh당 "+String(format: "%.1f", selectedStation.chargers[0].price)+"원")
                            .font(.callout)
                            .foregroundColor(.red)
                    }
                    else {
                        Text(String(format: "%.1f", selectedStation.distance) + "km | 1kWh당 "+String(format: "%.1f", selectedStation.chargers[0].price)+"원")
                            .font(.callout)
                            .foregroundColor(.red)
                    }
                    Spacer()
                }.padding(.horizontal, 20)
                HStack{
                    if selectedStation.enableChargers > 0 {
                        Text("충전 가능")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    else if selectedStation.enableChargers == 0 {
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
                    if selectedStation.chargers[0].isACSlow {
                        Text("완속 ")
                            .font(.headline)
                    }
                    else {
                        Text("급속 ")
                            .font(.headline)
                    }
                    Text("\(selectedStation.enableChargers) / \(selectedStation.chargers.count)")
                        .font(.headline)
                }.padding(.horizontal, 20)
                 
            }
        }
        .fullScreenCover(isPresented: $showingStationDetailSheet, content: {
            StationTabView()
                .environmentObject(selectedStation)
                .environmentObject(startLocation)
        })
        .onDisappear(){
            print("dismiss \(selectedStation.stationName) simple view")
        }
    }
}

struct StationSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        StationSimpleView()
    }
}
