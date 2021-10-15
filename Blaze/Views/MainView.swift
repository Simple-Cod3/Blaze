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
    @State private var zoom = false
    @State private var showSettings = false
    @State private var page = 0
    
    var body: some View {
        if done {
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
                }
                ,
                alignment: .top
            )
            .overlay(
                main,
                alignment: .bottom
            )
        } else if fireB.failed {
        
        } else {
            ProgressBarView(
                progressObjs: $fireB.progress,
                progress: $progress,
                done: $done
            )
        }
    }
    
    private var main: some View {
        VStack(spacing: 0) {
            HeroCard(page)
                .opacity(0)
                
            if !popup {
                Option(
                    zoom: $zoom,
                    showLabels: $showLabels,
                    page == 0 ? Color.blaze : page == 1 ? determineColor(cat: forecast.forecasts[1].category.number) : Color.orange
                )
                .padding(.bottom, 15)
            }
            
            VStack(spacing: 0) {
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
        }
        .padding([.horizontal, .bottom], 20)
    }
}