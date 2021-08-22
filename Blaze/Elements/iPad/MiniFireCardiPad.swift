//
//  MiniFireCardiPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/2/20.
//

import SwiftUI

struct MiniFireCardiPad: View {
    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    @EnvironmentObject var fireB: FireBackend
    @State var show = false
    
    var selected: Bool
    var fireData: ForestFire
    var area: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
//            HStack(spacing: 15) {
//                Button(action: {
//                    self.show.toggle()
//                }) {
//                    RectButton("INFO")
//                }
//                .sheet(isPresented: $show) {
//                    InformationView(show: $show, fireData: fireData)
//                }
//                
//                NavigationLink(destination: FireMapViewiPad(fireData: fireData)) {
//                    RectButton("MAP")
//                }
//            }
        }
        .padding(15)
        .frame(width: 220, height: 180)
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
//        .sheet(isPresented: $show) {
//            InformationView(fireData: fireData)
//        }
    }
}
