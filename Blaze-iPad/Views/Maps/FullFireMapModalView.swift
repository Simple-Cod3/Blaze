//
//  FullFireMapModalView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 11/1/20.
//

import Foundation
import SwiftUI
import MapKit

struct FullFireMapModalView: View {
    @AppStorage("californiaOnly") var caliOnly = UserDefaults.standard.bool(forKey: "californiaOnly")
    @EnvironmentObject private var fireBackend: FireBackend
    
    @State private var coordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 36.7783, longitude: -119.4),
        span: .init(latitudeDelta: 7, longitudeDelta: 7)
    )
    
    // Map States
    @State private var showLabels = false
    @State private var show = false
    @State private var centerLat = 36.7783
    @State private var centerLong = -119.4
    @State private var free = true
    
    private let RADIUS = 11.0
    
    private func dismiss() {
        show = false
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Map(coordinateRegion: $coordinateRegion, annotationItems: fireBackend.fires) { fire in
                MapAnnotation(coordinate: fire.coordinate) {
                    VStack {
                        Image("fire").resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                        
                        Text(fire.name)
                            .font(.caption2)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 120)
                            .padding(5)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                            .scaleEffect(showLabels ? 1 : 0)
                            .animation(.spring())
                    }
                }
            }
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
            
            LazyVStack(alignment: .trailing, spacing: 10) {
                Button(action: { showLabels.toggle() }) {
                    Text("\(Image(systemName: "bubble.middle.top")) \(showLabels ? "Hide" : "Show") Labels")
                        .font(.body)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color(.systemBackground))
                        .clipShape(Capsule())
                }
                
                Button(action: { show = true }) {
                    Text("\(Image(systemName: "list.bullet")) Fire Information")
                        .font(.body)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color(.systemBackground))
                        .clipShape(Capsule())
                }
            }.padding(20)
        }
        .sheet(isPresented: $show) {
            FullInformationView(show: $show)
                .environmentObject(fireBackend)
        }
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
