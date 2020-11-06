//
//  UpdateLog.swift
//  Blaze
//
//  Created by Paul Wong on 10/17/20.
//

import SwiftUI

struct UpdateLog: View {
    @State var show = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: show ? 5 : 400) {
                VersionDotSoon(
                    version: "2.0",
                    changes: ["• Transition to new map structure to include dynamic area and data viewing on map"]
                )
                
                VersionCard(
                    version: "1.1",
                    changes: ["• Added support for all iPad devices", "• Fixed source deprecation and implemented nationwide wildfire data", "• Changed the appearance of \"View All\" button in Wildfires tab", "• Tap and hold on a Wildfires Card to pin to Monitoring List", "• UI Improvements"]
                )
                
                VersionDot(
                    version: "1.0.2",
                    date: "10.27.20",
                    changes: ["• Notice for deprecated source", "• Improved overall UI", "• Implemented roadmap in Updates", "• Front-end logic improvements"]
                )
                
                VersionDot(
                    version: "1.0.1",
                    date: "10.22.20",
                    changes: ["• Fixed a bug where sorting by latest fires will not work", "• Adjusted label for latest fire section", "• Fixed grammar and wording", "• Improved typography and spacing"]
                )
                
                VersionDot(
                    version: "1.0",
                    date: "10.17.20",
                    changes: ["• Initial release"]
                )
            }
            .padding(.top, 20)
            .padding(.bottom, 50)
        }
        .navigationBarTitle("Updates", displayMode: .large)
        .onAppear {
            show = false
            withAnimation(Animation.spring(response: 0.5).delay(0.1)) {
                show = true
            }
        }
    }
}
