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

                            Text("Improved typography and spacing")
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
