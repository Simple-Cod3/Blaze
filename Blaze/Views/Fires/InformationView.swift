//
//  InformationView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct InformationView: View {
    
    @EnvironmentObject var fireB: FireBackend
    
    @State var shrink = false
    @State var scrapedHTML = ""
    
    @Binding var data: Bool
    @Binding var info: Bool
    
    var fireData: ForestFire
    
    private var isNotAccesible: Bool { fireData.acres == -1 && fireData.contained == -1 }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if isNotAccesible {
                Section {
                    VStack(alignment: .leading) {
                        Text("\(Image(systemName: "exclamationmark.triangle.fill")) Warning")
                            .font(.headline)
                            .foregroundColor(.yellow)
                            .padding(.bottom, 5)
                        Text("This incident is not accessible on this app at the moment. For more information, click on \"More Info\" below.")
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                }
            }
            
            if data {
                dataView
            }
            
            if info {
                infoView
            }
        }
    }
    
    @ViewBuilder
    private var dataView: some View {
        VStack(spacing: 13) {
            DataCard(
                "flame",
                "Incident",
                fireData.name,
                .blaze
            )
            
            DataCard(
                "location",
                "Location",
                fireData.getLocation(),
                .blaze
            )

            DataCard(
                "clock.arrow.2.circlepath",
                "Last Updated",
                fireData.updated.getElapsedInterval(true),
                .blaze
            )
            
            DataCard(
                "calendar.badge.clock",
                "Fire Started",
                fireData.started.getElapsedInterval(true),
                .blaze
            )

            DataCard(
                "location.viewfinder",
                "Area Burned",
                fireData.getAreaString(),
                .blaze
            )
            
            DataCard(
                "checkmark.shield",
                "Area Contained",
                fireData.getContained(),
                .blaze
            )

            HStack(spacing: 0) {
                Spacer()
                
                if let url = URL(string: fireData.url) {
                    MoreButtonLink(url: url)
                } else {
                    MoreButtonLink(url: URL(string: "https://google.com")!)
                        .disabled(true)
                }
                
                Spacer()
            }
        }
    }

    @ViewBuilder
    private var infoView: some View {
        VStack(spacing: 0) {
            if let html = fireData.conditionStatement, html != "" {
                NativeWebView(html: html)
            } else if fireData.sourceType == .inciweb {
                InciWebContent(url: URL(string: fireData.url)!)
            }
            
            HStack(spacing: 0) {
                Spacer()

                if let url = URL(string: fireData.url) {
                    MoreButtonLink(url: url)
                } else {
                    MoreButtonLink(url: URL(string: "https://google.com")!)
                        .disabled(true)
                }

                Spacer()
            }
            .padding(.top, UIConstants.margin)
        }
    }
}
