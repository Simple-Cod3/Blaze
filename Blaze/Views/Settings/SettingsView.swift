//
//  SettingsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct SettingsView: View {
    /// No environment variable needed (directly contact App Defaults)
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Simple Settings View")) {
                    Text("Paul is not really straight.")
                }
            }
            .navigationBarTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
