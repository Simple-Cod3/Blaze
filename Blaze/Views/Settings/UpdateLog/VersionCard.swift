//
//  VersionCard.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct VersionCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    private var version: String
    private var changes: [String]
    
    init(version: String, changes: [String] = ["Bug Fixes", "Memory leak fix"]) {
        self.version = version
        self.changes = changes
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            HStack(spacing: 7) {
                Image(systemName: "checkmark.circle")
                
                Text("What's new in Blaze " + version)
                
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
        .background(colorScheme == .dark ? Color(.tertiarySystemFill) : Color(.tertiarySystemBackground).opacity(0.79))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
