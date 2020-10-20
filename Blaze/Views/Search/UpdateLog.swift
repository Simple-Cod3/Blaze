//
//  UpdateLog.swift
//  Blaze
//
//  Created by Paul Wong on 10/17/20.
//

import SwiftUI

struct UpdateLog: View {
    @State var show = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: show ? 5 : 400) {
                HStack {
                    VStack(alignment: .leading, spacing: 0){
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.blaze)
                                .padding(.trailing, 10)
                            
                            VStack(alignment: .leading) {
                                Text("What's new in")
                                    .font(.title)
                                    .fontWeight(.medium)
                                
                                Text("Blaze 1.0.1")
                                    .font(.title)
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.blaze)
                            }
                        }
                        .padding(.bottom, 15)
                                                
                        VStack(alignment: .leading, spacing: 10) {
                            Text("• Fixed a bug where sorting by latest fires will not work")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("• Adjusted the label for latest fire section")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("• Improved typography and padding")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        .padding(.leading, 45)
                    }
                    Spacer()
                }
                .padding(20)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                .padding(20)
                
                VersionDot(
                    version: "1.0",
                    date: "10.17.20",
                    changes: ["• Initial release"]
                )
            }
            .padding(.bottom, 50)
        }
        .navigationBarTitle("Updates", displayMode: .inline)
        .onAppear {
            show = false
            withAnimation(Animation.spring(response: 0.5).delay(0.1)) {
                show = true
            }
        }
    }
}

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
                Text(date)
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.tertiaryLabel))
            }
            .padding(.horizontal, 15)
                    
            VStack(alignment: .leading, spacing: 10) {
                ForEach(changes, id: \.self) { change in
                    Text(change)
                        .font(.body)
                        .fontWeight(.regular)
                }
            }
            .padding(.leading, 63)
            .fixedSize(horizontal: false, vertical: true)
            .foregroundColor(Color.secondary)
            .padding(.bottom, 15)
        }
        .padding(.horizontal, 20)
    }
}


struct UpdateLog_Previews: PreviewProvider {
    static var previews: some View {
        UpdateLog()
    }
}
