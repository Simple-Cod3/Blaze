//
//  MiniFireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct MiniFireCard: View {
    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    @EnvironmentObject var fireB: FireBackend
    @State var show = false
    
    var selected: Bool
    var fireData: ForestFire
    var area: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Image(systemName: "flame")
                .font(.title2)
                .foregroundColor(.secondary)
            Text(fireData.name)
                .font(fireData.name.count > 15 ? .title3 : .title2)
                .fontWeight(.medium)
                .foregroundColor(.primary)
            Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
                .foregroundColor(.secondary)

            Spacer()
            HStack(spacing: 15) {
                Button(action: {
                    self.show.toggle()
                }) {
                    RectButton("INFO", color: .blaze, background: .white)
                }
                .sheet(isPresented: $show) {
                    InformationView(show: $show, fireData: fireData)
                }
                
                NavigationLink(destination: FireMapView(fireData: fireData)) {
                    RectButton("MAP", color: .white, background: .blaze)
                }
            }
        }
        .padding(15)
        .frame(width: 230, height: 190)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
        .contextMenu {
            Button(action: { fireB.addMonitoredFire(name: fireData.name) }) { Label("Pin to Monitoring List", systemImage: "pin") }
            Button(action: { show = true }) { Label("View Details", systemImage: "doc.text.magnifyingglass") }
            Divider()
            Button(action: { fireData.share(0) }) { Label("Share", systemImage: "square.and.arrow.up") }
        }
        .sheet(isPresented: $show) {
            InformationView(show: $show, fireData: fireData)
        }
    }
}
