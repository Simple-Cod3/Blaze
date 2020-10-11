//
//  FullMapView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import SwiftUI
import MapKit
import ModalView

struct FullFireMapView: View {
    
    @EnvironmentObject var fireBackend: FireBackend
    @State var coordinateRegion = MKCoordinateRegion(
        center: .init(latitude: 36.7783, longitude: -119.4),
        span: .init(latitudeDelta: 7, longitudeDelta: 7)
    )
    
    @State var showLabels = false
    @State var show = false
    @State var centerLat = 36.7783
    @State var centerLong = -119.4
    @State var free = true
    let radius = 7.0
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
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Map(
                coordinateRegion: $coordinateRegion,
                annotationItems: fireBackend.fires
            )
            { fire in
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
                .offset(y: 30)
                .edgesIgnoringSafeArea(.all)
                .onChange(of: coordinateRegion) { region in
                    if free {
                        if region.span.longitudeDelta > 16 &&
                           region.span.latitudeDelta > 16 {
                            coordinateRegion.span.latitudeDelta = 15
                            coordinateRegion.span.longitudeDelta = 15
                        }
                      //  print(coordinateRegion.center.latitude)
                      //  print(coordinateRegion.center.longitude)
                        
                        if region.center.latitude > centerLat + radius{
                            setCenter(option : OPTIONS.TOP)
                        }
                        else if region.center.latitude < centerLat - radius{
                            setCenter(option : OPTIONS.DOWN)
                        }
                        
                        if region.center.longitude > centerLong + radius{
                            setCenter(option : OPTIONS.RIGHT)
                        }
                        else if region.center.longitude < centerLong - radius{
                            setCenter(option : OPTIONS.LEFT)
                        }
                        
                    }
                       
                }
            
            LazyVStack(alignment: .leading, spacing: 10) {
                Button(action: { showLabels.toggle() }) {
                    Text("\(Image(systemName: "bubble.middle.top")) \(showLabels ? "Hide" : "Show") Labels")
                        .font(.body)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                }
                
                Button(action: { show = true }) {
                    Text("\(Image(systemName: "list.bullet")) Fire Information")
                        .font(.body)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                }
            }.padding(20)
        }
            .sheet(isPresented: $show) {
                FullInformationView(show: $show)
                    .environmentObject(fireBackend)
            }
            .onAppear {
                moveBack()
            }
            .navigationBarTitle("All Wildfires", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: moveBack) {
                Image(systemName: "location.fill")
            })
    }
    func setCenter(option : OPTIONS){
        var center : MKCoordinateRegion
        var tempLat = coordinateRegion.center.latitude
        var tempLong = coordinateRegion.center.longitude
        switch option{
            case OPTIONS.TOP: tempLat = centerLat + (radius - 1)
            case OPTIONS.DOWN: tempLat = centerLat - (radius - 1)
            case OPTIONS.RIGHT: tempLong = centerLong + (radius - 1)
            case OPTIONS.LEFT: tempLong = centerLong - (radius - 1)
            default: break
                
        }
        center = MKCoordinateRegion(
                center: .init(latitude: tempLat, longitude: tempLong),
            span: .init(latitudeDelta: 7.0, longitudeDelta: 7.0))

        withAnimation{
            self.coordinateRegion = center
        }
        free = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            free = true
        }
    }
    enum OPTIONS : Int {
         case TOP = 1
        case DOWN = 2
        case RIGHT = 3
        case LEFT = 4
        
    }
}
