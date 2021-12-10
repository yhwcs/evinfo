//
//  NearbyMapView.swift
//  evinfo
//
//  Created by yhw on 2021/11/21.
//

import SwiftUI
import MapKit
import PartialSheet

struct NearbyMapView: View {
    
    // initialize region
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: MapDefault.latitude,
            longitude: MapDefault.longitude),
        span: MKCoordinateSpan(
            latitudeDelta: MapDefault.zoom,
            longitudeDelta: MapDefault.zoom))
    
    // default region
    private enum MapDefault {
        static let latitude = 37.55108
        static let longitude = 126.94096
        static let zoom = 0.005
    }
    
    @EnvironmentObject var selectedStation: StationListItem
    @StateObject var selectedStationItem = LocationListItem()
    
    @State var selectedLocation = LocationListItem()
    
    @EnvironmentObject var locationList: LocationList
    
    // location simple view flag
    @State private var showingLocationSimpleSheet = false
    
    // location list view flag
    @State private var showingLocationListSheet = false
    
    @State private var showingCafe = true
    @State private var showingMart = true
    @State private var showingStore = true
    @State private var showingCultureFacilities = true
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $region,
                interactionModes: .all,
                showsUserLocation: true,
                annotationItems: locationList.items) {
                items in
                StationAnnotationProtocol(
                    MapAnnotation(
                        coordinate: CLLocationCoordinate2D(
                            latitude: items.latitude,
                            longitude: items.longitude)) {
                    // locations
                    if items.distance != 0.0 {
                        if showingCafe && items.category == "CE7" {
                            VStack{
                                Text(items.name)
                                    .font(.caption2)
                                Image(systemName: "leaf")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .foregroundColor(.green)
                            /*
                            .onTapGesture {
                                selectedLocation.copyLocation(
                                    toItem: selectedLocation,
                                    fromItem: items)
                                showingLocationSimpleSheet = true
                            }
                            */
                        }
                        if showingMart && items.category == "MT1" {
                            VStack{
                                Text(items.name)
                                    .font(.caption2)
                                Image(systemName: "cart")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .foregroundColor(.orange)
                        }
                        if showingStore && items.category == "CS2" {
                            VStack{
                                Text(items.name)
                                    .font(.caption2)
                                Image(systemName: "24.square")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .foregroundColor(.blue)
                        }
                        if showingCultureFacilities && items.category == "CT1" {
                            VStack{
                                Text(items.name)
                                    .font(.caption2)
                                Image(systemName: "building.columns")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                            .foregroundColor(.yellow)
                        }
                    }
                    // selected station
                    else {
                        Image(systemName: "mappin.and.ellipse")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                })
            }
            .onAppear(){
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: selectedStation.latitude,
                        longitude: selectedStation.longitude),
                    span: MKCoordinateSpan(
                        latitudeDelta: MapDefault.zoom,
                        longitudeDelta: MapDefault.zoom))
                selectedStationItem.setLocation(name: selectedStation.stationName,
                                                latitude: selectedStation.latitude,
                                                longitude: selectedStation.longitude,
                                                distance: 0.0,
                                                callNumber: selectedStation.callNumber,
                                                address: selectedStation.address,
                                                placeUrl: "NULL",
                                                category: "NULL")
                locationList.items.append(selectedStationItem)
            }
            VStack(spacing: 10){
                HStack(spacing: 40){
                    VStack{
                        if showingCafe {
                            Image(systemName: "leaf")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.green)
                        }
                        else {
                            Image(systemName: "leaf")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.gray)
                        }
                        Text("카페")
                            .font(.footnote)
                    }
                    .onTapGesture{
                        self.showingCafe.toggle()
                    }
                    VStack{
                        if showingMart {
                            Image(systemName: "cart")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.orange)
                        }
                        else{
                            Image(systemName: "cart")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.gray)
                        }
                        Text("대형마트")
                            .font(.footnote)
                    }
                    .onTapGesture{
                        self.showingMart.toggle()
                    }
                    VStack{
                        if showingStore {
                            Image(systemName: "24.square")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.blue)
                        }
                        else{
                            Image(systemName: "24.square")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.gray)
                        }
                        Text("편의점")
                            .font(.footnote)
                    }
                    .onTapGesture{
                        self.showingStore.toggle()
                    }
                    VStack{
                        if showingCultureFacilities {
                            Image(systemName: "building.columns")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.yellow)
                        }
                        else{
                            Image(systemName: "building.columns")
                                .resizable()
                                .imageSizeModifier()
                                .foregroundColor(.gray)
                        }
                        Text("문화시설")
                            .font(.footnote)
                    }
                    .onTapGesture{
                        self.showingCultureFacilities.toggle()
                    }
                }
                .padding(10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .background(Color.white)
                .cornerRadius(20)
                .padding(.top, 10)
                
                Spacer()
                
                HStack(){
                    // showing location list view button
                    Button(action: {
                        showingLocationListSheet = true
                    }) {
                        Image(systemName: "list.bullet")
                    }
                    .buttonStyle(NormalButtonStyle())
                    .sheet(isPresented: $showingLocationListSheet){
                        LocationListView()
                            .environmentObject(locationList)
                    }
                    Spacer()
                }.padding()
            }
        }
    }
}

struct NormalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size:25))
            .foregroundColor(.blue)
            .frame(width: 40, height: 40)
            .background(Color.white)
            .cornerRadius(10)
    }
}

struct ImageSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFit()
            .frame(width: 30)
    }
}

extension View {
    func imageSizeModifier() -> some View {
        modifier(ImageSizeModifier())
    }
}

/*
struct NearbyMapView_Previews: PreviewProvider {
    static var previews: some View {
        NearbyMapView()
    }
}
 */
