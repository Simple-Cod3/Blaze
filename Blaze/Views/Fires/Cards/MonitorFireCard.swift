//
//  MonitorFireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct MonitorFireCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var fireB: FireBackend
    
    @Binding var showFireInformation: String
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool
    
    var fireData: ForestFire
    
    init(showFireInformation: Binding<String>, popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryClose: Binding<Bool>, fireData: ForestFire) {
        self._showFireInformation = showFireInformation
        self._popup = popup
        self._firePopup = secondaryPopup
        self._secondaryClose = secondaryClose
        self.fireData = fireData
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        Button(action: {
            withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                showFireInformation = fireData.name
                popup = true
                secondaryPopup = true
                secondaryClose = true
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
                    .font(.system(size: textSize(textStyle: .subheadline)-1).weight(.medium))
                    .foregroundColor(Color.blaze)
                }
                
                Spacer()
                
                SymbolButton("chevron.right")
            }
            .padding(16)
            .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
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
