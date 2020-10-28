//
//  ContentView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/26/20.
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
            FiresView().tabItem {
                ItemLabel(icon: "flame.fill",
                          title: "Wildfires")
            }
            AQView().tabItem {
                ItemLabel(icon: "sun.haze.fill",
                          title: "Air Quality")
            }
            NewsView().tabItem {
                ItemLabel(icon: "newspaper.fill",
                          title: "News")
            }
            SearchView().tabItem {
                ItemLabel(icon: "magnifyingglass",
                          title: "Search")
            }
        }
        .fullScreenCover(isPresented: !$welcomed) {
            SplashScreen(show: self.$welcomed)
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
