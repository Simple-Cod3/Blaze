//
//  SettingsiPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/3/20.
//

import SwiftUI
import ModalView

struct SettingsViewiPad: View {
    
    @EnvironmentObject var fires: FireBackend
    @AppStorage("welcomed") var welcomed = true
    @AppStorage("californiaOnly") var caliOnly = UserDefaults.standard.bool(forKey: "californiaOnly")
    @State var selection = 0
    @State var show = false
    
    @State var progress = 0.0
    
    private var loading: Binding<Bool> { Binding(
        get: { !fires.progress.allSatisfy({$0.isFinished}) },
        set: { _ in }
    )}
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: show ? 20 : 200) {
                Text("Customize the app and learn more about it.")
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 20)
                
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 20),
                    GridItem(.flexible(), spacing: 20)
                ], spacing: show ? 20 : 200) {
                    UnitsCard(title: "Units", desc: "Change the units of measurement for area.")
                    
                    SettingsCardCustom(title: "All Fires", desc: "View fires outside of California", loading: loading) {
                        Toggle("", isOn: $caliOnly)
                            .toggleStyle(SwitchToggleStyle(tint: .blaze))
                            .disabled(!fires.progress.allSatisfy({$0.isFinished}))
                    }
                    
                    SettingsCardLink(title: "Monitoring List", desc: "Select different wildfires to monitor.") {
                        MonitoringListView()
                    }
                    
                    SettingsCardLink(title: "Updates", desc: "See the latest changes to Blaze.") {
                        UpdateLog()
                    }
                    
                    SettingsCardLink(title: "Credits", desc: "Meet the team behind the app.") {
                        CreditsView()
                    }
                }
                .padding(.horizontal, 20)
                
                Caption("Blaze is in constant development. All content is subject to change. In order to provide feedback and contribute, please contact any team members listed in Credits.")
            }
        }
        .navigationBarTitle("Settings", displayMode: .large)
        .onAppear {
            withAnimation(Animation.spring().delay(0.2)) {
                show = true
            }
        }
        .onChange(of: caliOnly) { _ in
            fires.refreshFireList()
        }
    }
}
