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
                        VStack{
                            Text(items.name)
                                .font(.caption2)
                            Image(systemName: "mappin.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .foregroundColor(.blue)
                        .onTapGesture {
                            selectedLocation.copyLocation(
                                toItem: selectedLocation,
                                fromItem: items)
                            showingLocationSimpleSheet = true
                        }
                    }
                    // selected station
                    else {
                        Image(systemName: "mappin.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.red)
                    }
                })
            }
            /*
            .sheet(isPresented: $showingLocationSimpleSheet){
                LocationRowView(selectedLocation: $selectedLocation)
            }
             */
            /*
            .partialSheet(isPresented: $showingLocationSimpleSheet){
                LocationRowView(selectedLocation: $selectedLocation)
            }
             */
            //.addPartialSheet()
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
                                                placeUrl: "NULL")
                locationList.items.append(selectedStationItem)
            }
            VStack(spacing: 10){
                HStack(spacing: 30){
                    Spacer()
                    VStack{
                        Image(systemName: "leaf")
                            .resizable()
                            .imageSizeModifier()
                        Text("카페")
                            .font(.callout)
                    }
                    VStack{
                        Image(systemName: "cart")
                            .resizable()
                            .imageSizeModifier()
                        Text("대형마트")
                            .font(.callout)
                    }
                    VStack{
                        Image(systemName: "24.square")
                            .resizable()
                            .imageSizeModifier()
                        Text("편의점")
                            .font(.callout)
                    }
                    VStack{
                        Image(systemName: "building.columns")
                            .resizable()
                            .imageSizeModifier()
                        Text("문화시설")
                            .font(.callout)
                    }
                    Spacer()
                }.background(Color.white)
                .padding(.bottom, 10)
                
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
            .frame(width: 20, height: 20)
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
