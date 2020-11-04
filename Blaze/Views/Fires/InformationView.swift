//
//  InformationView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/4/20.
//

import SwiftUI
import ModalView

struct InformationSection: View {
    var title: String
    var data: [[String]]
    
    var body: some View {
        Section(header: Text(title)) {
            ForEach(data, id: \.self) { row in
                HStack(alignment: .top) {
                    Text("\(Image(systemName: row[0])) \(row[1])")
                        .font(.headline)
                        .padding(.trailing, 10)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(row[2])
                        .font(.body)
                        .fontWeight(.regular)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.vertical, 10)
                .contextMenu {
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
            InformationViewInner(show: $show, fireData: fireData)
        }
    }
}

struct FullScreenInfoView: View {
    var dismiss: () -> Void
    var fireData: ForestFire
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView {
                Header(title: "Info", desc: fireData.name)
                    .padding(.top, 50)
                NativeWebView(html: fireData.conditionStatement ?? "")
                    .padding(20)
            }
            Button(action: dismiss) {
                CloseModalButton()
                    .background(Color(.secondarySystemBackground))
                    .clipShape(Circle())
            }.padding([.top, .trailing], 20)
        }
    }
}

struct InformationViewInner: View {
    @Binding var show: Bool
    
    @State var shrink = false
    @State var scrapedHTML = ""
    
    var fireData: ForestFire
    
    private var isNotAccesible: Bool { fireData.acres == -1 && fireData.contained == -1 }
    
    private func actionSheet() {
        var items = [
            ": : : : : : \(fireData.name) : : : : : :",
            " • Location: \(fireData.getLocation())",
            " • Area Burned: \(fireData.getAreaString())",
            " • Contained: \(fireData.getContained())"
        ].map { "\($0)\n"}
        
        if let url = URL(string: fireData.url) {
            items.append("\n🔎 Learn more about it here: \n\(url)")
        }
        
        let actionView = UIActivityViewController(activityItems: [items.joined()], applicationActivities: nil)
        UIApplication.shared.windows[1].rootViewController?.present(actionView, animated: true, completion: nil)
    }
    
    private var header: some View {
        ModalPresenter {
            HStack {
                Text("INFORMATION")
                Spacer()
            }
        }
    }
    
    var body: some View {
        Form {
            if isNotAccesible {
                Section {
                    VStack(alignment: .leading) {
                        Text("\(Image(systemName: "exclamationmark.triangle.fill")) Warning")
                            .font(.headline)
                            .foregroundColor(.yellow)
                            .padding(.bottom, 5)
                        Text("This incident is not accessible on this app at the moment. For more information, click on \"More Info\" below.")
                            .foregroundColor(.secondary)
                    }.padding(.vertical, 10)
                }
            }

            InformationSection(
                title: "Basics",
                data: [
                    ["flame", "Name", fireData.name],
                    ["mappin.and.ellipse", "Location", fireData.getLocation(),
                     String(fireData.latitude)+"°", String(fireData.longitude)+"°"]
                ]
            )

            InformationSection(
                title: "Times",
                data: [
                    ["arrow.counterclockwise.icloud", "Information Updated", fireData.updated.getElapsedInterval(true)],
                    ["calendar.badge.clock", "Fire Started", fireData.started.getElapsedInterval(true)]
                ]
            )

            InformationSection(
                title: "Statistics",
                data: [
                    ["skew", "Area Burned", fireData.getAreaString()],
                    ["lasso", "Contained", fireData.getContained()]
                ]
            )

            if let html = fireData.conditionStatement, html != "" {
                Section(header: header) {
                    NativeWebView(html: html)
                        .padding(.vertical, 5)
                }
            } else if fireData.sourceType == .inciweb {
                Section(header: Text("Info")) {
                    InciWebContent(url: URL(string: fireData.url)!)
                }
            }
            
            if let url = URL(string: fireData.url) {
                if isNotAccesible {
                    FormButtonDirect(text: "More Info", url: url)
                } else {
                    FormButton(text: "More Info", url: url)
                }
            } else {
                FormButton(text: "More Info", url: URL(string: "https://google.com")!)
                    .disabled(true)
            }
        }
        .navigationBarTitle("Fire Info")
        .navigationBarItems(
            trailing: Button(action: { show.toggle() }) {
                CloseModalButton()
            }
        )
    }
}
