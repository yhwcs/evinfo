//
//  MapView.swift
//  evinfo
//
//  Created by yhw on 2021/09/17.
//

import SwiftUI
import MapKit
import PartialSheet

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
    @StateObject var startLocation = Location()
    
    // user tracking mode
    @State var trackingMode: MapUserTrackingMode = .none
    
    // station list view flag
    @State private var showingStationListSheet = false
    // station simple view flag
    @State private var showingStationSimpleSheet = false

    @EnvironmentObject var stationList: StationList
    
    // clicked station marker(pin)
    @StateObject var selectedStation = StationListItem()
    
    // partial sheet (Station List / Simple View) manager
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region, interactionModes: .all, showsUserLocation: true, userTrackingMode: .constant(trackingMode), annotationItems: stationList.items) {
                items in
                StationAnnotationProtocol(MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: items.latitude, longitude: items.longitude)) {
                    // Station that can charge
                    if items.enableChargers > 0 {
                    Image(systemName: "mappin.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.green)
                        .onTapGesture {
                            selectedStation.copyStation(toItem: selectedStation, fromItem: items)
                            showingStationSimpleSheet = true
                            print(items.stationName)
                        }
                    }
                    // Station that cannot charge
                    else if items.enableChargers == 0 {
                        Image(systemName: "mappin.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                            .onTapGesture {
                                selectedStation.copyStation(toItem: selectedStation, fromItem: items)
                                showingStationSimpleSheet = true
                                print(items.stationName)
                            }
                    }
                    // Station that cannot check
                    else {
                        Image(systemName: "mappin.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.orange)
                            .onTapGesture {
                                selectedStation.copyStation(toItem: selectedStation, fromItem: items)
                                showingStationSimpleSheet = true
                                print(items.stationName)
                            }
                    }
                })
            }
            .partialSheet(isPresented: $showingStationSimpleSheet){
                StationSimpleView()
                    .environmentObject(selectedStation)
                    .environmentObject(startLocation)
            }
            .addPartialSheet()
            .onAppear(){
                curLocation = LocationHelper.currentLocation
                region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: curLocation.latitude, longitude: curLocation.longitude), span: MKCoordinateSpan(latitudeDelta: MapDefault.zoom, longitudeDelta: MapDefault.zoom))
                print(curLocation)
                stationList.getStationInfo(latitude: curLocation.latitude, longitude: curLocation.longitude, size: 40)
                startLocation.setLocation(lat: curLocation.latitude, long: curLocation.longitude)
            }
            
            if showingStationSimpleSheet == false && showingStationListSheet == false {
                VStack(spacing: 10){
                    Spacer()
                    HStack(spacing: 10){
                        // showing station list view button
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
                        .partialSheet(isPresented: $showingStationListSheet){
                            StationListView()
                                .environmentObject(stationList)
                                .environmentObject(selectedStation)
                                .environmentObject(startLocation)
                        }
                        Spacer()
                        
                        // refresh button
                        Button(action: {
                            curLocation = LocationHelper.currentLocation
                            region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: curLocation.latitude, longitude: curLocation.longitude), span: MKCoordinateSpan(latitudeDelta: MapDefault.zoom, longitudeDelta: MapDefault.zoom))
                            stationList.clearStationList()
                            stationList.getStationInfo(latitude: curLocation.latitude, longitude: curLocation.longitude, size: 40)
                            startLocation.setLocation(lat: curLocation.latitude, long: curLocation.longitude)
                            print("refresh")
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                        .font(.system(size:25))
                        .foregroundColor(.blue)
                        .frame(width: 40, height: 40)
                        .background(Color.white)
                        .cornerRadius(10)

                        // user tracking mode button
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
        }
    } // End of body
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

