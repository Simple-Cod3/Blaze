//
//  MapView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import SwiftUI
import MapKit

struct FireMapView: View {
    
    @AppStorage("californiaOnly") var caliOnly = UserDefaults.standard.bool(forKey: "californiaOnly")
    @State private var coordinateRegion = MKCoordinateRegion()
    @State private var hide = true
    @State private var show = false
    
    // Map States
    private let RADIUS = 11.0
    @State private var centerLat = 36.7783
    @State private var centerLong = -119.4
    @State private var free = true
    
    private var fireData: ForestFire
    
    init(fireData: ForestFire) {
        self.fireData = fireData
    }
    
    private func dismiss() {
        show = false
    }
    
    private func moveBack() {
        let lat = fireData.latitude
        let long = fireData.longitude
        let spread = 0.15
        
        withAnimation {
            self.coordinateRegion = MKCoordinateRegion(
                center: .init(latitude: lat-0.05, longitude: long),
                span: .init(latitudeDelta: spread, longitudeDelta: spread)
            )
        }
    }

    var body: some View {
        VStack {
            Spacer()
            FireInfoCard(popup: $show, fireData: fireData, soloNavigation: true)
                .font(.body)
                .background(RegularBlurBackground())
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                .shadow(color: Color.black.opacity(0.07), radius: 10)
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(
            Map(coordinateRegion: $coordinateRegion, annotationItems: [fireData]) { fire in
                MapAnnotation(coordinate: fire.coordinate) {
                    FirePin(showLabels: .constant(false))
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .onChange(of: coordinateRegion) { region in
                if free && !caliOnly {
                    if region.span.longitudeDelta > 16 &&
                        region.span.latitudeDelta > 16 {
                        coordinateRegion.span.latitudeDelta = 15
                        coordinateRegion.span.longitudeDelta = 15
                    }
                    if region.center.latitude > centerLat + RADIUS {
                        setCenter(option: OPTIONS.TOP)
                    } else if region.center.latitude < centerLat - RADIUS {
                        setCenter(option: OPTIONS.DOWN)
                    }

                    if region.center.longitude > centerLong + RADIUS {
                        setCenter(option: OPTIONS.RIGHT)
                    } else if region.center.longitude < centerLong - RADIUS {
                        setCenter(option: OPTIONS.LEFT)
                    }

                }
            }
        )
        .onAppear {
            moveBack()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                hide = false
            }
        }
        .navigationBarHidden(false)
        .navigationBarTitle(fireData.name, displayMode: .inline)
        .navigationBarItems(trailing: Button(action: moveBack) {
            Image(systemName: "location")
                .font(.body)
        })
    }
    
    private func setCenter(option: OPTIONS) {
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
    
    private enum OPTIONS: Int {
        case TOP = 1
        case DOWN = 2
        case RIGHT = 3
        case LEFT = 4
    }
}

extension MKCoordinateRegion: Equatable {
    public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool {
        return lhs.span.latitudeDelta == rhs.span.latitudeDelta &&
               lhs.span.longitudeDelta == rhs.span.longitudeDelta
    }
}
