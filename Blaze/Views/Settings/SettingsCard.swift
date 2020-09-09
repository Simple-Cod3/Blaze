//
//  SettingsCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

// TODO: Accept Content for versatility
struct SettingsCard: View {
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
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 26))
                    .foregroundColor(.secondary)
            }
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
    }
}

struct SettingsCard_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCard(title: "Credits", desc: "See people who have contributed in this project.")
    }
}
