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
    @EnvironmentObject private var mapController: FullFireMapController

    @Binding var showLabels: Bool

    init(showLabels: Binding<Bool>) {
        self._showLabels = showLabels
    }
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Map(coordinateRegion: $mapController.coordinateRegion, annotationItems: fireBackend.fires) { fire in
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
            .onChange(of: mapController.coordinateRegion) { region in
                if mapController.free && !caliOnly {
                    if region.span.longitudeDelta > 16 &&
                        region.span.latitudeDelta > 16 {
                        mapController.coordinateRegion.span.latitudeDelta = 15
                        mapController.coordinateRegion.span.longitudeDelta = 15
                    }
                    if region.center.latitude > mapController.centerLat + mapController.RADIUS {
                        mapController.setCenter(option: FullFireMapController.OPTIONS.TOP)
                    } else if region.center.latitude < mapController.centerLat - mapController.RADIUS {
                        mapController.setCenter(option: FullFireMapController.OPTIONS.DOWN)
                    }
                    
                    if region.center.longitude > mapController.centerLong + mapController.RADIUS {
                        mapController.setCenter(option: FullFireMapController.OPTIONS.RIGHT)
                    } else if region.center.longitude < mapController.centerLong - mapController.RADIUS {
                        mapController.setCenter(option: FullFireMapController.OPTIONS.LEFT)
                    }
                    
                }
            }
        }
        .onAppear {
            mapController.moveBack()
        }
//        .navigationBarTitle("All Wildfires", displayMode: .inline)
//        .navigationBarItems(trailing: Button(action: moveBack) {
//            Image(systemName: "rotate.3d")
//                .font(.title2)
//        })
    }
}
