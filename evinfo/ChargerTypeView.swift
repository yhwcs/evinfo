//
//  ChargerTypeView.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//

import SwiftUI

struct ChargerTypeView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 15){
            Text("전기차 충전기 종류")
                .font(.title3)
                .foregroundColor(.green)
            Image("ChargerTypeTable")
                .resizable()
                .scaledToFit()
            Spacer()
        }
        .padding(20)
    }
}

struct ChargerTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ChargerTypeView()
    }
}
