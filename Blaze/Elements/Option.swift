//
//  Option.swift
//  Blaze
//
//  Created by Paul Wong on 10/13/21.
//

import SwiftUI

struct Option: View {

    @EnvironmentObject var mapController: FullFireMapController
    
    @State var showSearch = false
    @State var showSettings = false
    
    @Binding var showLabels: Bool
    @Binding var secondaryShow: Bool
    @Binding var searchMap: Bool
    
    private var foreground: Color
    
    init(showLabels: Binding<Bool>, secondaryShow: Binding<Bool>, searchMap: Binding<Bool>, _ foreground: Color) {
        self._showLabels = showLabels
        self._secondaryShow = secondaryShow
        self._searchMap = searchMap
        self.foreground = foreground
    }
    
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
            }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 0) {
                Button(action: { showSearch = true }) {
                    Image(systemName: "magnifyingglass")
                        .padding(11)
                        .contentShape(Rectangle())
                }
                .sheet(isPresented: $showSearch) {
                    SearchView(showSearch: $showSearch, secondaryShow: $secondaryShow, searchMap: $searchMap)
                }
                
                Divider()
                    .frame(height: textSize(textStyle: .largeTitle))
                                
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        showLabels.toggle()
                    }
                }) {
                    Image(systemName: showLabels ? "bubble.middle.bottom.fill" : "bubble.middle.bottom")
                        .padding(11)
                        .contentShape(Rectangle())
                }

                Divider()
                    .frame(height: textSize(textStyle: .largeTitle))
                
                Button(action: mapController.moveBack) {
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
