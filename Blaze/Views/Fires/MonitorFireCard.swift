//
//  MonitorFireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct MonitorFireCard: View {
    
    @EnvironmentObject var fireB: FireBackend
    
    @Binding var showFireInformation: String
    @Binding var popup: Bool
    
    var fireData: ForestFire
        
    init(showFireInformation: Binding<String>, popup: Binding<Bool>, fireData: ForestFire) {
        self._showFireInformation = showFireInformation
        self._popup = popup
        self.fireData = fireData
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                showFireInformation = fireData.name
                popup = true
            }
        }) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(fireData.name)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .lineLimit(2)
                    
                    HStack(spacing: 5) {
                        Image(systemName: "viewfinder.circle.fill")
                        
                        Text(fireData.getAreaString())
                    }
                    .font(Font.subheadline.weight(.medium))
                    .foregroundColor(Color.blaze)
                }
                
                Spacer()
                
                SymbolButton("chevron.right")
            }
            .padding(16)
            .background(Color(.quaternarySystemFill))
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contextMenu {
                Button(action: { fireB.removeMonitoredFire(name: fireData.name) }) {
                   Label("Remove from Monitoring List", systemImage: "minus.circle")
                }
                Divider()
                Button(action: { fireData.share(0) }) { Label("Share", systemImage: "square.and.arrow.up") }
            }
        }
        .buttonStyle(DefaultButtonStyle())
    }
}
