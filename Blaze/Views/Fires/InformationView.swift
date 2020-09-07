//
//  InformationView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI

struct InformationSection: View {
    var title: String
    var data: [[String]]
    
    var body: some View {
        Section(header: Text(title)) {
            ForEach(data, id: \.self) { row in
                HStack {
                    Text("\(Image(systemName: row[0])) \(row[1])")
                        .font(.headline)
                        .padding(.trailing, 10)
                    Spacer()
                    Text(row[2])
                        .font(.callout)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
                }.contextMenu {
                    if row[1] == "Location" {
                        Text("Lat: \(row[3])")
                        Text("Long: \(row[4])")
                        Divider()
                    }
                    
                    Text(row[1] + " - " + row[2])
                    Button(action: {
                        UIPasteboard.general.string = row[1] + " - " + row[2]
                    }) {
                        HStack {
                            Text("Copy")
                            Spacer()
                            Image(systemName: "doc.on.clipboard")
                        }
                    }
                }
            }
        }
    }
}

struct InformationView: View {
    @Binding var show: Bool
    var fireData: ForestFire
    
    var body: some View {
        NavigationView {
            Form {
                InformationSection(
                    title: "Basic Information",
                    data: [
                        ["flame", "Name", fireData.name],
                        ["mappin.and.ellipse", "Location", fireData.getLocation(),
                         String(fireData.latitude)+"°", String(fireData.longitude)+"°"],
                    ]
                )
                
                InformationSection(
                    title: "Times",
                    data: [
                        ["arrow.counterclockwise.icloud", "Updated", fireData.updated.getElapsedInterval(true)],
                        ["calendar.badge.clock", "Fire Started", fireData.start.getElapsedInterval(true)],
                    ]
                )
                
                InformationSection(
                    title: "Fire Statistics",
                    data: [
                        ["greetingcard", "Acres", fireData.getAreaString()],
                        ["lasso", "Contained", fireData.getContained()],
                    ]
                )
            
                if let url = URL(string: fireData.url) {
                    FormButton(text: "More Info", url: url)
                } else {
                    FormButton(text: "More Info", url: URL(string: "https://google.com")!)
                        .disabled(true)
                }
            }
            .navigationBarTitle("Fire Info")
            .navigationBarItems(
                trailing: Button(action: { show.toggle() }){
                    CloseModalButton()
                }
            )
        }
    }
}
