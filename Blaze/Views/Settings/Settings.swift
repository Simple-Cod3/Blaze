//
//  Settings.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI
import ModalView

struct Settings: View {
    @AppStorage("welcomed") var welcomed = true
    @State var selection = 0
    @State var show = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: show ? 20 : 200) {
                Header(title: "Settings", desc: "Customize the app and learn more about it.")
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                UnitsCard(title: "Units", desc: "Change the units of measurement for area.")
                
                SettingsCardLink(title: "Updates", desc: "See the latest changes to Blaze.") {
                    UpdateLog()
                }
                
                SettingsCardCustom(title: "Splash Screen", desc: "View Splash Screen again.") {
                    Toggle("", isOn: !$welcomed)
                        .toggleStyle(SwitchToggleStyle(tint: .blaze))
                }
                
                SettingsCardLink(title: "Credits", desc: "Meet the team behind the app.") {
                    CreditsView()
                }
            }
            .padding(.bottom, 20)
        }
        .navigationBarTitle("", displayMode: .inline)
        .onAppear {
            withAnimation(Animation.spring().delay(0.2)) {
                show = true
            }
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
