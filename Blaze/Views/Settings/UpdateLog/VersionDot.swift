//
//  VersionDot.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct VersionDot: View {
    
    private var version: String
    private var date: String
    private var changes: [String]
    
    init(version: String = "1.0", date: String = "10.19.20", changes: [String] = ["Bug Fixes", "Memory leak fix"]) {
        self.version = version
        self.date = date
        self.changes = changes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(spacing: 7) {
                Image(systemName: "checkmark.circle")
                
                Text("Blaze \(version)")
                
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
                .foregroundColor(.secondary.opacity(0.7))
            }
        }
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
