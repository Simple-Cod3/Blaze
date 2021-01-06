//
//  VersionCard.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct VersionCard: View {
    
    private var version: String
    private var changes: [String]
    
    init(version: String, changes: [String] = ["Bug Fixes", "Memory leak fix"]) {
        self.version = version
        self.changes = changes
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.blaze)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading) {
                    Text("What's new in")
                        .font(.title)
                        .fontWeight(.medium)

                    Text("Blaze " + version)
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundColor(Color.blaze)
                }
                
                Spacer()
            }
            .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(changes, id: \.self) { change in
                    Text(change)
                }
            }
            .foregroundColor(Color.secondary)
            .padding(.leading, 40)

        }
        .padding(.horizontal, 15)
        .padding(.vertical, 20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
        .padding(.top, 3)
        .padding(.bottom, 10)
    }
}
