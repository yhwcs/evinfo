//
//  FiteringChargerTypeView.swift
//  evinfo
//
//  Created by yhw on 2021/11/04.
//

import SwiftUI

struct FilteringChargerTypeView: View {
    
    @EnvironmentObject var customChargerTypes: CustomChargerTypes
    
    var body: some View {
        HStack(alignment:.bottom, spacing: 30){
            VStack(alignment: .leading, spacing: 10){
                Button(action: {
                    selectAll()
                }){
                    HStack{
                        Text(checkAll() ? "☑️" : "⬜️")
                        Text("전체").foregroundColor(.black)
                    }
                }
                // DC Combo
                Button(action: {
                    customChargerTypes.isDCCombo.toggle()
                }){
                    HStack{
                        Text(customChargerTypes.isDCCombo ? "☑️" : "⬜️")
                        Text("DC콤보").foregroundColor(.black)
                    }
                }
                // AC3
                Button(action: {
                    customChargerTypes.isAC3.toggle()
                }){
                    HStack{
                        Text(customChargerTypes.isAC3 ? "☑️" : "⬜️")
                        Text("AC3상").foregroundColor(.black)
                    }
                }
                
            }
            VStack(alignment: .leading, spacing: 10){
                // DC Demo
                Button(action: {
                    customChargerTypes.isDCDemo.toggle()
                }){
                    HStack{
                        Text(customChargerTypes.isDCDemo ? "☑️" : "⬜️")
                        Text("DC차데모").foregroundColor(.black)
                    }
                }
                // AC Slow
                Button(action: {
                    customChargerTypes.isACSlow.toggle()
                }){
                    HStack{
                        Text(customChargerTypes.isACSlow ? "☑️" : "⬜️")
                        Text("AC완속").foregroundColor(.black)
                    }
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
    }
    
    func checkAll() -> Bool {
        var isAllChecked: Bool = true
        
        if customChargerTypes.isDCCombo && customChargerTypes.isDCDemo && customChargerTypes.isAC3 && customChargerTypes.isACSlow {
            isAllChecked = true
        }
        else {
            isAllChecked = false
        }
        
        return isAllChecked
    }
    
    func selectAll(){
        let isAllChecked = checkAll()
        
        if isAllChecked {
            customChargerTypes.isDCCombo = false
            customChargerTypes.isDCDemo = false
            customChargerTypes.isAC3 = false
            customChargerTypes.isACSlow = false
        }
        else {
            customChargerTypes.isDCCombo = true
            customChargerTypes.isDCDemo = true
            customChargerTypes.isAC3 = true
            customChargerTypes.isACSlow = true
        }
    }
}

struct FiteringChargerTypeView_Previews: PreviewProvider {
    static var previews: some View {
        FilteringChargerTypeView()
    }
}
