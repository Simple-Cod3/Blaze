//
//  UpdateLog.swift
//  Blaze
//
//  Created by Paul Wong on 10/17/20.
//

import SwiftUI

struct UpdateLog: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 25) {
                HStack {
                    VStack(alignment: .leading, spacing: 0){
                        Text("What's new in")
                            .font(.title)
                            .fontWeight(.medium)
                            .fixedSize(horizontal: true, vertical: true)
                        
                        Text("Blaze 1.0")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color.blaze)
                            .padding(.bottom, 10)
                            .fixedSize(horizontal: true, vertical: true)
                        
                        Text("Initial release")
                            .font(.body)
                            .fontWeight(.regular)
                            .foregroundColor(.secondary)
                            .fixedSize(horizontal: true, vertical: true)
                    }
                    Spacer()
                }
                .padding(20)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(20)
                                
                //Replace this with VersionContent() after first update.
                VStack(alignment: .leading, spacing: 5) {
                    Text("Future Updates")
                        .font(.title3)
                        .fontWeight(.medium)
                        .fixedSize(horizontal: false, vertical: true)
                
                    Text("This area will expand as we accept user feedback and make changes accordingly to improve Blaze.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct VersionContent: View {
    var PreviousVersion: String
    var PreviousVersionContent: String
    
    init(_ PreviousVersion: String, _ PreviousVersionContent: String) {
        self.PreviousVersion = PreviousVersion
        self.PreviousVersionContent = PreviousVersionContent
    }
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "checkmark.circle.fill")
                .font(.title)
                .foregroundColor(Color.blaze)
                .padding(.trailing, 5)
            
            VStack(alignment: .leading, spacing: 3) {
                Text("Blaze 1.0")
                    .font(.headline)
                    .padding(.bottom, 5)
                    .fixedSize(horizontal: false, vertical: true)
            
                Text("Bug fixes and improvements \nBig bug fix")
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal, 20)
    }
}


struct UpdateLog_Previews: PreviewProvider {
    static var previews: some View {
        UpdateLog()
    }
}
