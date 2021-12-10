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
        static let zoom = 0.05
        static let size = 40
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
    // filtering charger type view flag
    @State private var showingFilteringChargerSheet = false
    // filtering business view flag
    @State private var showingFilteringBusinessSheet = false

    @EnvironmentObject var stationList: StationList
    
    @StateObject var businessList = BusinessList()
    
    // clicked station marker(pin)
    @StateObject var selectedStation = StationListItem()
    
    // partial sheet (Station List / Simple View) manager
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    
    // charger type chosen by the user
    @StateObject var customChargerTypes = CustomChargerTypes()
    
    // time to show the loading view
    @State var timeRemaining = 5
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var menuOpen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Map(coordinateRegion: $region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    userTrackingMode: .constant(trackingMode),
                    annotationItems: stationList.items) {
                    items in
                    StationAnnotationProtocol(
                        MapAnnotation(
                            coordinate: CLLocationCoordinate2D(
                                latitude: items.latitude,
                                longitude: items.longitude)) {
                        // Station that can charge
                        if items.enableChargers > 0 {
                        Image(systemName: "mappin.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.green)
                            .onTapGesture {
                                selectedStation.copyStation(
                                    toItem: selectedStation,
                                    fromItem: items)
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
                                    selectedStation.copyStation(
                                        toItem: selectedStation,
                                        fromItem: items)
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
                                    selectedStation.copyStation(
                                        toItem: selectedStation,
                                        fromItem: items)
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
                    refreshCurLocation()
                    print(curLocation)
                    refreshStationList()
                }
                
                if showingStationSimpleSheet == false && showingStationListSheet == false {
                    SideBarStack(sidebarWidth: 250, showSidebar: $menuOpen){
                        MenuContent()
                    } content: {
                    VStack(spacing: 10){
                        HStack(spacing: 5){
                            // company filtering
                            Button(action: {
                                if self.showingFilteringBusinessSheet {
                                    stationList.clearStationList()
                                    stationList.getFilteredStationInfo(latitude: curLocation.latitude,
                                                                       longitude: curLocation.longitude,
                                                                       size: MapDefault.size,
                                                                       businessList: businessList)
                                    self.timeRemaining = 5
                                }
                                self.showingFilteringBusinessSheet.toggle()
                            }) {
                                if self.showingFilteringBusinessSheet == false {
                                    HStack{
                                        Image(systemName: "building.2.fill")
                                        Text("운영 기관 ▼")
                                    }
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                }
                                else {
                                    HStack{
                                        Image(systemName: "building.2.fill")
                                        Text("운영 기관 ▲")
                                    }
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                }
                            }
                            .buttonStyle(RoundedRectangleButtonStyle())
                            .disabled(self.showingFilteringChargerSheet == true)
                            // charger type filtering
                            Button(action: {
                                if self.showingFilteringChargerSheet {
                                    refreshStationList()
                                }
                                self.showingFilteringChargerSheet.toggle()
                            }) {
                                if self.showingFilteringChargerSheet == false {
                                    HStack{
                                        Image(systemName: "bolt.fill")
                                        Text("충전 타입 ▼")
                                    }
                                    .padding(10)
                                    .foregroundColor(.black)
                                    .background(Color.white)
                                }
                                else {
                                    HStack{
                                        Image(systemName: "bolt.fill")
                                        Text("충전 타입 ▲")
                                    }
                                    .padding(10)
                                    .foregroundColor(.white)
                                    .background(Color.green)
                                }
                            }
                            .buttonStyle(RoundedRectangleButtonStyle())
                            .disabled(self.showingFilteringBusinessSheet == true)
                        }
                        if self.showingFilteringChargerSheet == true && self.showingFilteringBusinessSheet == false {
                            FilteringChargerTypeView()
                                .environmentObject(customChargerTypes)
                        }
                        
                        if self.showingFilteringBusinessSheet == true && self.showingFilteringChargerSheet == false {
                            FilteringBusinessView()
                                .environmentObject(businessList)
                        }
                        
                        Spacer()
                        // loading to communicate with the server
                        if self.timeRemaining > 0 {
                            LottieView(filename: "Loading")
                                .frame(width: 200, height: 200)
                                .onReceive(timer) {_ in
                                    if self.timeRemaining > 0 {
                                        self.timeRemaining -= 1
                                    }
                                }
                        }
                        
                        Spacer()
                        HStack(spacing: 10){
                            // showing station list view button
                            Button(action: {
                                showingStationListSheet = true
                            }) {
                                Image(systemName: "list.bullet")
                            }
                            .buttonStyle(NormalButtonStyle())
                            .partialSheet(isPresented: $showingStationListSheet){
                                StationListView()
                                    .environmentObject(stationList)
                                    .environmentObject(selectedStation)
                                    .environmentObject(startLocation)
                            }
                            Spacer()
                            
                            // refresh button
                            Button(action: {
                                refreshCurLocation()
                                refreshStationList()
                                print("refresh")
                            }) {
                                Image(systemName: "arrow.clockwise")
                            }
                            .buttonStyle(NormalButtonStyle())

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
                            .buttonStyle(NormalButtonStyle())
                        }
                    }
                    .padding()
                    // End of VStack
                }
            }
        } // End of ZStack
        .navigationBarTitle("EV Finder", displayMode: .inline)
        .navigationBarItems(leading: (
            Button(action: {
                withAnimation{
                    self.menuOpen.toggle()
                }
            }) {
                Image(systemName: "book")
                    .imageScale(.large)
            }
        ))
        } // End of Navigation View
    } // End of body
    
    func refreshCurLocation(){
        curLocation = LocationHelper.currentLocation
        region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: curLocation.latitude,
                longitude: curLocation.longitude),
            span: MKCoordinateSpan(
                latitudeDelta: MapDefault.zoom,
                longitudeDelta: MapDefault.zoom))
        startLocation.setLocation(
            lat: curLocation.latitude,
            long: curLocation.longitude)
    }
    
    func refreshStationList(){
        stationList.clearStationList()
        stationList.getStationInfo(
            latitude: curLocation.latitude,
            longitude: curLocation.longitude,
            size: MapDefault.size,
            isDCCombo: customChargerTypes.isDCCombo,
            isDCDemo: customChargerTypes.isDCDemo,
            isAC3: customChargerTypes.isAC3,
            isACSlow: customChargerTypes.isACSlow)
        self.timeRemaining = 5
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
    
    struct RoundedRectangleButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .cornerRadius(30)
                .padding(10)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

