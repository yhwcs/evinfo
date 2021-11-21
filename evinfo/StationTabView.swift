//
//  StationTabView.swift
//  evinfo
//
//  Created by yhw on 2021/11/21.
//

import SwiftUI

struct StationTabView: View {
    @EnvironmentObject var selectedStation: StationListItem
    
    // current location for Kakao Map API
    @EnvironmentObject var startLocation: Location
    
    // dismiss view flag
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack{
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
            TabView{
                StationDetailView()
                    .environmentObject(selectedStation)
                    .environmentObject(startLocation)
                    .tabItem{
                        Image(systemName: "list.bullet.below.rectangle")
                        Text("상세 보기")
                    }
                NearbyMapView()
                    .tabItem{
                        Image(systemName: "cart")
                        Text("편의 시설")
                    }
                ReviewView()
                    .tabItem{
                        Image(systemName: "star")
                        Text("관련 리뷰")
                    }
            }
        }
    }
}

struct StationTabView_Previews: PreviewProvider {
    static var previews: some View {
        StationTabView()
    }
}
