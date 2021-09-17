//
//  MapView.swift
//  evinfo
//
//  Created by yhw on 2021/09/17.
//

import SwiftUI
import MapKit

struct MapView: View {
    // initialize region
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: MapDefault.latitude, longitude: MapDefault.longitude), span: MKCoordinateSpan(latitudeDelta: MapDefault.zoom, longitudeDelta: MapDefault.zoom))
    
    // default region
    private enum MapDefault {
        static let latitude = 37.55108
        static let longitude = 126.94096
        static let zoom = 0.05
    }
    
    // current location
    @State private var cur_location = LocationHelper.currentLocation
    // user tracking mode
    @State var trackingMode: MapUserTrackingMode = .none
    // @EnvironmentObject var curLocation: Location
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(trackingMode))
                    .onAppear(){
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cur_location.latitude, longitude: cur_location.longitude), span: MKCoordinateSpan(latitudeDelta: MapDefault.zoom, longitudeDelta: MapDefault.zoom))
                        print(cur_location)
                    }

            // user tracking mode button
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        if trackingMode == .none {
                            trackingMode = .follow
                        }
                        else {
                            trackingMode = .none
                        }
                    }) {
                        Image(systemName: "location.fill")
                    }
                    .font(.system(size:25))
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    } // End of body
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

