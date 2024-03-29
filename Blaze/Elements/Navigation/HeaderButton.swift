//
//  HeaderButton.swift
//  HeaderButton
//
//  Created by Paul Wong on 8/22/21.
//

import SwiftUI

struct HeaderButton: View {
    
    private var symbol: String
    private var title: String

    init(symbol: String, title: String) {
        self.symbol = symbol
        self.title = title
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.title3)
                .fontWeight(.medium)

            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .padding(.top, 10)
    }
}

struct SecondaryHeaderButton: View {

    @EnvironmentObject var mapController: FullFireMapController
    
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryShow: Bool
    @Binding var showLabels: Bool
    
    private var title: String
    private var staticModal: Bool
    
    init(popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryShow: Binding<Bool>, showLabels: Binding<Bool>, _ title: String, staticModal: Bool?=nil) {
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryShow = secondaryShow
        self._showLabels = showLabels
        self.title = title
        self.staticModal = staticModal ?? false
    }

    var body: some View {
        VStack(spacing: 0) {
            DragBar()
            
            HStack(spacing: 0) {
                Text(title)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Spacer()

                if !staticModal {
                    Button(action: {
                        withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                            popup = false
                            secondaryShow = false
                            showLabels = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(Color(.tertiaryLabel))
                            .contentShape(Rectangle())
                    }
                }
            }
            .padding(.bottom, UIConstants.margin)
        }
        .padding(.horizontal, UIConstants.margin)
        .contentShape(Rectangle())
    }
}
