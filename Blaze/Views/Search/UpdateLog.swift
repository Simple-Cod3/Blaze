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
                VersionDotSoon(
                    version: "2.1",
                    changes: ["• Improve performance and load times."]
                )
                
                VersionCard(
                    version: "2.0",
                    changes: ["• Added support for iPad", "• Fixed source deprecation", "• Implemented nationwide wildfire data", "• UI Improvements"]
                )
                
                VersionDot(
                    version: "1.0.2",
                    date: "10.27.20",
                    changes: ["• Notice for deprecated source", "• Improved overall UI", "• Implemented roadmap in Updates", "• Front-end logic improvements"]
                )
                
                VersionDot(
                    version: "1.0.1",
                    date: "10.22.20",
                    changes: ["• Fixed a bug where sorting by latest fires will not work", "• Adjusted label for latest fire section", "• Fixed grammar and wording", "• Improved typography and spacing"]
                )
                
                VersionDot(
                    version: "1.0",
                    date: "10.17.20",
                    changes: ["• Initial release"]
                )
            }
            .padding(.top, 20)
            .padding(.bottom, 50)
        }
        .navigationBarTitle("Updates", displayMode: .large)
        .onAppear {
            show = false
            withAnimation(Animation.spring(response: 0.5).delay(0.1)) {
                show = true
            }
        }
    }
}

struct VersionCard: View {
    var version: String
    var changes: [String]
    
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
                    .font(.body)
                    .fontWeight(.regular)
                    .foregroundColor(Color(.tertiaryLabel))
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

struct VersionDotSoon: View {
    var version: String
    var changes: [String]
    
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

struct VersionTag: View {
    var text: String
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        VStack {
            Text(text)
                .font(.footnote)
                .fontWeight(.medium)
                .foregroundColor(.black)
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 7)
        .background(Color.yellow)
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}
