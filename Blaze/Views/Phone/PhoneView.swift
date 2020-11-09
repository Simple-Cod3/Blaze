//
//  PhoneView.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import SwiftUI

struct PhoneView: View {
    @EnvironmentObject var numbers: PhoneBackend
    @ObservedObject var loc = LocationProvider()
    
    @State private var pinned = [PhoneNumber]()
    @State var sortedPhones = [PhoneNumber]()
    
    @State private var text = ""
    @State private var mode = 0
    @State private var show = false
    
    var dismiss: () -> Void
    
    // MARK: - Pin Functionality
    
    // Run first when appear (sets the state)
    private func decodePin() {
        let pinned = UserDefaults.standard.stringArray(forKey: "pinnedFacilities") ?? [String]()
        
        var pinObjects = [PhoneNumber]()
        for pin in pinned {
            for number in numbers.numbers where number.name == pin {
                pinObjects.append(number)
            }
        }
        
        self.pinned = pinObjects
    }
    // Pin a phonenumber and save it
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
    private func removePin(indexSet: IndexSet) {
        pinned.remove(atOffsets: indexSet)
        syncStates()
    }
    // Updates UserDefaults
    private func syncStates() {
        UserDefaults.standard.setValue(pinned.map { $0.name }, forKey: "pinnedFacilities")
    }
    
    // MARK: - View Chooser
    
    private var choices = ["location.circle", "info.circle", "pin.circle"]
    private var labels = ["Nearest to you", "Alphabetically", "By Pinned Facilities"]
    
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
    
    init(dismiss: @escaping () -> Void) {
        self.dismiss = dismiss
        do {
            loc.lm.allowsBackgroundLocationUpdates = false
            try loc.start()
        } catch {
            print("!!! 🚫 Failed to get access to location 🚫 !!!")
            loc.requestAuthorization()
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        ForEach(choices.indices) { index in
                            Button(action: {
                                if index != mode {
                                    mode = index
                                    sortNums()
                                }
                            }) {
                                HStack {
                                    Spacer()
                                        Image(systemName: choices[index])
                                            .font(Font.body.weight(.regular))
                                            .foregroundColor(index == mode ? .blaze : .secondary)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .background(Color(.tertiarySystemBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
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
                }
                .background(Color(.secondarySystemBackground), alignment: .bottom)
                .onChange(of: text) { _ in
                    sortNums()
                }

                if mode == 2 {
                    if pinned.count == 0 {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Save Facilities")
                                .font(.title3)
                                .fontWeight(.semibold)
                            
                            Text("Press and hold on a facility to pin it.")
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                        .padding(.bottom, 20)
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
                                PhoneNumberCell(dismiss: dismiss, addPin: addPin, number: number)
                            }.onDelete(perform: removePin)
                        }
                    }
                } else {
                    Section(header: Text("Sorted \(labels[mode])")) {
                        ForEach(sortedPhones) { number in
                            PhoneNumberCell(dismiss: dismiss, addPin: addPin, number: number)
                        }
                    }
                }
            }
            .navigationBarTitle("Facilities", displayMode: .large)
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
}

