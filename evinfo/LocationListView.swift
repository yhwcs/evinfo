//
//  LocationListView.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//

import SwiftUI

struct LocationListView: View {
    
    @EnvironmentObject var locationList: LocationList
    
    @State private var showingCafe = true
    @State private var showingMart = false
    @State private var showingStore = false
    @State private var showingCultureFacilities = false
    
    var body: some View {
        VStack(spacing: 10){
        HStack(spacing: 40){
            Spacer()
            VStack{
                if self.showingCafe {
                    Image(systemName: "leaf")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.green)
                }
                else {
                    Image(systemName: "leaf")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.gray)
                }
                Text("카페")
                    .font(.footnote)
            }
            .onTapGesture{
                self.showingCafe.toggle()
                if self.showingCafe {
                    self.showingMart = false
                    self.showingStore = false
                    self.showingCultureFacilities = false
                }
            }
            VStack{
                if self.showingMart {
                    Image(systemName: "cart")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.orange)
                }
                else{
                    Image(systemName: "cart")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.gray)
                }
                Text("대형마트")
                    .font(.footnote)
            }
            .onTapGesture{
                self.showingMart.toggle()
                if self.showingMart {
                    self.showingCafe = false
                    self.showingStore = false
                    self.showingCultureFacilities = false
                }
            }
            VStack{
                if self.showingStore {
                    Image(systemName: "24.square")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.blue)
                }
                else{
                    Image(systemName: "24.square")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.gray)
                }
                Text("편의점")
                    .font(.footnote)
            }
            .onTapGesture{
                self.showingStore.toggle()
                if self.showingStore {
                    self.showingCafe = false
                    self.showingMart = false
                    self.showingCultureFacilities = false
                }
            }
            VStack{
                if self.showingCultureFacilities {
                    Image(systemName: "building.columns")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.yellow)
                }
                else{
                    Image(systemName: "building.columns")
                        .resizable()
                        .imageSizeModifier()
                        .foregroundColor(.gray)
                }
                Text("문화시설")
                    .font(.footnote)
            }
            .onTapGesture{
                self.showingCultureFacilities.toggle()
                if self.showingCultureFacilities {
                    self.showingCafe = false
                    self.showingMart = false
                    self.showingStore = false
                }
            }
            Spacer()
        }
        .padding(.top, 20)
        List{
            ForEach(0..<locationList.items.count){
            index in
                if showingCafe && locationList.items[index].category == "CE7" ||
                    showingMart && locationList.items[index].category == "MT1" ||
                    showingStore && locationList.items[index].category == "CS2" ||
                    showingCultureFacilities && locationList.items[index].category == "CT1" {
                    LocationRowView(selectedLocation: $locationList.items[index])
                }
            }
        } // End of List
        }
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
