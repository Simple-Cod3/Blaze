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
    @State var number = PhoneNumber(name: "Unknown", address: "Unknown", city: "Unknown", phoneNumber: "Unknown", county: "Unknown")

    @State private var mode = 0
    @State private var show = false
    @State private var showPhoneInfo = false
    @State private var focused = false
    @State private var searchText = ""

    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryShow: Bool

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

    private func togglePin(_ pin: PhoneNumber) {
        let savedPinned = UserDefaults.standard.stringArray(forKey: "pinnedFacilities") ?? [String]()

        if let name = pin.name {
            withAnimation {
                if savedPinned.contains(name) {
                    pinned = pinned.filter { $0.name != name }
                } else {
                    pinned.append(pin)
                }
            }
        }

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
                        searchText == "" ||
                            ($0.county?.lowercased() ?? "???").contains(searchText.lowercased()) ||
                            ($0.phoneNumber?.lowercased() ?? "???").contains(searchText.lowercased()) ||
                            ($0.name?.lowercased() ?? "???").contains(searchText.lowercased())
                    })
                    .prefix(searchText.count > 0 ? 999999 : 10)
            )
        }
    }
    
    init(popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryShow: Binding<Bool>) {
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryShow = secondaryShow

        do {
            loc.lm.allowsBackgroundLocationUpdates = false
            try loc.start()
        } catch {
            print("!!! 🚫 Failed to get access to location 🚫 !!!")
            loc.requestAuthorization()
        }
    }
        
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }

    private var searchAnimation = Animation.spring(response: 0.3, dampingFraction: 1)
    private var searching: Bool { searchText != "" && secondaryPopup && !showPhoneInfo }
    private var search: some View {
        HStack(spacing: 10) {
            HStack(spacing: 5) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 16))
                    .foregroundColor(searching ? .blaze : Color(.tertiaryLabel))

                LegacyTextField(
                    text: $searchText.animation(searchAnimation),
                    isFirstResponder: $focused
                ) {
                    $0.placeholder = "Search"
                    $0.returnKeyType = .search
                    $0.autocorrectionType = .no
                }
                .frame(maxHeight: 20)
                .onChange(of: searchText) { _ in
                    sortNums()
                }
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 7, style: .continuous)
                    .fill(Color(.quaternarySystemFill))
            )

            if searching {
                Button("Cancel") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    withAnimation(searchAnimation) {
                        searchText = ""
                    }
                }
                .font(.callout)
            }
        }
        .padding([.horizontal, .bottom], UIConstants.margin)
        .padding(.top, searching ? UIConstants.margin : 0)
    }
    
    var body: some View {
        VStack(spacing: 0) {

            if !searching {
                VStack(spacing: 0) {
                    DragBar()

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

                        Text(showPhoneInfo ? number.name ?? "Unknown" : "Facility Contacts")
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

                            focused = false

                            withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                                secondaryShow = false
                                searchText = ""
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
            }

            if secondaryPopup {
                search
            }

            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                if showPhoneInfo {
                    PhoneInfoView(phoneData: number)
                        .padding(.vertical, UIConstants.margin*2)
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
                                searchText == "" ||
                                ($0.county?.lowercased() ?? "???").contains(searchText.lowercased()) ||
                                ($0.phoneNumber?.lowercased() ?? "???").contains(searchText.lowercased()) ||
                                ($0.name?.lowercased() ?? "???").contains(searchText.lowercased())
                            })
                        ) { number in
                            Button(action: {
                                withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                    self.number = number
                                    showPhoneInfo = true
                                    focused = false
                                }
                            }) {
                                PhoneCard(togglePin: togglePin, number: number)
                            }
                            .buttonStyle(DefaultButtonStyle())
                        }
                    }
                }
            } else {
                VStack(spacing: 13) {
                    ForEach(sortedPhones) { number in
                        Button(action: {
                            self.number = number
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showPhoneInfo = true
                            }
                        }) {
                            PhoneCard(togglePin: togglePin, number: number)
                        }
                        .buttonStyle(DefaultButtonStyle())
                    }
                }
            }

            if sortedPhones.count < 1 {
                HStack {
                    Spacer()
                    Label("No results", systemImage: "xmark.circle")
                    Spacer()
                }
                .foregroundColor(.secondary.opacity(0.7))
                .padding(.vertical, UIConstants.margin)
            }
        }
        .padding(UIConstants.margin)
        .padding(.bottom, UIConstants.bottomPadding)
        .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
    }
}
