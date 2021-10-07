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
    @State private var curLocation = LocationHelper.currentLocation
    
    // user tracking mode
    @State var trackingMode: MapUserTrackingMode = .none
    
    // station list view flag
    @State private var showingStationListSheet = false

    @EnvironmentObject var chargerList: ChargerList
    @EnvironmentObject var stationList: StationList
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(trackingMode), annotationItems: chargerList.items) {
                items in
                MapMarker(coordinate: CLLocationCoordinate2D(latitude: items.lat, longitude: items.lng), tint: Color.purple)
            }
            .onAppear(){
                curLocation = LocationHelper.currentLocation
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: curLocation.latitude, longitude: curLocation.longitude), span: MKCoordinateSpan(latitudeDelta: MapDefault.zoom, longitudeDelta: MapDefault.zoom))
                print(curLocation)
                chargerList.getStationInformation(latitude: curLocation.latitude, longitude: curLocation.longitude, size: 30)
            }

            // user tracking mode button
            VStack(spacing: 10){
                Spacer()
                HStack{
                    Spacer()
                    Button(action: {
                        showingStationListSheet = true
                    }) {
                        Image(systemName: "list.bullet")
                    }
                    .font(.system(size:25))
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .cornerRadius(10)
                    .fullScreenCover(isPresented: $showingStationListSheet, content: {
                        StationListView().environmentObject(chargerList)
                            .environmentObject(stationList)
                    })
                }
                HStack{
                    Spacer()
                    Button(action: {
                        chargerList.clearChargerList()
                        curLocation = LocationHelper.currentLocation
                        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: curLocation.latitude, longitude: curLocation.longitude), span: MKCoordinateSpan(latitudeDelta: MapDefault.zoom, longitudeDelta: MapDefault.zoom))
                        chargerList.getStationInformation(latitude: curLocation.latitude, longitude: curLocation.longitude, size: 30)
                    }) {
                        Image(systemName: "arrow.clockwise")
                    }
                    .font(.system(size:25))
                    .foregroundColor(.blue)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .cornerRadius(10)
                }
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
                        if trackingMode == .none {
                            Image(systemName: "location.fill")
                        }
                        else {
                            Image(systemName: "location")
                        }
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

