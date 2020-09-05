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

struct MapView: View {
    @State var coordinateRegion = MKCoordinateRegion()
    @State var hide = true
    
    var fireData: ForestFire
    var annotations: [MKPointAnnotation]
    
    init(fireData: ForestFire) {
        self.fireData = fireData
        
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: fireData.latitude, longitude: fireData.longitude)
        pin.title = fireData.name
        self.annotations = [pin]
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
        ModalPresenter {
            ZStack(alignment: .bottom) {
                Map(coordinateRegion: $coordinateRegion)
                    .customAppearance()
                    .addAnnotations(annotations)
                    .offset(y: 30)
                    .edgesIgnoringSafeArea(.all)
                
                
                    Button(action: {hide.toggle()}) {
                        InfoCard(fire: fireData, hide: $hide)
                            .padding(.bottom, 20)
                            .buttonStyle(InfoCardButtonStyle())
                    }
                        .buttonStyle(InfoCardButtonStyle())
                        .offset(y: hide ? 570 : 0)
                        .animation(.spring(), value: hide)
                
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
}

/// Adding waypoints
extension Map {
    func customAppearance() ->  Map {
        MKMapView.appearance().showsBuildings = true
        MKMapView.appearance().mapType = .hybridFlyover
        
        return self
    }
    
    func addAnnotations(_ annotations: [MKAnnotation]) -> some View {
        MKMapView.appearance().addAnnotations(annotations)
        return self
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let fire = ForestFire(name: "Elkhorn Fire", updated: Date(), start: Date(), county: "Los Angeles", location: "Lake Hughes Rd and Prospect Rd, southwest Lake Hughes", acres: 45340, contained: 58, longitude: 0, latitude: 0, url: "https://www.fire.ca.gov/incidents/2020/8/12/lake-fire/")
        
        MapView(fireData: fire)
    }
}
