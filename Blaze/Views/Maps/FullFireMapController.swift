//
//  FullFireMapController.swift
//  Blaze
//
//  Created by Nathan Choi on 10/18/21.
//

import SwiftUI
import MapKit

class FullFireMapController: ObservableObject {
    @Published var coordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 36.7783, longitude: -119.4),
        span: .init(latitudeDelta: 7, longitudeDelta: 7)
    )

    // Map States
    @State var centerLat = 36.7783
    @State var centerLong = -119.4
    @State var free = true

    let RADIUS = 11.0

    func moveBack(lat: Double?=nil, long: Double?=nil, span: Double?=nil) {
        withAnimation {
            self.coordinateRegion = MKCoordinateRegion(
                center: .init(latitude: lat ?? centerLat, longitude: long ?? centerLong),
                span: .init(latitudeDelta: span ?? 7, longitudeDelta: span ?? 7)
            )
        }
    }

    func setCenter(option: OPTIONS) {

        var tempLat = coordinateRegion.center.latitude
        var tempLong = coordinateRegion.center.longitude

        switch option {
        case OPTIONS.TOP: tempLat = centerLat + (RADIUS - 0.01)
        case OPTIONS.DOWN: tempLat = centerLat - (RADIUS - 0.01)
        case OPTIONS.RIGHT: tempLong = centerLong + (RADIUS - 0.01)
        case OPTIONS.LEFT: tempLong = centerLong - (RADIUS - 0.01)
        }

        self.coordinateRegion = MKCoordinateRegion(
            center: .init(
                latitude: tempLat,
                longitude: tempLong
            ),
            span: .init(
                latitudeDelta: Double(coordinateRegion.span.latitudeDelta - 1) + 1,
                longitudeDelta: 10
            )
        )
    }

    enum OPTIONS: Int {
        case TOP = 1
        case DOWN = 2
        case RIGHT = 3
        case LEFT = 4
    }
}
