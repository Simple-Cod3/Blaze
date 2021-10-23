//
//  PhoneView.swift
//  Blaze
//
//  Created by Max on 9/27/20.
//

import SwiftUI

struct PhoneView: View {
    
    @Environment(\.colorScheme) var colorScheme

    @EnvironmentObject var numbers: PhoneBackend
    @ObservedObject var loc = LocationProvider()
    
    @State private var pinned = [PhoneNumber]()
    @State var sortedPhones = [PhoneNumber]()
    
    @State private var text = ""
    @State private var mode = 0
    @State private var show = false
    @State private var showPhoneInfo = false

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
    
    private var choices = ["Location", "ABC", "Pinned"]
    
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
                    .prefix(text == "" ? 7 : numbers.numbers.count)
            )
        }
    }
    
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool
    
    init(popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryClose: Binding<Bool>) {
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryClose = secondaryClose
    }
        
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Capsule()
                    .fill(Color(.quaternaryLabel))
                    .frame(width: 39, height: 5)
                    .padding(.top, 7)
                    .padding(.bottom, 11)
                
                HStack(spacing: 0) {
                    if showPhoneInfo {
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showPhoneInfo = false
                            }
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(Color(.tertiaryLabel))
                                .contentShape(Rectangle())
                                .padding(.trailing, 11)
                        }
                    }
                    
                    Text(showPhoneInfo ? "Facility name" : "Facility Contacts")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Spacer()
                    
                    Button(action: {
                        if secondaryPopup {
                            popup = true
                        } else {
                            popup = false
                        }
                        
                        withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                            secondaryClose = false
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(Color(.tertiaryLabel))
                            .contentShape(Rectangle())
                    }
                }
                .padding(.bottom, UIConstants.margin)
            }
            .padding(.horizontal, UIConstants.margin)
            .contentShape(Rectangle())
            .padding(.bottom, secondaryPopup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
            
            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                if showPhoneInfo {
//                    PhoneInfoView(phoneData: number)
                } else {
                    phoneList
                }
            }
        }
        .onAppear {
            decodePin()
            sortNums()
            show = true
        }
    }
    
    private var phoneList: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                ForEach(choices.indices) { index in
                    Button(action: {
                        if index != mode {
                            mode = index
                            sortNums()
                        }
                    }) {
                        HStack {
                            Spacer()
                            
                            Text(choices[index])
                                .font(.subheadline)
                                .fontWeight(.medium)
                                .foregroundColor(.primary.opacity(index == mode ? 1 : 0.7))
                            
                            Spacer()
                        }
                        .padding(.vertical, 9)
                        .background(index == mode ? (colorScheme == .dark ? Color(.tertiaryLabel) : Color.white) : Color(.quaternarySystemFill))
                        .clipShape(RoundedRectangle(cornerRadius: 7, style: .continuous))
                    }
                    .buttonStyle(DefaultButtonStyle())
                }
            }
            
            Group {
                if mode == 0 {
                    SubHeader(
                        title: "Sort by location",
                        desc: "Fire stations are sorted by distance from you."
                    )
                }
                
                if mode == 1 {
                    SubHeader(
                        title: "Sort by alphabetical order",
                        desc: "Fire stations are sorted by ascending alphabetical order."
                    )
                }
                
                if mode == 2 {
                    SubHeader(
                        title: "Pinned fire stations",
                        desc: "Pinned fire stations are sorted by time pinned."
                    )
                }
            }
            .padding(.vertical, UIConstants.margin)
            
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
                            Button(action: {
                                withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                    showPhoneInfo = true
                                }
                            }) {
                                PhoneCard(addPin: addPin, number: number)
                            }
                            .buttonStyle(DefaultButtonStyle())
                        }
                        .onDelete(perform: removePin)
                    }
                }
            } else {
                VStack(spacing: 13) {
                    ForEach(sortedPhones) { number in
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showPhoneInfo = true
                            }
                        }) {
                            PhoneCard(addPin: addPin, number: number)
                        }
                        .buttonStyle(DefaultButtonStyle())
                    }
                }
            }
        }
        .padding(UIConstants.margin)
        .padding(.bottom, UIConstants.bottomPadding)
        .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
    }
}
