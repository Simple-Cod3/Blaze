//
//  SettingsCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct UnitsCard: View {
    var title: String
    var desc: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .fontWeight(.semibold)
                .font(.title)
                .foregroundColor(.primary)
            Text(desc)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Divider().padding(.bottom, 5)
            
            HStack {
                Text("Acres")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.blaze)

                Spacer()
                
                Text("Square Miles")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
    }
}

struct UnitsCard_Previews: PreviewProvider {
    static var previews: some View {
        UnitsCard(title: "Units", desc: "Change the units of the fire spread area")
    }
}
