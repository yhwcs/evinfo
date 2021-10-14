//
//  StationSimpleView.swift
//  evinfo
//
//  Created by yhw on 2021/10/07.
//

import SwiftUI

struct StationSimpleView: View {

    @EnvironmentObject var selectedStation: StationListItem
    
    var body: some View {
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
                    Spacer()
                }.padding(.horizontal, 20)
            }
            HStack{
                if selectedStation.distance < 1.0 {
                    Text("\(Int(round(selectedStation.distance * 1000)))m")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                else {
                    Text(String(format: "%.1f", selectedStation.distance) + "km")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                Spacer()
            }.padding(.horizontal, 20)
            HStack{
                if selectedStation.state > 0 {
                    Text("충전 가능")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                else if selectedStation.state == 0 {
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
                Text("\(selectedStation.state) / \(selectedStation.chargers.count)")
                    .font(.headline)
            }.padding(.horizontal, 20)
             
        }.padding(.bottom, 20)
        // onTapGesture occurs even if press the blank space
        .background(Color.white)
        .onTapGesture {
            print("simple view -> detail view")
        }
        .onAppear(){
            print(selectedStation.state)
        }
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
