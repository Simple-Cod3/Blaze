//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

public let units = ["acres", "sq km", "sq mi"]
public var currentUnit: String? { UserDefaults.standard.string(forKey: "areaUnits") }
public func setUnit(unit: String) { UserDefaults.standard.setValue(unit, forKey: "areaUnits") }

struct ContentView: View {
    @AppStorage("welcomed") private var welcomed = false
    
    init() {
        if UserDefaults.standard.object(forKey: "monitoringFires") == nil {
            UserDefaults.standard.setValue([String](), forKey: "monitoringFires")
            print("🤔 Couldn't find monitoring list so initated one")
        }
        
        if !units.contains(currentUnit ?? "nil") {
            setUnit(unit: units[0])
        }
    }
    
    var body: some View {
//        TabView {
            if UIDevice.current.userInterfaceIdiom == .pad {
                FiresViewiPad().tabItem { ItemLabel(icon: "flame.fill", title: "Wildfires") }
                AQViewiPad().tabItem { ItemLabel(icon: "sun.haze.fill", title: "Air Quality") }
                NewsViewiPad().tabItem { ItemLabel(icon: "newspaper.fill", title: "News") }
                SearchViewiPad().tabItem { ItemLabel(icon: "magnifyingglass", title: "Search") }
            } else {
                FiresView()
//                    .tabItem { ItemLabel(icon: "flame.fill", title: "Wildfires") }
//                AQView().tabItem { ItemLabel(icon: "sun.haze.fill", title: "Air Quality") }
//                NewsView().tabItem { ItemLabel(icon: "newspaper.fill", title: "News") }
//                SearchView().tabItem { ItemLabel(icon: "magnifyingglass", title: "Search") }
            }
//        }
//        .if(UIDevice.current.userInterfaceIdiom == .pad) {
//            $0.sheet(isPresented: !$welcomed) {
//                SplashScreeniPad(show: self.$welcomed)
//            }
//        } else: {
//            $0.fullScreenCover(isPresented: !$welcomed) {
//                SplashScreen(show: self.$welcomed)
//            }   
//        }
    }
}

/// Reduce code redundency
struct ItemLabel: View {
    var icon: String
    var title: String
    
    var body: some View {
        VStack {
            Text(title)
            Image(systemName: icon)
        }
    }
}
