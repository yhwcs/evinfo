//
//  CarChargerTypeView.swift
//  evinfo
//
//  Created by yhw on 2021/11/26.
//

import SwiftUI

struct CarChargerTypeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("차종별 충전방식")
                .font(.title3)
                .foregroundColor(.green)
            Image("CarChargerTypeTable")
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .padding(20)
    }
}

struct CarChargerTypeView_Previews: PreviewProvider {
    static var previews: some View {
        CarChargerTypeView()
    }
}
