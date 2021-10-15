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
                    }.padding(.vertical, 10)
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
    
    private var dataView: some View {
        VStack(alignment: .leading, spacing: 10) {
            DataSection(
                symbol: "info.circle.fill",
                unit: "Name",
                data: fireData.name
            )
            
            DataSection(
                symbol: "viewfinder.circle.fill",
                unit: "Location",
                data: fireData.getLocation()
            )

//            String(fireData.latitude)+"°", String(fireData.longitude)+"°"]

            DataSection(
                symbol: "clock.fill",
                unit: "Updated",
                data: fireData.updated.getElapsedInterval(true)
            )
            
            DataSection(
                symbol: "calendar.circle.fill",
                unit: "Fire Started",
                data: fireData.started.getElapsedInterval(true)
            )
            
            DataSection(
                symbol: "viewfinder.circle.fill",
                unit: "Area Burned",
                data: fireData.getAreaString()
            )
            
            DataSection(
                symbol: "lock.circle.fill",
                unit: "Containment",
                data: fireData.getContained()
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
            .padding(.top, 6)
        }
    }

    @ViewBuilder
    private var infoView: some View {
        ScrollView {
            if let html = fireData.conditionStatement, html != "" {
                NativeWebView(html: html)
            } else if fireData.sourceType == .inciweb {
                InciWebContent(url: URL(string: fireData.url)!)
            }
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
        .padding(.top, 6)
    }
}
