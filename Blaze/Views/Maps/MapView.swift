//
//  MapView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/2/20.
//

import Foundation
import SwiftUI
import MapKit
import ModalView

struct FireMapView: View {
    @State var coordinateRegion = MKCoordinateRegion()
    @State var hide = true
    @State var show = false
    
    var fireData: ForestFire
    
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
            Map(coordinateRegion: $coordinateRegion,
                annotationItems: [fireData]) { fire in
                MapAnnotation(coordinate: fire.coordinate) {
                    LazyVStack(spacing: 15) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.blaze)
                        Text(fire.name)
                            .font(.caption)
                            .frame(maxWidth: 200)
                    }
                }
            }
                .offset(y: 30)
                .edgesIgnoringSafeArea(.all)

            Button(action: { hide.toggle() }) {
                InfoCard(fire: fireData, hide: $hide, show: $show)
                    .padding(.bottom, 20)
                    .buttonStyle(InfoCardButtonStyle())
            }
                .buttonStyle(InfoCardButtonStyle())
                .offset(y: hide ? 570 : 0)
                .animation(.spring(), value: hide)
            
        }
            .sheet(isPresented: $show) {
                InformationView(fireData: fireData)
            }
            .onAppear {
                moveBack()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    hide = false
                }
            }
            .navigationBarTitle(fireData.name, displayMode: .inline)
            .navigationBarItems(trailing: Button(action: moveBack) {
                Image(systemName: "location.fill")
            })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let fire = ForestFire(name: "Elkhorn Fire", updated: Date(), start: Date(), county: "Los Angeles", location: "Lake Hughes Rd and Prospect Rd, southwest Lake Hughes", acres: 45340, contained: 58, longitude: 0, latitude: 0, url: "https://www.fire.ca.gov/incidents/2020/8/12/lake-fire/")
        
        FireMapView(fireData: fire)
            .environmentObject(FireBackend())
    }
}
