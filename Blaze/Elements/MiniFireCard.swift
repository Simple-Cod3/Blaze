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
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(fireData.name)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                HStack(spacing: 3) {
                    Image(systemName: area ? "viewfinder.circle.fill" : "clock.fill")
                        .font(.subheadline)
                    
                    Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
                        .font(.subheadline)
                }
                .foregroundColor(Color.blaze)
                
    //            HStack(spacing: 15) {
    //                Button(action: {
    //                    show = true
    //                }) {
    //                    RectButton("INFO", color: .blaze, background: Color(.tertiarySystemBackground))
    //                }
    //                .sheet(isPresented: $show) {
    //                    InformationView(show: $show, fireData: fireData)
    //                }
    //
    //                NavigationLink(destination: FireMapView(fireData: fireData)) {
    //                    RectButton("MAP", color: .white, background: .blaze)
    //                }
    //            }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.callout.bold())
                .foregroundColor(Color(.tertiaryLabel))
        }
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .cornerRadius(13)
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
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
