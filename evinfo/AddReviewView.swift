//
//  AddReviewView.swift
//  evinfo
//
//  Created by yhw on 2021/12/06.
//

import SwiftUI
import Lottie
import MapKit

struct AddReviewView: View {
    
    @EnvironmentObject var selectedStation: StationListItem
    @EnvironmentObject var reviewList: ReviewList
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var content:String = ""
    @State var rating: Int = 1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Form{
                HStack{
                    Image(systemName: "square.and.pencil")
                    Text("리뷰 작성")
                        .font(.headline)
                }
                ZStack{
                    starView
                        .overlay(overlayView
                                    .mask(starView))
                }
                TextEditor(text: $content)
                    .textFieldStyle(.roundedBorder)
                HStack{
                    Text("\(content.count)/140 자")
                        .font(.subheadline)
                    Spacer()
                    Button(action: {
                        let review = ReviewItem(content: self.content,
                                                star: Double(rating),
                                                stationId: selectedStation.stationId)
                        sendPostReques(review: review)
                        print(selectedStation.reviews.count)
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }.disabled(content.count == 0 || content.count > 140)
                }
            }
        }
        .onDisappear {
            print("review count: \(selectedStation.reviews.count)")
            reviewList.clearReviewList()
            reviewList.getReviewInfo(stationId: selectedStation.stationId)
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geo in
            Rectangle()
                .fill(Color.yellow)
                .frame(width: CGFloat(rating) / 5 * geo.size.width)
        }
        .allowsHitTesting(false)
    }
    
    private var starView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.title)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.3)) {
                            rating = index
                        }
                    }
            }
        }
    }
    
    // request the server to post a review
    func sendPostReques (review: ReviewItem) {
        guard let url = URL(string: "http://ec2-3-35-112-56.ap-northeast-2.compute.amazonaws.com:8080/api/reviews") else { return }
            
        guard let jsonData = try? JSONEncoder().encode(review) else {
            print("Error: Trying to convert model to JSON data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the response expected to be in JSON format
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = jsonData
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling POST")
                print(error!)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }.resume()
    }
}

struct AddReviewView_Previews: PreviewProvider {
    static var previews: some View {
        AddReviewView()
    }
}
