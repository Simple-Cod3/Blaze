//
//  FireMapView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/27/20.
//

import Foundation
import SwiftUI
import MapKit
import ModalView

struct FireMapView: View {
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
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $coordinateRegion, annotationItems: [fireData]) { fire in
                MapAnnotation(coordinate: fire.coordinate) {
                    Image("fire").resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
                .offset(y: 30)
                .edgesIgnoringSafeArea(.all)
                .onChange(of: coordinateRegion) { region in
                    if free {
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

            HStack {
                Spacer()
                Button(action: { hide.toggle() }) {
                    MapFireCard(fire: fireData, hide: $hide, show: $show)
                        .padding(.bottom, 20)
                        .buttonStyle(InfoCardButtonStyle())
                }
                .buttonStyle(InfoCardButtonStyle())
                .animation(.spring(), value: hide)
            }
        }
        .sheet(isPresented: $show) {
            InformationView(show: $show, fireData: fireData)
        }
        .onAppear {
            moveBack()

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                hide = false
            }
        }
        .navigationBarTitle(fireData.name, displayMode: .inline)
        .navigationBarItems(trailing: Button(action: moveBack) {
            Image(systemName: "rotate.3d")
                .font(.title2)
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
