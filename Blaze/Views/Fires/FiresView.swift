//
//  FiresView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct FiresView: View {
    
    @EnvironmentObject var fireB: FireBackend

    // Search Bar stuff
    @State private var searchText = ""

    @State private var prefix = 7
    @State private var largest = true
    @State private var latest = false
    @State private var monitorList = false

    @Binding var showFireInformation: String
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryClose: Bool
    @Binding var focused: Bool
    
    init(showFireInformation: Binding<String>, popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryClose: Binding<Bool>, focused: Binding<Bool>) {
        self._showFireInformation = showFireInformation
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryClose = secondaryClose
        self._focused = focused
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        VStack(spacing: 0) {
            if !searching {
                HeaderButton("Wildfires Overview")
                    .padding(.bottom, popup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
            }

            if popup {
                wildfiremain
            }
        }
    }

    private var searchAnimation = Animation.spring(response: 0.3, dampingFraction: 1)

    private func searchFilter(fire: ForestFire) -> Bool {
        return
            searchText == "" ||
            fire.name.lowercased().contains(searchText.lowercased()) ||
            fire.location.lowercased().contains(searchText) ||
            fire.searchKeywords?.lowercased().contains(searchText) == true ||
            fire.searchDescription?.lowercased().contains(searchText) == true
    }

    private var searching: Bool { searchText != "" && popup }
    private var noResults: Bool {
        if monitorList { return fireB.monitoringFires.filter(searchFilter).count < 1 }
        return fireB.fires.filter(searchFilter).count < 1
    }

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
                .font(.body)
            }
        }
        .padding([.horizontal, .bottom], UIConstants.margin)
        .padding(.top, searching ? UIConstants.margin : 0)
    }
    
    private var wildfiremain: some View {
        VStack(spacing: 0) {
            search

            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                VStack(spacing: 0) {
                    if !searching {
                        Button(action: {
                            largest = false
                            latest = false
                            monitorList = true
                        }) {
                            RectButton(selected: $monitorList, "Monitoring List")
                        }
                        .buttonStyle(DefaultButtonStyle())

                        HStack(spacing: 10) {
                            Button(action: {
                                largest = true
                                latest = false
                                monitorList = false
                            }) {
                                RectButton(selected: $largest, "Largest Fires")
                            }
                            .buttonStyle(DefaultButtonStyle())

                            Button(action: {
                                largest = false
                                latest = true
                                monitorList = false
                            }) {
                                RectButton(selected: $latest, "Latest Fires")
                            }
                            .buttonStyle(DefaultButtonStyle())
                        }
                        .padding(.top, 11)

                        Group {
                            if monitorList {
                                SubHeader(
                                    title: "Monitoring List",
                                    desc: "Showing pinned wildfires."
                                )
                                    .transition(.opacity)
                            } else if largest {
                                SubHeader(
                                    title: "Largest Fires",
                                    desc: "Wildfires are sorted according to their sizes from largest to smallest."
                                )
                                    .transition(.opacity)
                            } else if latest {
                                SubHeader(
                                    title: "Latest Fires",
                                    desc: "Wildfires are sorted based on time updated."
                                )
                                    .transition(.opacity)
                            }
                        }
                        .padding(.vertical, UIConstants.margin)
                    }

                    VStack(spacing: 13) {
                        if largest {
                            ForEach(
                                fireB.fires
                                    .filter(searchFilter)
                                    .sorted(by: { $0.acres > $1.acres })
                                    .prefix(prefix)
                            ) { fire in
                                    FireCard(
                                        showFireInformation: $showFireInformation,
                                        popup: $popup,
                                        secondaryPopup: $secondaryPopup,
                                        secondaryClose: $secondaryClose,
                                        fireData: fire,
                                        area: true
                                    )
                            }
                            .transition(.opacity)
                        } else if latest {
                            ForEach(
                                fireB.fires
                                    .filter(searchFilter)
                                    .sorted(by: { $0.updated > $1.updated })
                                    .prefix(prefix)
                            ) { fire in
                                    FireCard(
                                        showFireInformation: $showFireInformation,
                                        popup: $popup,
                                        secondaryPopup: $secondaryPopup,
                                        secondaryClose: $secondaryClose,
                                        fireData: fire,
                                        area: false
                                    )
                            }
                            .transition(.opacity)
                        }
                    
                        if monitorList {
                            ForEach(fireB.monitoringFires.filter(searchFilter)) { fire in
                                MonitorFireCard(
                                    showFireInformation: $showFireInformation,
                                    popup: $popup,
                                    secondaryPopup: $secondaryPopup,
                                    secondaryClose: $secondaryClose,
                                    fireData: fire
                                )
                                .buttonStyle(PlainButtonStyle())
                                .contextMenu {
                                    Button(action: { fireB.removeMonitoredFire(name: fire.name) }) {
                                        Label("Remove Pin", systemImage: "pin.slash")
                                    }
                                }
                            }
                        }
                        
                        if !monitorList && prefix < fireB.fires.filter(searchFilter).count {
                            Button(action: {
                                prefix += 7
                            }) {
                                MoreButton(symbol: "plus.circle", text: "View More", color: .blaze)
                            }
                            .buttonStyle(DefaultButtonStyle())
                        }

                        if noResults {
                            HStack {
                                Spacer()
                                Label("No results", systemImage: "xmark.circle")
                                Spacer()
                            }
                            .foregroundColor(.secondary.opacity(0.7))
                            .padding(.vertical, UIConstants.margin)
                        }
                    }
                }
                .padding(UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding*2)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
