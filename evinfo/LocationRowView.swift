//
//  LocationRowView.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//

import SwiftUI

struct LocationRowView: View {
    @Binding var selectedLocation: LocationListItem
    
    var body: some View {
        VStack(spacing: 10){
            HStack{
                Text(selectedLocation.name)
                    .font(.title3)
                    .foregroundColor(.green)
                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.top, 10)
            HStack{
                Text(selectedLocation.address)
                .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.horizontal, 20)
            HStack{
                if selectedLocation.distance < 1000.0 {
                    Text("\(Int(round(selectedLocation.distance)))m")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                else {
                    Text(String(format: "%.1f", selectedLocation.distance/1000.0) + "km")
                        .font(.callout)
                        .foregroundColor(.red)
                }
                Spacer()
            }.padding(.horizontal, 20)
            HStack{
                Image(systemName: "phone.fill")
                Text(selectedLocation.callNumber)
                    .font(.callout)
                    .foregroundColor(.blue)
                    .onTapGesture(){
                        CallBusiness(callNumber: selectedLocation.callNumber)
                    }
                Spacer()
                Button(action: {
                    callKMapForPlace(placeUrl: selectedLocation.placeUrl)
                }){
                    Text("상세정보")
                        .padding(10)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(30)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 10)
        }
        .background(Color.white)
    }
    
    func callKMapForPlace(placeUrl: String){
        let url = URL(string: placeUrl)!
        let appStoreURL = URL(string: "http://itunes.apple.com/app/id304608425")!
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.open(appStoreURL)
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

/*
struct LocationSimpleView_Previews: PreviewProvider {
    static var previews: some View {
        LocationRowView()
    }
}
 */
