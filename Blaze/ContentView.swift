//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

public let units = ["Acres", "Sq km", "Sq mi"]
public var currentUnit: String? { UserDefaults.standard.string(forKey: "areaUnits") }
public func setUnit(unit: String) { UserDefaults.standard.setValue(unit, forKey: "areaUnits") }

struct ContentView: View {
    @AppStorage("welcomed") private var welcomed = false
    
    init() {
        if !units.contains(currentUnit ?? "nil") {
            setUnit(unit: units[0])
        }
    }
    
    var body: some View {
        TabView {
            if UIDevice.current.userInterfaceIdiom == .pad {
                FiresViewiPad().tabItem { ItemLabel(icon: "flame.fill", title: "Wildfires") }
                AQViewiPad().tabItem { ItemLabel(icon: "sun.haze.fill", title: "Air Quality") }
                NewsViewiPad().tabItem { ItemLabel(icon: "newspaper.fill", title: "News") }
                SearchViewiPad().tabItem { ItemLabel(icon: "magnifyingglass", title: "Search") }
            } else {
                FiresView().tabItem { ItemLabel(icon: "flame.fill", title: "Wildfires") }
                AQView().tabItem { ItemLabel(icon: "sun.haze.fill", title: "Air Quality") }
                NewsView().tabItem { ItemLabel(icon: "newspaper.fill", title: "News") }
                SearchView().tabItem { ItemLabel(icon: "magnifyingglass", title: "Search") }
            }
        }
        .fullScreenCover(isPresented: !$welcomed) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                SplashScreen(show: self.$welcomed)
            }
        }
        .sheet(isPresented: !$welcomed) {
            if UIDevice.current.userInterfaceIdiom == .pad {
                SplashScreeniPad(show: self.$welcomed)
            }
        }
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

extension Color {
    static let blaze = Color("blaze")
}

/// Inverting any binding boolean with prefix: `!`
/// https://stackoverflow.com/questions/59474045/swiftui-invert-a-boolean-binding
prefix func ! (value: Binding<Bool>) -> Binding<Bool> {
    Binding<Bool>(
        get: { !value.wrappedValue },
        set: { value.wrappedValue = !$0 }
    )
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
