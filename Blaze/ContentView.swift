//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView().tabItem {
                ItemLabel(icon: "flame",
                          title: "Fires")
            }
            FiresView().tabItem {
                ItemLabel(icon: "flame",
                          title: "Fires")
            }
            SettingsView().tabItem {
                ItemLabel(icon: "gear",
                          title: "Settings")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
