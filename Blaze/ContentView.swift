//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var body: some View {
        TabView {
            NewsView().tabItem {
                ItemLabel(icon: "newspaper.fill",
                          title: "News")
            }
            FiresView().tabItem {
                ItemLabel(icon: "flame.fill",
                          title: "Fires")
            }
//            GlossaryView().tabItem {
//                ItemLabel(icon: "a.book.closed",
//                          title: "Glossary")
//            }
            SearchView().tabItem {
                ItemLabel(icon: "magnifyingglass",
                          title: "Search")
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
