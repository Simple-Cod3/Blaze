//
//  Settings.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var fires: FireBackend
    @AppStorage("welcomed") var welcomed = true
    @AppStorage("californiaOnly") var caliOnly = UserDefaults.standard.bool(forKey: "californiaOnly")
    
    @State var selection = 0
    @State var show = false
    @State var progress = 0.0
    
    @Binding var showSettings: Bool
    
    private var loading: Binding<Bool> { Binding(
        get: { !fires.progress.allSatisfy({$0.isFinished}) },
        set: { _ in }
    )}
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                showSettings = false
            }) {
                HeaderButton("Settings")
            }
            .buttonStyle(NoButtonStyle())
            
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(alignment: .leading, spacing: 13) {
                    UnitsCard(title: "Units", desc: "Change the units of measurement for area.")
                    
                    SettingsCardCustom(title: "All Fires", desc: "View fires outside of California", loading: loading) {
                        Button(action: {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.7)) { caliOnly.toggle() }
                        }) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(Font(UIFont.preferredFont(forTextStyle: .title3)))
                                .foregroundColor(caliOnly ? Color.blaze : Color(.tertiaryLabel))
                                .scaleEffect(caliOnly ? 1 : 0.0001)
                                .background(
                                    Image(systemName: "circle")
                                        .font(Font(UIFont.preferredFont(forTextStyle: .title3)))
                                                             .foregroundColor(Color(.tertiaryLabel))
                                        .scaleEffect(caliOnly ? 0.8 : 1)
                                )
                                .contentShape(Rectangle())
                        }
                        .disabled(!fires.progress.allSatisfy({$0.isFinished}))
                    }
                    
                    SettingsCardLink(title: "Updates", desc: "See the latest changes to Blaze.") {
                        UpdateLog()
                    }
                    
                    SettingsCardLink(title: "Credits", desc: "Meet the team behind the app.") {
                        CreditsView()
                    }
                    
                    Caption("Blaze is in constant development. All content is subject to change. In order to provide feedback and contribute, please contact any team members listed in Credits.")
                }
                .padding(20)
            }
        }
        .background(
            RegularBlurBackground()
                .edgesIgnoringSafeArea(.all)
        )
        .onChange(of: caliOnly) { _ in
            fires.refreshFireList()
        }
    }
}
