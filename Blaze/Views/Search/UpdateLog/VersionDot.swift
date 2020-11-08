//
//  VersionDot.swift
//  Blaze
//
//  Created by Nathan Choi on 11/5/20.
//

import SwiftUI

struct VersionDot: View {
    var version: String
    var date: String
    var changes: [String]
    
    init(version: String = "1.0", date: String = "10.19.20", changes: [String] = ["Bug Fixes", "Memory leak fix"]) {
        self.version = version
        self.date = date
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
                
                Text(date).foregroundColor(Color(.tertiaryLabel))
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
        .padding(.horizontal, 30)
    }
}
