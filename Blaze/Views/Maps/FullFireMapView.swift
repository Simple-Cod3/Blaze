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
    
    private func dismiss() {
        show = false
    }
    
    private func moveBack() {
        withAnimation {
            self.coordinateRegion = MKCoordinateRegion(
                center: .init(latitude: 36.7783, longitude: -119.4),
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
                            .frame(width: 50, height: 50)
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
            LazyVStack(alignment: .leading, spacing: 10) {
                Button(action: { showLabels.toggle() }) {
                    Text("\(Image(systemName: "bubble.middle.top")) \(showLabels ? "Hide" : "Show") Labels")
                        .font(.headline)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                        .shadow(radius: 10)
                }
                
                Button(action: { show = true }) {
                    Text("\(Image(systemName: "list.bullet")) Fire Information")
                        .font(.headline)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Color(.secondarySystemBackground))
                        .clipShape(Capsule())
                        .shadow(radius: 10)
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
}
