//
//  FullMapView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//                                                                                                                          

import Foundation
import SwiftUI
import MapKit

struct FullFireMapView: View {
    
    @AppStorage("californiaOnly") var caliOnly = UserDefaults.standard.bool(forKey: "californiaOnly")
    
    @EnvironmentObject private var fireBackend: FireBackend
    
    @State private var coordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 36.7783, longitude: -119.4),
        span: .init(latitudeDelta: 7, longitudeDelta: 7)
    )
    
    // Map States
    @State private var show = false
    @State private var centerLat = 36.7783
    @State private var centerLong = -119.4
    @State private var free = true
    
    private let RADIUS = 11.0
    
    private func dismiss() {
        show = false
    }
    
    private func moveBack() {
        withAnimation {
            self.coordinateRegion = MKCoordinateRegion(
                center: .init(latitude: centerLat, longitude: centerLong),
                span: .init(latitudeDelta: 7, longitudeDelta: 7)
            )
        }
    }
    
    @Binding var showLabels: Bool

    init(showLabels: Binding<Bool>) {
        self._showLabels = showLabels
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Map(coordinateRegion: $coordinateRegion, annotationItems: fireBackend.fires) { fire in
                MapAnnotation(coordinate: fire.coordinate) {
                    VStack(spacing: 5) {
                        Text(fire.name)
                            .font(.caption2)
                            .foregroundColor(.primary.opacity(0.7))
                            .multilineTextAlignment(.center)
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 120)
                            .padding(5)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                            .scaleEffect(showLabels ? 1 : 0)
                            .animation(.spring(response: 0.45, dampingFraction: 0.7))

                        FirePin(showLabels: $showLabels)
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
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
        }
        .onAppear {
            moveBack()
        }
//        .navigationBarTitle("All Wildfires", displayMode: .inline)
//        .navigationBarItems(trailing: Button(action: moveBack) {
//            Image(systemName: "rotate.3d")
//                .font(.title2)
//        })
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
