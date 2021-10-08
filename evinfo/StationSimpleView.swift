//
//  StationSimpleView.swift
//  evinfo
//
//  Created by yhw on 2021/10/07.
//

import SwiftUI

struct StationSimpleView: View {

    @EnvironmentObject var selectedStation: StationListItem
    
    @State var waitingCharger = 0
    
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
                if waitingCharger > 0 {
                    Text("충전 가능")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                else {
                    Text("충전 불가")
                        .font(.headline)
                        .foregroundColor(.red)
                }
                Spacer()
                Text("\(waitingCharger) / \(selectedStation.chargerItems.count)")
            }.padding(.horizontal, 20)
            /*
            ForEach(0..<selectedStation.chargerItems.count) {
                i in
                HStack{
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.green)
                    Text("\(selectedStation.chargerItems[i].id) : \(selectedStation.chargerItems[i].chargerStat)")
                    Spacer()
                }
            }
            */
             
        }.padding(.bottom, 20)
        // onTapGesture occurs even if press the blank space
        .background(Color.white)
        .onTapGesture {
            print("simple view -> detail view")
        }
        .onAppear(){
            for i in 0..<selectedStation.chargerItems.count {
                if selectedStation.chargerItems[i].chargerStat == "WAITING" {
                    self.waitingCharger += 1
                }
            }
        }
        .onDisappear(){
            self.waitingCharger = 0
            print("dismiss \(selectedStation.stationName) simple view")
        }
    }
}

struct StationSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        StationSimpleView()
    }
}
