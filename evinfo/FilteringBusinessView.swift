//
//  FilteringBusinessView.swift
//  evinfo
//
//  Created by yhw on 2021/12/02.
//

import SwiftUI

struct FilteringBusinessView: View {
    
    @EnvironmentObject var businessList: BusinessList
    
    @State private var isAllChecked = true
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 30){
            VStack(alignment: .leading, spacing: 10){
                
                Button(action: {
                    selectAll()
                    isAllChecked.toggle()
                }){
                    HStack{
                        Text(isAllChecked ? "☑️" : "⬜️")
                        Text("전체")
                            .foregroundColor(.black)
                            .font(.subheadline)
                    }
                }
                
                ForEach(0..<(businessList.items.count+1)/2) { i in
                    Toggle("\(businessList.items[2*i].businessName)",
                           isOn: $businessList.items[2*i].isChecked)
                        .onChange(of: businessList.items[2*i].isChecked) { value in
                            self.isAllChecked = checkAll()
                        }
                        .toggleStyle(CheckToggleStyle())
                }
            }
            
            VStack(alignment: .leading, spacing: 10){
                ForEach(0..<businessList.items.count/2) { i in
                    Toggle("\(businessList.items[2*i+1].businessName)",
                           isOn: $businessList.items[2*i+1].isChecked)
                        .onChange(of: businessList.items[2*i+1].isChecked) { value in
                            self.isAllChecked = checkAll()
                        }
                        .toggleStyle(CheckToggleStyle())
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
    
    func checkAll() -> Bool {
        var isAllChecked: Bool = true
        
        for i in 0..<businessList.items.count {
            if businessList.items[i].isChecked == false {
                isAllChecked = false
            }
        }
        
        return isAllChecked
    }
    
    func selectAll() {
        let isAllChecked = checkAll()
        
        if isAllChecked {
            for i in 0..<businessList.items.count {
                businessList.items[i].isChecked = false
            }
        }
        else{
            for i in 0..<businessList.items.count {
                businessList.items[i].isChecked = true
            }
        }
    }
}

struct CheckToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            Label {
                configuration.label
                    .foregroundColor(.black)
                    .font(.subheadline)
            } icon: {
                Text(configuration.isOn ? "☑️" : "⬜️")
            }
        }
    }
}

/*
struct FilteringBusinessView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringBusinessView()
    }
}
*/
