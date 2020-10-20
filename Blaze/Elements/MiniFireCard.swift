//
//  MiniFireCard.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct MiniFireCard: View {
    @AppStorage("areaUnits") var areaUnits: String = currentUnit ?? units[0]
    
    var selected: Bool
    var fireData: ForestFire
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Image(systemName: "flame")
                .font(.system(size: 26))
                .padding(.bottom, 10)
                .foregroundColor(.secondary)
            Text(fireData.name)
                .font(.system(size: fireData.name.count > 15 ? 20 : 26))
                .fontWeight(.medium)
                .foregroundColor(.secondary)
            
            Spacer()
            HStack {
                Text(fireData.getAreaString(areaUnits))
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(.blaze)
                Spacer()
                NavigationLink(destination: FireMapView(fireData: fireData)) {
                    Text("MAP")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color.blaze)
                        .clipShape(Capsule())
                }
            }
        }
        .padding(15)
        .frame(width: 230, height: 190)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}
