//
//  FireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct FireCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    @EnvironmentObject var fireB: FireBackend
    
    @Binding var showFireInformation: String
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryShow: Bool
    
    var fireData: ForestFire
    private var area: Bool
    
    init(showFireInformation: Binding<String>, popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryShow: Binding<Bool>, fireData: ForestFire, area: Bool) {
        self._showFireInformation = showFireInformation
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryShow = secondaryShow
        self.fireData = fireData
        self.area = area
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        Button(action: {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                showFireInformation = fireData.name
                secondaryPopup = true
                secondaryShow = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    popup = false
                }
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
                        Image(systemName: area ? "viewfinder.circle.fill" : "clock.fill")
                        
                        Text(area ? fireData.getAreaString(areaUnits) : fireData.updated.getElapsedInterval() + " ago")
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
                Button(action: { fireB.addMonitoredFire(name: fireData.name) }) { Label("Pin to Monitoring List", systemImage: "plus.rectangle.on.rectangle") }
                Divider()
                Button(action: { fireData.share(0) }) { Label("Share", systemImage: "square.and.arrow.up") }
            }
        }
        .buttonStyle(DefaultButtonStyle())
    }
}
