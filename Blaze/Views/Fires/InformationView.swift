//
//  InformationView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct InformationView: View {
    var dismiss: () -> ()
    var fireData: ForestFire
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Basic Information")) {
                    HStack {
                        Text("Location").font(.headline)
                        Spacer()
                        Text(fireData.getLocation())
                    }
                }
            }
            .navigationBarTitle(fireData.name)
            .navigationBarItems(
                trailing: Button(action: dismiss){ CloseModalButton() }
            )
        }
    }
}
