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
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.blaze)
                    .padding(5)
                    .padding(.trailing, 7)
                
                Text("Blaze \(version)")
                    .font(.title3)
                    .fontWeight(.medium)
                
                Spacer()
                
                VersionTag("SOON")
            }
            
            HStack(alignment: .top) {
                VStack { Spacer()}
                    .frame(width: 2)
                    .background(Color(.tertiaryLabel))
                    .clipShape(Capsule())
                    .padding(.horizontal, 17)
                    .padding(.vertical, 3)
                    
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(changes, id: \.self) { change in
                        Text(change)
                    }
                }
                .foregroundColor(Color.secondary)
                .padding(.bottom, 15)
                
                Spacer()
            }
            .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.leading, 30)
        .padding(.trailing, 20)
    }
}
