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
    
    let locationCategories = ["카페", "마트", "편의점", "문화시설"]
    
    @State private var selectedLocationCategory = "카페"
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.gray
        
        let attributes: [NSAttributedString.Key:Any] = [
            .foregroundColor : UIColor.white
        ]
        UISegmentedControl.appearance().setTitleTextAttributes(attributes, for: .selected)
    }
    
    var body: some View {
        VStack(spacing: 10){
            Form{
                Picker(selection: $selectedLocationCategory,
                       label: Text("주변 편의 시설"),
                       content: {
                        ForEach(locationCategories.indices) { index in
                                Text(locationCategories[index])
                                .tag(locationCategories[index])
                        }
                })
                .onChange(of: selectedLocationCategory) { value in
                    if value == locationCategories[0] {
                        self.showingCafe = true
                        self.showingMart = false
                        self.showingStore = false
                        self.showingCultureFacilities = false
                    }
                    else if value == locationCategories[1] {
                        self.showingCafe = false
                        self.showingMart = true
                        self.showingStore = false
                        self.showingCultureFacilities = false
                    }
                    else if value == locationCategories[2] {
                        self.showingCafe = false
                        self.showingMart = false
                        self.showingStore = true
                        self.showingCultureFacilities = false
                    }
                    else {
                        self.showingCafe = false
                        self.showingMart = false
                        self.showingStore = false
                        self.showingCultureFacilities = true
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

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
            } // End of Form
        } // End of VStack
    }
}

struct LocationListView_Previews: PreviewProvider {
    static var previews: some View {
        LocationListView()
    }
}
