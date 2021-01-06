//
//  FlexibleFireInfo.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct FlexibleFireInfo: View {
    
    @EnvironmentObject var fireB: FireBackend
    @Binding var columns: CGFloat
    
    var fireData: ForestFire
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Spacer()
            HStack {
                Image(systemName: "flame")
                    .font(.title2)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
                Spacer()
            }
            
            Text(fireData.name)
                .font(fireData.name.count < 15 ? .title2 : .body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 5)
            
            if fireData.getAreaString() != "Unknown Area" {
                Text(fireData.getAreaString())
                    .foregroundColor(.blaze)
                    .transition(.scale)
            } else {
                Text("Information not available")
                    .foregroundColor(.secondary)
                    .transition(.scale)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            if fireData.getContained() != "Unknown" {
                Text(fireData.getContained() + " Contained")
                    .foregroundColor(.secondary)
                    .transition(.scale)
            }
            
            Spacer()
        }
        .frame(maxHeight: columns == 2 ? 150 : .infinity)
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
