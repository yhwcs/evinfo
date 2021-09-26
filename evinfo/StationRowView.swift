//
//  StationRowView.swift
//  evinfo
//
//  Created by yhw on 2021/09/26.
//

import SwiftUI

struct StationRowView: View {
    @Binding var stationListItem: StationListItem
    
    var body: some View {
        VStack{
            HStack{
                Text(stationListItem.stationName)
                    .font(.title3)
                    .foregroundColor(.green)
                Spacer()
            }
            HStack{
                Text(stationListItem.address)
                .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
            }
            if stationListItem.useTime.count > 0 {
                HStack{
                    Image(systemName: "clock")
                    Text(stationListItem.useTime)
                    .font(.callout)
                    Spacer()
                }
            }
            ForEach(0..<stationListItem.chargerItems.count){
            i in
                HStack{
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.green)
                    Text("\(stationListItem.chargerItems[i].id) : \(stationListItem.chargerItems[i].chargerStat)")
                    Spacer()
                }
            }
            Spacer()
        }
        // onTapGesture occurs even if press the blank space
        .background(Color.white)
        .onTapGesture {
            print(stationListItem.stationName)
        }
    }
}
/*
struct StationRowView_Previews: PreviewProvider {
    static var previews: some View {
        StationRowView(stationListItem: stationListItem())
    }
}
*/
