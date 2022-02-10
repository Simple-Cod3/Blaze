//
//  ContentView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import MapKit

public let units = ["Acres", "Sq. km.", "Sq. mi."]
public var currentUnit: String? { UserDefaults.standard.string(forKey: "areaUnits") }
public func setUnit(unit: String) { UserDefaults.standard.setValue(unit, forKey: "areaUnits") }

struct ContentView: View {
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
        NavigationView {
            MainView()
        }
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let fireDatabase = FireBackend()
        let newsBack = NewsBackend()
        let forecastBack = AirQualityBackend()
        let phoneBack = PhoneBackend()
        let mapController = FullFireMapController()

        newsBack.refreshNewsList()
        fireDatabase.refreshFireList()
        phoneBack.refreshPhoneList()

        let contentView = ContentView()
            .environmentObject(newsBack)
            .environmentObject(fireDatabase)
            .environmentObject(forecastBack)
            .environmentObject(phoneBack)
            .environmentObject(mapController)

        return contentView
    }
}
