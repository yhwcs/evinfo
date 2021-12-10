//
//  ReviewView.swift
//  evinfo
//
//  Created by yhw on 2021/11/21.
//

import SwiftUI

struct ReviewView: View {
    
    @EnvironmentObject var selectedStation: StationListItem
    
    @EnvironmentObject var reviewList: ReviewList
    
    // add review view flag
    @State private var showingAddReviewSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(selectedStation.stationName)
                    .font(.title3)
                    .foregroundColor(.blue)
                Spacer()
            }
            HStack(spacing: 5){
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                Text(String(format: "%.1f", calculateAverage(reviewList: reviewList)) + " / 5")
                Text("   리뷰 \(reviewList.items.count)")

                Spacer()
                Button(action: {
                    showingAddReviewSheet = true
                    
                }) {
                    Image(systemName: "square.and.pencil")
                    Text("리뷰 작성")
                }
            }
            
            List(reviewList.items) { review in
                ReviewRowView(review: review)
            }
            .listStyle(.insetGrouped)
        }
        .padding()
            .sheet(isPresented: $showingAddReviewSheet){
                AddReviewView()
                    .environmentObject(selectedStation)
            }
    }
    
    func calculateAverage(reviewList: ReviewList) -> Double {
        var sum: Double = 0.0
        for i in 0..<reviewList.items.count {
            sum += reviewList.items[i].star
        }
        
        if reviewList.items.count == 0 {
            return 0.0
        }
        else {
            return sum / Double(reviewList.items.count)
        }
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView()
    }
}
