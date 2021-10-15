//
//  Option.swift
//  Blaze
//
//  Created by Paul Wong on 10/13/21.
//

import SwiftUI

struct Option: View {
    
    @State var showSettings = false
    
    @Binding var zoom: Bool
    @Binding var showLabels: Bool
    
    private var foreground: Color
    
    init(zoom: Binding<Bool>, showLabels: Binding<Bool>, _ foreground: Color) {
        self._zoom = zoom
        self._showLabels = showLabels
        self.foreground = foreground
    }
    
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 15) {
                Button(action: {
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        zoom.toggle()
                    }
                }) {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .padding([.leading, .vertical], 11)
                }
                .contentShape(Rectangle())
                
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        showLabels.toggle()
                    }
                }) {
                    Image(systemName: "bubble.middle.bottom")
                        .padding(.vertical, 11)
                }
                .contentShape(Rectangle())
                
                Button(action: {
                    
                }) {
                    Image(systemName: "location")
                        .padding([.trailing, .vertical], 11)
                }
                .contentShape(Rectangle())
            }
            .background(RegularBlurBackground())
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            
            Spacer()
            
            HStack(spacing: 15) {
                Button(action: {
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        showSettings = true
                    }
                }) {
                    Image(systemName: "gearshape")
                        .padding(11)
                }
                .contentShape(Rectangle())
            }
            .background(RegularBlurBackground())
            .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
            .sheet(isPresented: $showSettings) {
                NavigationView {
                    SettingsView(showSettings: $showSettings)
                        .navigationTitle("Settings")
                }
            }
        }
        .font(Font.title2.weight(.regular))
        .foregroundColor(foreground)
    }
}
