//
//  SideMenuView.swift
//  evinfo
//
//  Created by yhw on 2021/11/25.
//

import SwiftUI

struct MenuContent: View {
    @State private var showingChargerType = false
    @State private var showingPriceInfo = false
    @State private var showingCarChargerType = false
    
    var body: some View {
        List {
            Text("충전기 타입")
                .onTapGesture {
                    showingChargerType = true
                }
            Text("이용 요금")
                .onTapGesture {
                    showingPriceInfo = true
            }
            Text("차종별 충전 방식")
                .onTapGesture {
                    showingCarChargerType = true
            }
        }
        .sheet(isPresented: $showingChargerType){
            ChargerTypeView()
        }
        .sheet(isPresented: $showingPriceInfo){
            PriceInfoView()
        }
        .sheet(isPresented: $showingCarChargerType){
            CarChargerTypeView()
        }
    }
}
    
struct SideBarStack<SidebarContent: View, Content: View>: View {
    
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(sidebarWidth: CGFloat, showSidebar: Binding<Bool>, @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
        self.sidebarWidth = sidebarWidth
        self._showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .frame(width: sidebarWidth, alignment: .center)
                .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
                .animation(Animation.easeInOut.speed(2))
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.white
                                .opacity(showSidebar ? 0.01 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }
                        } else {
                            Color.clear
                            .opacity(showSidebar ? 0 : 0)
                            .onTapGesture {
                                self.showSidebar = false
                            }
                        }
                    }
                )
                .offset(x: showSidebar ? sidebarWidth : 0, y: 0)
                .animation(Animation.easeInOut.speed(2))
                
        }
    }
}
