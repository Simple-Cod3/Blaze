//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @AppStorage("welcomed") var welcomed = false
    
    init() {
        /// Preload the webview for faster initial loading times
        let _ = WebView(url: URL(string: "https://127.0.0.1")!)
        
        if UserDefaults.standard.string(forKey: "areaUnits") == nil {
            UserDefaults.standard.setValue("mi2", forKey: "areaUnits")
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
            SplashScreen(show: $welcomed)
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
