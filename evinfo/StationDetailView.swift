//
//  StationDetailView.swift
//  evinfo
//
//  Created by yhw on 2021/10/14.
//

import SwiftUI

struct StationDetailView: View {
    
    @EnvironmentObject var selectedStation: StationListItem
    
    // dismiss view flag
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack{
                // dismiss view button
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.title)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .padding(10)
                }
                Spacer()
            }
            ScrollView{
                VStack(spacing: 10){
                    HStack{
                        Text(selectedStation.stationName)
                            .font(.title3)
                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    HStack{
                        Text(selectedStation.address)
                        .font(.callout)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "phone.fill")
                        Text(selectedStation.callNumber)
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "building.2")
                        Text(selectedStation.businessName)
                            .font(.callout)
                            Spacer()
                    }
                    HStack{
                        Image(systemName: "wonsign.circle")
                        Text("1kWh당 "+String(format: "%.1f", selectedStation.chargers[0].price)+"원")
                            .font(.callout)
                            Spacer()
                    }
                    if selectedStation.useTime.count > 0 {
                        HStack{
                            Image(systemName: "clock")
                            Text(selectedStation.useTime)
                            .font(.callout)
                            Spacer()
                        }
                    }
                    
                    // charger list
                    ForEach(0..<selectedStation.chargers.count){
                        i in
                        HStack{
                            if selectedStation.chargers[i].chargerStat == "WAITING" {
                                Text("충전 가능")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }
                            else if selectedStation.chargers[i].chargerStat == "CHARGING" {
                                Text("충전 불가")
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            else if selectedStation.chargers[i].chargerStat == "STOPPED" {
                                Text("운영 중지")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                            }
                            else if selectedStation.chargers[i].chargerStat == "CHECKING" {
                                Text("점검 진행")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                            }
                            else {
                                Text("확인 불가")
                                    .font(.headline)
                                    .foregroundColor(.orange)
                            }
                            if selectedStation.chargers[i].isDCCombo {
                                Text("DC콤보")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            else {
                                Text("DC콤보")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            if selectedStation.chargers[i].isDCDemo {
                                Text("DC데모")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            else {
                                Text("DC데모")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            if selectedStation.chargers[i].isAC3 {
                                Text("AC3상")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            else {
                                Text("AC3상")
                                    .font(.body)
                                    .foregroundColor(.gray)
                            }
                            if selectedStation.chargers[i].isACSlow {
                                Text("완속")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                            else {
                                Text("완속")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                            }
                        }
                    } // End of ForEach
                }
            }.padding(.horizontal, 20)
        }
    }
}

struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailView()
    }
}
