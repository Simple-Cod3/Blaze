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
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "flame")
                .font(.system(size: 26))
                .padding(.bottom, 10)
                .foregroundColor(.secondary)
            Text(fireData.name)
                .font(.system(size: fireData.name.count > 30 ? 18 : 24))
                .fontWeight(.medium)
                .foregroundColor(.primary)
            
            Spacer()
            HStack {
                Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
                    .font(.system(size: fireData.getAreaString(areaUnits).count > 14 ? 16 : 17))
                    .fontWeight(.regular)
                    .foregroundColor(.blaze)
                Spacer()
                
                NavigationLink(destination: FireMapViewiPad(fireData: fireData)) {
                    RoundedButton("MAP")
                }
            }
        }
        .padding(15)
        .frame(width: 220, height: 180)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .contextMenu {
            Button(action: { fireB.addMonitoredFire(name: fireData.name) }) { Label("Pin to Monitoring List", systemImage: "pin") }
            Button(action: { show = true }) { Label("View Details", systemImage: "doc.text.magnifyingglass") }
            Divider()
            Button(action: { fireData.share(1) }) { Label("Share", systemImage: "square.and.arrow.up") }.disabled(true)
        }
        .sheet(isPresented: $show) {
            InformationView(show: $show, fireData: fireData)
        }
    }
}
