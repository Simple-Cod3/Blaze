//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit
import ModalView

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend
    @EnvironmentObject var forecast: AirQualityBackend
    
    @State var selectAll = 0
    @State var selectLargest = 0
    
    @State var progress = 0.0
    @State var data = false
    @State var done = false
    @State private var popup = false
    @State var wildfire = true
    @State var showFireInformation = false
    @State var aqi = false
    @State var news = false
    @State var prefix = 10
    @State var showLabels = false
    @State var largest = true
    @State var latest = false
        
    var body: some View {
        if done {
            VStack {
                Button(action: {
                    withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                        popup = false
                    }
                }) {
                    FullFireMapView(showLabels: $showLabels)
                }
                .buttonStyle(NoButtonStyle())
                
//                            NavigationLink(destination: MonitoringListView()) {
//                                VerticalButton(symbol: "doc.text.magnifyingglass", text: "Monitoring List", desc: "\(fireB.monitoringFires.count) fires pinned", mark: "chevron.forward")
//                            }
//                            .buttonStyle(CardButtonStyle())
            }
            .overlay(
                main,
                alignment: .bottom
            )
            .overlay(
                Menu(
                    content: {
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                wildfire = true
                                aqi = false
                                news = false
                            }
                        }) {
                            HStack {
                                Text("Wildfires")
                                Image(systemName: "flame")
                            }
                        }
                        
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                wildfire = false
                                popup = true
                                aqi = true
                                news = false
                            }
                        }) {
                            HStack {
                                Text("Air Quality")
                                Image(systemName: "aqi.high")
                            }
                        }
                        
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                wildfire = false
                                popup = true
                                aqi = false
                                news = true
                            }
                        }) {
                            HStack {
                                Text("News")
                                Image(systemName: "newspaper")
                            }
                        }
                        
                        Divider()
                        
                        Button(action: {
                        
                        }) {
                            HStack {
                                Text("Settings")
                                Image(systemName: "gear")
                            }
                        }
                    },
                    label: {
                        Hero(wildfire: $wildfire, aqi: $aqi, news: $news)
                            .padding(20)
                            .buttonStyle(ShrinkButtonStyle())

                    }
                )
                ,
                alignment: .top
            )
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(true)
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
            if popup {
                Hero(wildfire: $wildfire, aqi: $aqi, news: $news)
                    .padding(20)
                    .opacity(0)
            }
                
            VStack(alignment: .leading, spacing: 0) {
                if !popup {
                    HStack(spacing: 15) {
                        Image(systemName: "location")
                        
                        Image(systemName: "rectangle.grid.1x2")

                        Button(action: { showLabels.toggle() }) {
                            Image(systemName: showLabels ? "bubble.middle.top.fill" : "bubble.middle.top")
                        }
                    }
                    .font(Font.title2.weight(.regular))
                    .foregroundColor(wildfire ? Color.blaze : aqi ? determineColor(cat: forecast.forecasts[1].category.number) : Color.orange)
                    .padding(11)
                    .background(ProminentBlurBackground())
                    .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 15)
                }
                
                VStack(spacing: 0) {
                    if wildfire {
                        if !showFireInformation {
                            Button(action: {
                                UIImpactFeedbackGenerator(style: .soft).impactOccurred()
                                withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) { popup.toggle() }
                            }) {
                                VStack(spacing: 0) {
                                    HStack(spacing: 0) {
                                        Text("Wildfire Overview")
                                            .font(.title3)
                                            .fontWeight(.semibold)
                                            .foregroundColor(.primary)
                                        
                                        Spacer()
                                        
                                        Image(systemName: popup ? "chevron.down" : "chevron.up")
                                            .font(.callout.bold())
                                            .foregroundColor(Color(.tertiaryLabel))
                                    }
                                    .padding(20)
                                }
                                .contentShape(Rectangle())
                            }
                            .buttonStyle(DefaultButtonStyle())
                            
                            if popup {
                                wildfiremain
                            }
                        } else {
                            FireInfoCard(popup: $popup, showFireInformation: $showFireInformation, fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[3])
                        }
                    }
                    
                    if aqi {
                        AQView(popup: $popup)
                    }
                    
                    if news {
                        NewsView(popup: $popup)

                    }
                }
                .background(ProminentBlurBackground())
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .contentShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .padding([.horizontal, .bottom], 20)
            }
        }
    }
    
    private var wildfiremain: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView(showsIndicators: false) {
                HStack(spacing: 10) {
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            largest = true
                            latest = false
                        }
                    }) {
                        RectButton(selected: $largest, "Largest Fires")
                    }
                    .buttonStyle(DefaultButtonStyle())
                    
                    Button(action: {
                        withAnimation(.spring(response: 0.3)) {
                            largest = false
                            latest = true
                        }
                    }) {
                        RectButton(selected: $latest, "Latest Fires")
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                SubHeader(
                    title: largest ? "Largest Fires" : "Latest Fires",
                    desc: largest ? "Wildfires are sorted according to their sizes from largest to smallest." :
                        "Wildfires are sorted based on time updated."
                )
                .padding(.top, 16)
                .padding(.horizontal, 20)

                VStack(spacing: 13) {
                    if largest {
                        ForEach(
                            fireB.fires.sorted(by: { $0.acres > $1.acres }).prefix(prefix).indices,
                            id: \.self
                        ) { index in
                            FireCard(
                                showFireInformation: $showFireInformation,
                                popup: $popup,
                                selected: index == selectLargest,
                                fireData: fireB.fires.sorted(by: { $0.acres > $1.acres })[index],
                                area: true
                            )
                        }
                    }
                    
                    if latest {
                        ForEach(
                            fireB.fires.sorted(by: { $0.updated > $1.updated }).prefix(prefix).indices,
                            id: \.self
                        ) { index in
                            FireCard(
                                showFireInformation: $showFireInformation,
                                popup: $popup,
                                selected: index == selectAll,
                                fireData: fireB.fires.sorted(by: {
                                    $0.updated > $1.updated
                                })[index],
                                area: false)
                        }
                    }
                    
                    Button(action: {
                        prefix += 10
                        
                        print(prefix)
                    }) {
                        MoreButton(symbol: "plus.circle", text: "View More", color: .blaze)
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
                .padding(.vertical, 16)
                .padding(.horizontal, 20)

                Spacer()
            }
        }
    }
}
