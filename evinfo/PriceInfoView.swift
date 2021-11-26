//
//  PriceInfoView.swift
//  evinfo
//
//  Created by yhw on 2021/11/26.
//

import SwiftUI

struct PriceInfoView: View {
    var body: some View {
        ScrollView{
        VStack(alignment: .leading, spacing: 15){
            Group{
                Text("이용 요금")
                    .font(.title3)
                    .foregroundColor(.green)
                Text("● 운영기관별 이용 요금")
                    .font(.headline)
                Image("BusinessPriceTable")
                    .resizable()
                    .scaledToFit()
                Text("● 아파트용 충전소")
                    .font(.headline)
                Text("• 이용 요금")
                Image("ApartmentPriceTable")
                    .resizable()
                    .scaledToFit()
                Text("• 이용 요금 적용구간별 시간대 구분")
                Image("TimePriceTable")
                    .resizable()
                    .scaledToFit()
                Text("• 제주특별자치도 별도 구분")
                Image("TimePriceJejuTable")
                    .resizable()
                    .scaledToFit()
                }
            Text("● 충전 사업자간 로밍 요금")
                .font(.headline)
            Image("RoamingPriceTable")
                .resizable()
                .scaledToFit()
            Spacer()
        }.padding(20)
    }
    }
}

struct PriceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        PriceInfoView()
    }
}
