//
//  Settings.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var fires: FireBackend
    
    @AppStorage("californiaOnly") var caliOnly = UserDefaults.standard.bool(forKey: "californiaOnly")
    
    @State var selection = 0
    @State var show = false
    @State var progress = 0.0
    
    @State var showUpdates = false
    @State var showCredits = false
    
    @Binding var showSettings: Bool
    
    private var loading: Binding<Bool> { Binding(
        get: { !fires.progress.allSatisfy({$0.isFinished}) },
        set: { _ in }
    )}
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Capsule()
                    .fill(Color(.quaternaryLabel))
                    .frame(width: 39, height: 5)
                    .padding(.top, 7)
                    .padding(.bottom, 11)
                
                HStack(spacing: 0) {
                    if showUpdates || showCredits {
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showUpdates = false
                                showCredits = false
                            }
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(Color(.tertiaryLabel))
                                .contentShape(Rectangle())
                                .padding(.trailing, 11)
                        }
                    }
                    
                    Text(showCredits ? "Credits" : (showUpdates ? "Updates" : "Settings"))
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    Spacer()
                    
                    Button(action: {
                        showSettings = false

                        withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                            showUpdates = false
                            showCredits = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(Color(.tertiaryLabel))
                            .contentShape(Rectangle())
                    }
                }
                .padding(.bottom, UIConstants.margin)
            }
            .padding(.horizontal, UIConstants.margin)
            
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 13) {
                        UnitsCard(title: "Units", desc: "Change the units of measurement for area.")
                        
                        fireToggle
                        
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showUpdates = true
                            }
                        }) {
                            SettingsCardLink(title: "Updates", desc: "See the latest changes to Blaze.")
                        }
                        .buttonStyle(DefaultButtonStyle())

                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showCredits = true
                            }
                        }) {
                            SettingsCardLink(title: "Credits", desc: "Meet the team behind the app.")
                        }
                        .buttonStyle(DefaultButtonStyle())
                    }
                    .padding(.bottom, UIConstants.margin)
                    
                    Caption("Blaze: Wildfires (Blaze) is in constant development. All content is subject to change. In order to provide feedback and contribute, please contact any team members listed in Credits.\n\nBlaze is not responsible for any consequences caused by misinformation while using the app.")
                }
                .padding(UIConstants.margin)
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
    
    private var fireToggle: some View {
        Button(action: {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) { caliOnly.toggle() }
        }) {
            SettingsCardCustom(title: "All Fires", desc: "View fires outside of California") {
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
                    .scaleEffect(!fires.progress.allSatisfy({$0.isFinished}) ? 0.0001 : 1)
                    .animation(.spring())
                    .contentShape(Rectangle())
                    .overlay(
                        ProgressView()
                            .scaleEffect(fires.progress.allSatisfy({$0.isFinished}) ? 0.0001 : 1)
                            .animation(.spring())
                    )
            }
        }
        .buttonStyle(DefaultButtonStyle())
        .disabled(!fires.progress.allSatisfy({$0.isFinished}))
    }
}
