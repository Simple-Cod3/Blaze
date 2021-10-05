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
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView {
                VStack(spacing: 10) {
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
                                .background(Color(.tertiarySystemGroupedBackground))
                                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                            }
                            .buttonStyle(CardButtonStyle())
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
                    .background(Color(.tertiarySystemGroupedBackground))
                    .cornerRadius(10)
                    .onChange(of: text) { _ in
                        sortNums()
                    }
                }
                .padding(.horizontal, 20)
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
                    VStack(spacing: 13) {
                        ForEach(
                            pinned.filter({
                                text == "" ||
                                    ($0.county?.lowercased() ?? "???").contains(text.lowercased()) ||
                                    ($0.phoneNumber?.lowercased() ?? "???").contains(text.lowercased()) ||
                                    ($0.name?.lowercased() ?? "???").contains(text.lowercased())
                            })
                        ) { number in
                            PhoneNumberCard(addPin: addPin, number: number)
                        }
                        .onDelete(perform: removePin)
                    }
                }
            } else {
                ForEach(sortedPhones) { number in
                    PhoneNumberCard(addPin: addPin, number: number)
                }
            }
        }
        .onAppear {
            decodePin()
            sortNums()
            show = true
        }
    }
}
