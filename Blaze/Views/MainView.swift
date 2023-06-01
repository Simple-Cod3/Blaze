//
//  MainView.swift
//  Blaze
//
//  Created by Paul Wong on 10/14/21.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var fireB: FireBackend
    @EnvironmentObject var forecast: AirQualityBackend

    @State private var showFireInformation = ""
    @State private var selectAll = 0
    @State private var selectLargest = 0
    @State private var progress = 0.0
    @State private var data = false
    @State private var done = false
    @State private var popup = true
    @State private var showLabels = false
    @State private var showSettings = false
    @State private var page = 0
    @State private var secondaryPopup = false
    @State private var secondaryShow = false
    @State private var showDefinition = ""
    @State private var focused = false
    @State private var showContacts = false
    @State private var showGlossary = false
    @State private var showContent = false

    @State private var sheetStatus = true
    
    var body: some View {
        FullFireMapView(
            showLabels: $showLabels,
            showFireInformation: $showFireInformation,
            secondaryPopup: $secondaryPopup,
            secondaryShow: $secondaryShow,
            page: $page
        )
        .sheet(isPresented: $sheetStatus) {
            Group {
                if page == 0 {
                    FiresView(
                        showFireInformation: $showFireInformation,
                        popup: $popup,
                        secondaryPopup: $secondaryPopup,
                        secondaryShow: $secondaryShow,
                        focused: $focused
                    )
                }

                if page == 1 {
                    AQView(popup: $popup)
                }

                if page == 2 {
                    NewsView(
                        showContacts: $showContacts,
                        showGlossary: $showGlossary,
                        popup: $popup,
                        secondaryPopup: $secondaryPopup,
                        secondaryShow: $secondaryShow
                    )
                }
            }
            .presentationBackground(.thickMaterial)
            .presentationDetents([.height(70), .fraction(0.45), .fraction(0.99)])
            .presentationBackgroundInteraction(
                .enabled(upThrough: .fraction(0.99))
            )
            .interactiveDismissDisabled()
        }
        .overlay(
            VStack(spacing: 5) {
                NavigationButtonSelection(
                    symbol: "flame",
                    foreground: page == 0 ? .white : .secondary,
                    background: .blaze.opacity(page == 0 ? 1 : 0)
                ) {
                    page = 0
                }

                Divider()
                    .frame(width: 19)

                NavigationButtonSelection(
                    symbol: "magazine",
                    foreground: page == 2 ? .white : .secondary,
                    background: .orange.opacity(page == 2 ? 1 : 0)
                ) {
                    page = 2
                }

                Divider()
                    .frame(width: 19)

                NavigationButtonSelection(
                    symbol: "aqi.medium",
                    foreground: page == 1 ? .white : .secondary,
                    background: .green.opacity(page == 1 ? 1 : 0)
                ) {
                    page = 1
                }
            }
            .padding(5)
            .background(Blur(.systemMaterial))
            .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .stroke(Color.borderBackground, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.05), radius: 1, y: 1)
            .shadow(color: Color.black.opacity(0.15), radius: 30, y: 10)
            .padding()
            .padding(.top, 3)
            ,
            alignment: .topTrailing
        )
        .overlay(
            HStack(spacing: 0) {
                VStack(spacing: 5) {
                    NavigationButton(symbol: "gearshape") {
                    }
                }
                .padding(5)
                .background(Blur(.systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(Color.borderBackground, lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 1, y: 1)
                .shadow(color: Color.black.opacity(0.15), radius: 30, y: 10)

                Spacer()

                VStack(spacing: 5) {
                    NavigationButton(symbol: "location") {
                    }
                }
                .padding(5)
                .background(Blur(.systemMaterial))
                .clipShape(RoundedRectangle(cornerRadius: 11, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                        .stroke(Color.borderBackground, lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.05), radius: 1, y: 1)
                .shadow(color: Color.black.opacity(0.15), radius: 30, y: 10)
            }
            .padding()
            .padding(.bottom, 70)
            ,
            alignment: .bottomLeading
        )
        .overlay(
            Group {
                if !done {
                    ProgressBarView(
                        progressObjs: $fireB.progress,
                        progress: $progress,
                        done: $done
                    )
                }
            }
        )
    }
    
    private var secondaryModal: some View {
        Group {
            if page == 0 && showFireInformation != "" {
                FireInfoCard(
                    secondaryPopup: $secondaryPopup,
                    secondaryShow: $secondaryShow,
                    popup: $popup,
                    showLabels: $showLabels,
                    fireData: fireB.fires.filter { $0.name == showFireInformation }.first ?? ForestFire()
                )
            }

            if page == 2 {
                if showGlossary {
                    GlossaryView(popup: $popup, showDefinition: $showDefinition, secondaryPopup: $secondaryPopup, secondaryShow: $secondaryShow)
                }

                if showContacts {
                    PhoneView(popup: $popup, secondaryPopup: $secondaryPopup, secondaryShow: $secondaryShow)
                }
            }
        }
    }
}
