//
//  MapAnnotationProtocol.swift
//  Blaze
//
//  Created by Nathan Choi on 10/23/21.
//

import MapKit
import SwiftUI

struct AnyMapAnnotationProtocol: MapAnnotationProtocol {
    var _annotationData: _MapAnnotationData
    let value: Any

    init(_ value: MapAnnotationProtocol) {
        self.value = value
        _annotationData = value._annotationData
    }
}
