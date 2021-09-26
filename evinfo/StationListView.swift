//
//  StationListView.swift
//  evinfo
//
//  Created by yhw on 2021/09/25.
//

import SwiftUI

struct StationListView: View {
    @EnvironmentObject var chargerList: ChargerList
    @EnvironmentObject var stationList: StationList
    
    // dismiss view flag
    @Environment(\.presentationMode) var presentationMode
    
    @State var stationListCount = 0
    
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
            // show station list
            List{
                VStack{
                    ForEach(0..<stationListCount){
                    index in
                        StationRowView(stationListItem: $stationList.items[index])
                    } // End of ForEach
                }
            }
        }
        .onAppear() {
            stationList.clearStationList()
            stationList.getStationInfo(chargerList: chargerList)
            print(stationList.items.count)
            stationListCount = stationList.items.count
        }
    } // End of View
}
/*
struct StationListView_Previews: PreviewProvider {
    static var previews: some View {
        StationListView(chargerList: ChargerList())
    }
}
*/
