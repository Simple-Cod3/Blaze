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
    
    @State private var selectAll = 0
    @State private var selectLargest = 0
    @State private var progress = 0.0
    @State private var data = false
    @State private var done = false
    @State private var popup = false
    @State private var showLabels = false
    @State private var showSettings = false
    @State private var page = 0
    
    var body: some View {
        if fireB.failed {
            Text("😢 Unknown problem...please reload the app.")
        } else {
            VStack(spacing: 0) {
                FullFireMapView(showLabels: $showLabels)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                            popup = false
                        }
                    }
            }
            .overlay(
                PagerView(pageCount: 3, currentIndex: $page) {
                    ForEach(0..<3) { page in
                        HeroCard(page)
                    }
                    .onTapGesture {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                            popup.toggle()
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
                        page == 0 ? Color.blaze : page == 1 ? determineColor(cat: forecast.forecasts[1].category.number) : Color.orange
                    )
                    .padding([.horizontal, .bottom], 11)
                }
                    
                MainCard {
                    if page == 0 {
                        FiresView(popup: $popup)
                    }
                    
                    if page == 1 {
                        AQView(popup: $popup)
                    }

                    if page == 2 {
                        NewsView(popup: $popup)
                    }
                }
            }
            .frame(height: UIScreen.main.bounds.maxY)
            .offset(y: popup ? 0 : UIScreen.main.bounds.maxY*0.85)
        }
    }
}
