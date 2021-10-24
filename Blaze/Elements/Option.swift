//
//  Option.swift
//  Blaze
//
//  Created by Paul Wong on 10/13/21.
//

import SwiftUI

struct Option: View {
    
    @EnvironmentObject var fires: FireBackend
    @EnvironmentObject var mapController: FullFireMapController
    
    @State var showSearch = false
    @State var showSettings = false
    
    @Binding var showLabels: Bool
    @Binding var secondaryShow: Bool
    @Binding var focused: Bool
    @Binding var popup: Bool
    @Binding var page: Int
    
    var foreground: Color
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    showSettings = true
                }) {
                    Image(systemName: "gearshape")
                        .padding(11)
                        .contentShape(Rectangle())
                }
            }
            .background(RegularBlurBackground())
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .sheet(isPresented: $showSettings) {
                SettingsView(showSettings: $showSettings)
                    .environmentObject(fires)
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                Button(action: {
                    if page != 0 {
                        secondaryShow = false
                    }

                    withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                        page = 0
                        popup = true
                        focused = true
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(11)
                        .contentShape(Rectangle())
                }

                Divider()
                    .frame(height: textSize(textStyle: .largeTitle))

                Button(action: {
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { showLabels.toggle() }
                }) {
                    Image(systemName: showLabels ? "bubble.middle.bottom.fill" : "bubble.middle.bottom")
                        .padding(11)
                        .contentShape(Rectangle())
                }

                Divider()
                    .frame(height: textSize(textStyle: .largeTitle))
                
                Button(action: { mapController.moveBack() }) {
                    Image(systemName: "location")
                        .padding(11)
                        .contentShape(Rectangle())
                }
            }
            .background(RegularBlurBackground())
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        }
        .font(Font.title2.weight(.regular))
        .foregroundColor(foreground)
        .shadow(color: Color.black.opacity(0.07), radius: 10)
    }
}
