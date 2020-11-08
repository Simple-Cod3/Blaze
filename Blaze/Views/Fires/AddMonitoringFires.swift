//
//  AddMonitoringFires.swift
//  Blaze
//
//  Created by Nathan Choi on 11/7/20.
//

import SwiftUI

struct AddMonitoringFires: View {
    @EnvironmentObject var fireB: FireBackend
    @Binding var show: Bool
    
    var body: some View {
        NavigationView {
            List(
                fireB.fires
                    .sorted(by: { $0.name < $1.name })
                    .filter({ !fireB.monitoringFires.map {$0.name}.contains($0.name) })
            ) { item in
                AddMonitoringFiresCell(show: $show, fireData: item)
            }
            .animation(.default)
            .navigationBarTitle("Monitor Fires")
            .navigationBarItems(
                trailing: Button(action: { show = false }) {
                    CloseModalButton()
                })
        }
    }
}

struct AddMonitoringFiresCell: View {
    @EnvironmentObject var fireB: FireBackend
    @Binding var show: Bool
    @State var loaded = false
    
    var fireData: ForestFire
    
    var body: some View {
        Button(action: {
            DispatchQueue.main.async {
                fireB.addMonitoredFire(name: fireData.name)
            }
            show = false
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(fireData.name)
                        .font(.headline)
                    Text("\(Image(systemName: "mappin.and.ellipse")) \(fireData.getLocation())")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
                
                Spacer()
                
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.green)
                    .transition(.scale)
            }
            .padding(.vertical, 10)
        }
    }
}
