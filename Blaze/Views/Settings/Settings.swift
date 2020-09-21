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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Header(title: "Settings", desc: "Customize the app and learn more about it!")
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                UnitsCard(title: "Units", desc: "Change the units of measurement for area.")
                
                SettingsCardCustom(title: "Splash Screen", desc: "View splash screen again.") {
                    Toggle("", isOn: !$welcomed)
                        .toggleStyle(SwitchToggleStyle(tint: .blaze))
                }
                
                SettingsCardLink(title: "FAQ", desc: "Provides information about Blaze.") {
                    Header(title: "FAQ", desc: "Frequenty asked questions and their answers.")
                }
                SettingsCardLink(title: "Credits", desc: "Meet the team behind the app.") {
                    CreditsView()
                }
            }
                .padding(.bottom, 20)
        }
            .navigationBarTitle("", displayMode: .inline)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
