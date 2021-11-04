//
//  CustomChargerType.swift
//  evinfo
//
//  Created by yhw on 2021/11/04.
//

import Foundation

class CustomChargerTypes: ObservableObject {
    @Published var isDCCombo: Bool = true
    @Published var isDCDemo: Bool = true
    @Published var isAC3: Bool = true
    @Published var isACSlow: Bool = true
    
    init() {}
}
