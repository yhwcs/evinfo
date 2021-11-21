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
    
    // showing charge time flag
    @State private var showingChargeTime = false
    
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
                                Alert(title: Text("주소 복사 완료"),
                                      message: Text("주소 복사가 완료되었습니다.\n원하는 곳에 붙여넣기 해주세요."),
                                      dismissButton: .default(Text("닫기")))
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
                            ActionSheet(
                                title: Text("경로 안내 어플리케이션").font(.headline),
                                message: Text("해당 충전소로 안내할 어플리케이션을 선택해주세요."),
                                buttons: [
                                    .default(Text("네이버 맵 (Naver Map)"),
                                             action: callNMap),
                                        .default(Text("카카오 맵 (Kakao Map)"),
                                                 action: callKMap),
                                        .default(Text("티 맵 (T Map)"),
                                                 action: callTMap),
                                        .cancel(Text("취소"))])
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
                    Text("")
                    HStack{
                        Text("충전기 현황")
                            .font(.headline)
                        Spacer()
                        Text(showingChargeTime ? "-" : "+")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .onTapGesture {
                                showingChargeTime.toggle()
                            }
                    }
                    
                    // charger list
                    ForEach(0..<selectedStation.chargers.count){
                        i in
                        VStack{
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
                                        .availalbeTextModifier()
                                }
                                else {
                                    Text("DC콤보")
                                        .unavailalbeTextModifier()
                                }
                                if selectedStation.chargers[i].isDCDemo {
                                    Text("DC데모")
                                        .availalbeTextModifier()
                                }
                                else {
                                    Text("DC데모")
                                        .unavailalbeTextModifier()
                                }
                                if selectedStation.chargers[i].isAC3 {
                                    Text("AC3상")
                                        .availalbeTextModifier()
                                }
                                else {
                                    Text("AC3상")
                                        .unavailalbeTextModifier()
                                }
                                if selectedStation.chargers[i].isACSlow {
                                    Text("완속")
                                        .availalbeTextModifier()
                                }
                                else {
                                    Text("완속")
                                        .unavailalbeTextModifier()
                                }
                                
                            }
                            if showingChargeTime {
                                let chargeTime = ChargeTimeToString(chargerStat: selectedStation.chargers[i].chargerStat,
                                                                    lastChargeDateTime: selectedStation.chargers[i].lastChargeDateTime,
                                                                    startChargeDateTime: selectedStation.chargers[i].startChargeDateTime)
                                Text(chargeTime)
                                    .font(.footnote)
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
    
    // convert charging start/end time to string
    func ChargeTimeToString(chargerStat: String, lastChargeDateTime: String, startChargeDateTime: String) -> String {
        let invalidDate = "2000-01-01"
        if lastChargeDateTime.contains(invalidDate) || startChargeDateTime.contains(invalidDate){
            return "데이터가 유효하지 않습니다"
        }
        
        var result = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-M-d H:m:s"
        
        if chargerStat == "CHARGING" {
            let startChargeDateTime = startChargeDateTime.replacingOccurrences(of: "T", with: " ")
            let startChargeDate:Date = dateFormatter.date(from: startChargeDateTime)!
            result = CalculateTime(ChargeDate: startChargeDate)
            result += "전에 충전이 시작되었습니다"
        }
        else {
            let lastChargeDateTime = lastChargeDateTime.replacingOccurrences(of: "T", with: " ")
            let lastChargeDate:Date = dateFormatter.date(from: lastChargeDateTime)!
            result = CalculateTime(ChargeDate: lastChargeDate)
            result += "전에 충전이 종료되었습니다"
        }
        
        return result
    }
    
    // calculate the charging start/end time
    func CalculateTime(ChargeDate: Date) -> String {
        var result = ""
        let distanceDate = Calendar.current.dateComponents([.year, .month, .day], from: ChargeDate, to: Date())
        
        if distanceDate.year! != 0 {
            result += "\(abs(distanceDate.year!))년 "
        }
        if distanceDate.month! != 0 {
            result += "\(abs(distanceDate.month!))월 "
        }
        if distanceDate.day! != 0 {
            result += "\(abs(distanceDate.day!))일 "
        }
        
        let distanceTime = Int(ChargeDate.timeIntervalSince(Date()))
        let distanceHour = abs((distanceTime % 86400) / 3600)
        let distanceMinute = abs((distanceTime % 3600) / 60)
        
        if distanceHour != 0 {
            result += "\(distanceHour)시간 "
        }
        result += "\(distanceMinute)분 "
        
        return result
    }
}

struct AvailableTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.blue)
    }
}

struct UnavailableTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body)
            .foregroundColor(.gray)
    }
}

extension View {
    func availalbeTextModifier() -> some View {
        modifier(AvailableTextModifier())
    }
}

extension View {
    func unavailalbeTextModifier() -> some View {
        modifier(UnavailableTextModifier())
    }
}

struct StationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StationDetailView()
    }
}
