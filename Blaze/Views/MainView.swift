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
    @State private var popup = false
    @State private var showLabels = false
    @State private var showSettings = false
    @State private var page = 0
    @State private var secondaryPopup = false
    @State private var secondaryShow = false
    @State private var showDefinition = ""
    @State private var focused = false
    @State private var showContacts = false
    @State private var showGlossary = false
    
    var body: some View {
        if fireB.failed {
            Text("😢 Unknown problem...please reload the app.")
        } else {
            FullFireMapView(
                showLabels: $showLabels,
                showFireInformation: $showFireInformation,
                secondaryPopup: $secondaryPopup,
                secondaryShow: $secondaryShow,
                page: $page
            )
                .overlay(
                    PagerView(
                        pageCount: 3,
                        currentIndex: $page.animation(.spring(response: 0.49, dampingFraction: 0.9)),
                        secondaryShow: $secondaryShow.animation(.spring(response: 0.49, dampingFraction: 0.9)),
                        showFireInfomation: $showFireInformation.animation(.spring(response: 0.49, dampingFraction: 0.9)),
                        showContacts: $showContacts,
                        showGlossary: $showGlossary
                    ) {
                        ForEach(0..<3) { page in
                            HeroCard(page)
                        }
                        .onTapGesture {
                            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                popup.toggle()
                                secondaryPopup = popup
                            }
                        }
                    }
                    ,
                    alignment: .top
                )
                .overlay(
                    main.edgesIgnoringSafeArea(.bottom),
                    alignment: popup ? .top : .bottom
                )
                .overlay(
                    secondaryModal.edgesIgnoringSafeArea(.bottom)
                        .offset(y: page == 1 ? UIScreen.main.bounds.maxY : 0)
                    ,
                    alignment: secondaryPopup ? .top : .bottom
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
    }
    
    private var main: some View {
        VStack(spacing: 0) {
            HeroCard(page)
                .opacity(0)
            
            Spacer()
            
            Swipeable(popup: $popup) {
                if !popup {
                    Option(
                        showLabels: $showLabels,
                        secondaryShow: $secondaryShow,
                        focused: $focused,
                        popup: $popup,
                        page: $page,
                        foreground: page == 0 ? Color.blaze : page == 1 ? determineColor(cat: forecast.forecasts[1].category.number) : Color.orange
                    )
                    .padding([.horizontal, .bottom], 11)
                }
                    
                MainCard {
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
            }
            .frame(minHeight: UIScreen.main.bounds.maxY)
            .offset(y: popup ? 0 : UIScreen.main.bounds.maxY*0.85)
        }
    }
    
    private var secondaryModal: some View {
        VStack(spacing: 0) {
            HeroCard(page)
                .opacity(0)
            
            Spacer()
            
            Swipeable(popup: $secondaryPopup) {
                if !secondaryPopup {
                    Option(
                        showLabels: .constant(false),
                        secondaryShow: .constant(false),
                        focused: .constant(false),
                        popup: .constant(false),
                        page: .constant(0),
                        foreground: .clear
                    )
                    .padding([.horizontal, .bottom], 11)
                    .opacity(0)
                }
                
                MainCard {
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
            .frame(minHeight: UIScreen.main.bounds.maxY)
            .offset(y: secondaryShow ? (secondaryPopup ? 0 : UIScreen.main.bounds.maxY*0.85) : UIScreen.main.bounds.maxY*1.1)
        }
    }
}
