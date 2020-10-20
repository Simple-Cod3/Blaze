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
                        Text("What's new in")
                            .font(.title)
                            .fontWeight(.semibold)

                        Text("Blaze 1.0.1")
                            .font(.title)
                            .fontWeight(.medium)
                            .foregroundColor(Color.blaze)

                        Divider().padding(.vertical, 20)

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Fixed a bug where sorting by latest fires will not work")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Adjusted the label for latest fire section")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)

                            Text("Improved typography and spacing")
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
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
                
                    Text("This area will expand as we accept user feedback and make changes accordingly to improve Blaze.")
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding(40)
                
                VersionDot(
                    color: .green,
                    version: "1.0",
                    changes: ["Initial release"]
                )
                
                VersionDot(
                    color: .green,
                    version: "1.0.1",
                    changes: ["Fixed a bug where sorting by latest fires will not work", "Adjusted the label for latest fire section", "Improved typography and spacing"]
                )
            }.padding(.bottom, 50)
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

struct VersionDot: View {
    var color: Color
    var version: String
    var time: String
    var changes: [String]
    
    init(color: Color = .blaze, version: String = "1.0", time: String = "10.19.20", changes: [String] = ["Bug Fixes", "Memory leak fix"]) {
        self.color = color
        self.version = version
        self.time = time
        self.changes = changes
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 25))
                    .foregroundColor(.blaze)
                    .padding(5)
                    .padding(.trailing, 7)
                Text("Blaze \(version)")
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
                Text(time)
                    .foregroundColor(Color(.tertiaryLabel))
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            
            HStack(alignment: .top) {
                VStack { Spacer()}
                    .frame(width: 3)
                    .background(Color(.tertiaryLabel))
                    .clipShape(Capsule())
                    .padding(.horizontal, 16)
                    .padding(.vertical, 3)
                    
                VStack(alignment: .leading, spacing: 15) {
                    ForEach(changes, id: \.self) { change in
                        Text(change)
                    }
                }
                    .foregroundColor(Color.secondary)
                    .padding(.bottom, 15)
                
                Spacer()
            }.fixedSize(horizontal: false, vertical: true)
        }.padding(.horizontal, 30)
    }
}


struct UpdateLog_Previews: PreviewProvider {
    static var previews: some View {
        UpdateLog()
    }
}
