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
    
    @Binding var showFireInformation: Bool
    
    private var selected: Bool
    private var fireData: ForestFire
    private var area: Bool
    
    init(showFireInformation: Binding<Bool>, selected: Bool, fireData: ForestFire, area: Bool) {
        self._showFireInformation = showFireInformation
        self.selected = selected
        self.fireData = fireData
        self.area = area
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showFireInformation = true }
        }) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(fireData.name)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    HStack(spacing: 5) {
                        Image(systemName: area ? "viewfinder.circle.fill" : "clock.fill")
                        
                        Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
                    }
                    .font(Font.subheadline.weight(.medium))
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
                
                Image(systemName: "chevron.up")
                    .font(.callout.bold())
                    .foregroundColor(Color(.tertiaryLabel))
            }
            .padding(16)
            .background(Color(.quaternarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contextMenu {
                Button(action: { fireB.addMonitoredFire(name: fireData.name) }) { Label("Pin to Monitoring List", systemImage: "pin") }
                Divider()
                Button(action: { fireData.share(0) }) { Label("Share", systemImage: "square.and.arrow.up") }
            }
        }
        .buttonStyle(DefaultButtonStyle())
    }
}
