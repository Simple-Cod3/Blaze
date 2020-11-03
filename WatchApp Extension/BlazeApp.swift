//
//  BlazeApp.swift
//  WatchApp Extension
//
//  Created by Nathan Choi on 11/2/20.
//

import SwiftUI

@main
struct BlazeApp: App {
    var aq = AirQualityBackend()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView().environmentObject(aq)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
