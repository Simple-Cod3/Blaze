//
//  PhoneView.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import SwiftUI

struct PhoneView: View {

    // Run first when appear (sets the state)
    private func decodePin() {
        let pinned = UserDefaults.standard.stringArray(forKey: "pinnedFacilities") ?? [String]()
        
        var pinObjects = [PhoneNumber]()
        for pin in pinned {
            for number in numbers.numbers {
                if number.name == pin {
                    pinObjects.append(number)
                }
            }
        }
        
        print(pinned)
        self.pinned = pinObjects
    }
    
    private func addPin(_ newPin: PhoneNumber) {
        var pinned = UserDefaults.standard.stringArray(forKey: "pinnedFacilities") ?? [String]()
        
        if let name = newPin.name,
           !pinned.contains(name) {
            pinned.append(name)
            self.pinned.append(newPin)
        }
        
        UserDefaults.standard.setValue(pinned, forKey: "pinnedFacilities")
    }
    
    // When envoke remove
    func removePin(indexSet: IndexSet) {
        pinned.remove(atOffsets: indexSet)
        syncStates()
    }
    
    // Updates UserDefaults
    func syncStates() {
        UserDefaults.standard.setValue(pinned.map{$0.name}, forKey: "pinnedFacilities")
    }
    
    @State var pinned = [PhoneNumber]()
    
    @EnvironmentObject var numbers: PhoneBackend
    @ObservedObject var loc = LocationProvider()
    @State var text = ""
    
    var dismiss: () -> ()
    
    private var choices = ["location.circle.fill", "info.circle.fill", "pin.circle.fill", ]
    private var choiceColors = [Color.blue, Color.green, Color.yellow]
    private var labels = ["Nearest to you", "Alphabetically", "By Pinned Facilities"]
    
    @State var sortedPhones = [PhoneNumber]()
    private func sortNums() {
        DispatchQueue.main.async {
            sortedPhones = Array(
                numbers.numbers
                    .sorted(by: {
                        if mode == 0 {
                            let lhsD = $0.distanceFromUser(
                                x: loc.location?.coordinate.latitude ?? -999,
                                y: loc.location?.coordinate.longitude ?? -999
                            )
                            
                            let rhsD = $1.distanceFromUser(
                                x: loc.location?.coordinate.latitude ?? -999,
                                y: loc.location?.coordinate.longitude ?? -999
                            )
                            
                            return lhsD < rhsD
                        } else {
                            return $0.county ?? "ZZZ"  < $1.county ?? "ZZZ"
                        }
                    })
                    .filter({
                        text == "" ||
                        ($0.county?.lowercased() ?? "???").contains(text.lowercased()) ||
                        ($0.phoneNumber?.lowercased() ?? "???").contains(text.lowercased()) ||
                        ($0.name?.lowercased() ?? "???").contains(text.lowercased())
                    })
                    .prefix(text == "" ? 5 : numbers.numbers.count)
            )
        }
    }
    
    @State var mode = 0
    @State var show = false
    
    init(dismiss: @escaping () -> ()) {
        self.dismiss = dismiss
        do {
            loc.lm.allowsBackgroundLocationUpdates = false
            try loc.start()
        }
        catch {
            print("!!! 🚫 Failed to get access to location 🚫 !!!")
            loc.requestAuthorization()
        }
    }

    var body: some View {
        NavigationView {
            List {
                Section {
                    LazyVStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Text("Facilities")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.blaze)
                            Spacer()

                            ForEach(choices.indices) { i in
                                Button(action: {
                                    if i != mode {
                                        mode = i
                                        sortNums()
                                    }
                                }) {
                                    Image(systemName: choices[i])
                                        .font(.system(size: 30))
                                        .foregroundColor(i == mode ? choiceColors[i] : Color(.tertiaryLabel))
                                        .scaleEffect(show ? 1 : 0)
                                        .animation(
                                            Animation.spring(response: 0.5 + Double(i)*0.1, dampingFraction: 0.5)
                                                .delay(0.8)
                                        )
                                }
                                    .buttonStyle(PlainButtonStyle())
                            }
                        }

                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search", text: $text)
                                .foregroundColor(.primary)
                                .keyboardType(.alphabet)
                        }
                        .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.tertiarySystemBackground))
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.1), radius: 15, y: 10)
                    }.padding(.vertical, 40)
                }
                .onChange(of: text) { _ in
                    sortNums()
                }
                
                if mode == 2 {
                    if pinned.count == 0 {
                        VStack(spacing: 10) {
                            Image("pin").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                            Text("Save Facilities").font(.title).bold()
                            Text("Press and hold on a table to cell to pin it here")
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .font(.headline)
                        }.padding(40)
                    } else {
                        Section(header: Text("Sorted \(labels[mode])")) {
                            ForEach(
                                pinned.filter({
                                    text == "" ||
                                    ($0.county?.lowercased() ?? "???").contains(text.lowercased()) ||
                                    ($0.phoneNumber?.lowercased() ?? "???").contains(text.lowercased()) ||
                                    ($0.name?.lowercased() ?? "???").contains(text.lowercased())
                                })
                            ) { number in
                                PhoneNumberCell(addPin: addPin, number: number)
                            }.onDelete(perform: removePin)
                        }
                    }
                } else {
                    Section(header: Text("Sorted \(labels[mode])")) {
                        ForEach(sortedPhones) { number in
                            PhoneNumberCell(addPin: addPin, number: number)
                        }
                    }
                }

            }
            .listStyle(GroupedListStyle())
            .background(Color(.tertiarySystemGroupedBackground).edgesIgnoringSafeArea(.bottom))
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: dismiss) {
                    CloseModalButton()
                }
            )
            .onAppear {
                decodePin()
                sortNums()
                show = true
            }
        }
    }
    
    private struct PhoneNumberCell: View {
        var addPin: (PhoneNumber) -> ()
        var number: PhoneNumber
        
        var body: some View {
            NavigationLink (destination: Text("Comming Soon...").font(.headline)) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(number.name?.replacingOccurrences(of: " CLOSED", with: "") ?? "Unknown Name")
                            .font(.headline)
                            .foregroundColor(.primary)
                        HStack(spacing: 10) {
                            if let county = number.county {
                                Text(county)
                                    .fontWeight(.medium)
                                    .font(.caption)
                            }

                            Text(number.phoneNumber!)
                                .fontWeight(.medium)
                                .font(.caption)

                            Spacer()
                        }.foregroundColor(.secondary)
                    }
                    Spacer()
                    Check(yes: number.name!.contains(" CLOSED"), interval: 0)
                }
                .padding(.vertical, 10)
            }
                .contextMenu {
                    Button(action: { addPin(number) }) {
                        HStack {
                            Text("Pin Facility")
                            Image(systemName: "pin.circle.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 25))
                        }
                    }
                }
        }
    }
}
