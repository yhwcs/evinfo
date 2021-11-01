//
//  StationDetailView.swift
//  evinfo
//
//  Created by yhw on 2021/10/14.
//

import SwiftUI
import UIKit
import NMapsMap
import TMapSDK

struct StationDetailView: View {
    
    @EnvironmentObject var selectedStation: StationListItem
    
    // current location for Kakao Map API
    @EnvironmentObject var startLocation: Location
    
    // dismiss view flag
    @Environment(\.presentationMode) var presentationMode
    
    // sheet showing flag for selecting a route guidance application
    @State private var showingSelectionSheet = false
    
    // copy has been completed flag
    @State private var showingCopyAlert = false
    
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
                        
                        // copy the address to the clipboard
                        Image(systemName: "doc.on.clipboard")
                            .foregroundColor(.gray)
                            .onTapGesture(){
                                UIPasteboard.general.string = selectedStation.address
                                self.showingCopyAlert = true
                            }
                            .alert(isPresented: $showingCopyAlert){
                                Alert(title: Text("주소 복사 완료"), message: Text("주소 복사가 완료되었습니다.\n원하는 곳에 붙여넣기 해주세요."), dismissButton: .default(Text("닫기")))
                            }
                        Spacer()
                    }
                    
                    // route guidance button
                    HStack{
                        Button(action: {
                            self.showingSelectionSheet.toggle()
                        }) {
                            HStack{
                                HStack{
                                    Image(systemName: "car.fill")
                                    Text("경로 안내")
                                }
                                .padding(10)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(30)
                                .padding(.trailing, 10)
                                Spacer()
                            }
                        }
                        // sheet for selecting a route guidance application
                        .actionSheet(isPresented: $showingSelectionSheet, content: {
                            ActionSheet(title: Text("경로 안내 어플리케이션").font(.headline), message: Text("해당 충전소로 안내할 어플리케이션을 선택해주세요."), buttons: [.default(Text("네이버 맵 (Naver Map)"), action: callNMap), .default(Text("카카오 맵 (Kakao Map)"), action: callKMap), .default(Text("티 맵 (T Map)"), action: callTMap), .cancel(Text("취소"))])
                        })
                    }
                    
                    HStack{
                        Image(systemName: "phone.fill")
                        Text(selectedStation.callNumber)
                            .foregroundColor(.blue)
                            // call the company
                            .onTapGesture(){
                                CallBusiness(callNumber: selectedStation.callNumber)
                            }
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
    
    // call Naver Map for route guidance
    func callNMap(){
        let dname = selectedStation.stationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: "nmap://route/car?dlat=\(selectedStation.latitude)&dlng=\(selectedStation.longitude)&dname=\(dname)&appname=EVFinder")!
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id311867728?mt=8")!
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
    // call Kakao Map for route guidance
    func callKMap(){
        let url = URL(string: "kakaomap://route?sp=\(startLocation.latitude),\(startLocation.longitude)&ep=\(selectedStation.latitude),\(selectedStation.longitude)&by=CAR")!
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id304608425")!
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(appStoreURL)
        }
    }
    
    // call T Map for route guidance
    func callTMap(){
        var delegate = TMapDelegate()
        delegate.OpenTMap(selectedStation: selectedStation)
    }
    
    class TMapDelegate: TMapTapiDelegate {
        init(){
            TMapApi.setSKTMapAuthenticationWithDelegate(self, apiKey: "l7xx315f78113c2d44f8ab3b9715cfa05453")
        }
        
        func SKTMapApikeySucceed(){
                print("TMap Authentication succeed!")
        }
        
        func OpenTMap(selectedStation: StationListItem){
            let url = URL(string: "tmap://?rGoName=\(selectedStation.stationName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)&rGoX=\(selectedStation.longitude)&rGoY=\(selectedStation.latitude)")!
            let appStoreURL = TMapApi.getTMapDownUrl()
            
            if UIApplication.shared.canOpenURL(url){
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.open(URL(string: appStoreURL)!)
            }
        }
    }
    
    // call the company
    func CallBusiness(callNumber: String){
        let callNum = callNumber.components(separatedBy: ["-"]).joined()
        let url = URL(string: "tel://"+callNum)!
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        } else {
            return
        }
    }
 
}

struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailView()
    }
}
