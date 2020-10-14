//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

public let units = ["Acres", "Sq km", "Sq mi"]
public var currentUnit: String? {
    get { UserDefaults.standard.string(forKey: "areaUnits") }
}
public func setUnit(unit: String) {
    UserDefaults.standard.setValue(unit, forKey: "areaUnits")
}

struct ContentView: View {
    @AppStorage("welcomed") private var welcomed = false
    
    init() {
        /// Preload the webview for faster initial loading times
        let _ = URLWebView(url: URL(string: "https://127.0.0.1")!)
        
        if !units.contains(currentUnit ?? "nil") {
            setUnit(unit: units[0])
        }
    }
    
    var body: some View {
        TabView {
            FiresView().tabItem {
                ItemLabel(icon: "flame.fill",
                          title: "Fires")
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
        }.fullScreenCover(isPresented: !$welcomed) {
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
