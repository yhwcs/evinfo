//
//  ReviewRowView.swift
//  evinfo
//
//  Created by yhw on 2021/12/06.
//

import SwiftUI
import Foundation

struct ReviewRowView: View {
     var review: ReviewListItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Image(systemName: "star.fill")
                    .foregroundColor(.orange)
                Text("\(Int(review.star))")
            }
            Text("\(review.content)")
            Text("\(CreatedTimeToString(createdAt: review.createdAt))")
            .font(.subheadline)
            .foregroundColor(.gray)
        }
        .padding(5)
    }
    
    
    // convert review writing time to string
    func CreatedTimeToString(createdAt: String) -> String {
        var result = ""
        
        var createdTime = createdAt.replacingOccurrences(of: "T", with: " ")
        createdTime = createdTime.components(separatedBy: ".")[0]
        
        result = createdTime + " 작성"
        
        return result
    }
}

/*
struct ReviewRowView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewRowView()
    }
}
*/
