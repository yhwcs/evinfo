//
//  StationAnnotationProtocol.swift
//  evinfo
//
//  Created by yhw on 2021/10/07.
//

import MapKit
import SwiftUI

struct StationAnnotationProtocol: MapAnnotationProtocol {
    let _annotationData: _MapAnnotationData
    let value: Any
    
    init<WrappedType: MapAnnotationProtocol>(_ value: WrappedType) {
        self.value = value
        _annotationData = value._annotationData
    }
}
