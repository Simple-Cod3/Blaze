//
//  VersionDotSoon.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct VersionDotSoon: View {
    
    private var version: String
    private var changes: [String]
    
    init(version: String = "1.0", changes: [String] = ["Bug Fixes", "Memory leak fix"]) {
        self.version = version
        self.changes = changes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(spacing: 7) {
                Image(systemName: "circle")
                
                Text("Coming soon in Blaze \(version)")
                
                Spacer()
            }
            .font(.body.weight(.medium))
            .foregroundColor(.blaze)
            
            HStack(spacing: 7) {
                Image(systemName: "checkmark.circle")
                    .font(.body.weight(.medium))
                    .opacity(0)
                
                VStack(alignment: .leading, spacing: 7) {
                    ForEach(changes, id: \.self) { change in
                        Text(change)
                            .font(.subheadline)
                    }
                }
                .foregroundColor(Color(.tertiaryLabel))
            }
        }
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
