//
//  SearchViewiPad.swift
//  Blaze
//
//  Created by Paul Wong on 11/2/20.
//

import SwiftUI
import ModalView

struct SearchViewiPad: View {
    
    @EnvironmentObject var fireback: FireBackend
    @ObservedObject var searchBar = SearchBar()
    
    private var terms = GlossaryDatabase.getAllWords().sorted()
    
    @State private var firesList = [ForestFire]()
    @State private var wordsList = [Term]()
    
    @State private var showFires = true
    @State private var showWords = false
    
    @State private var sorting = SortingType.alpha
    
    private enum SortingType {
        case alpha
        case alphaReverse
        case size
        case updated
    }
    
    private func getFires() {
        DispatchQueue.main.async {
            let query = searchBar.text.lowercased()
            
            self.firesList = self.fireback.fires.filter {
                query.isEmpty ||
                    $0.name.lowercased().contains(query) ||
                    $0.location.lowercased().contains(query) ||
                    $0.searchKeywords?.lowercased().contains(query) == true ||
                    $0.searchDescription?.lowercased().contains(query) == true
            }
            .sorted(by: {
                switch sorting {
                case .alpha:
                    return $0.name < $1.name
                case .alphaReverse:
                    return $0.name > $1.name
                case .size:
                    return $0.acres > $1.acres
                case .updated:
                    return $0.updated < $0.updated
                }
            })
        }
    }
    private func getWords() {
        DispatchQueue.main.async {
            let query = searchBar.text.lowercased()
            
            self.wordsList = self.terms.filter {
                query.isEmpty ||
                    $0.id.lowercased().contains(query)
            }.sorted()
        }
    }
    
    /// No environment variable needed (directly contact App Defaults)
    var body: some View {
        ModalPresenter {
            NavigationView {
                Form {
                    Section {
                        DisclosureGroup(
                            isExpanded: $showFires,
                            content: {
                                ForEach(firesList) { fire in
                                    NavigationLink(destination: FireMapViewiPad(fireData: fire)) {
                                        Text(fire.name).foregroundColor(.secondary)
                                    }
                                }},
                            label: { HStack {
                                Image(systemName: "flame.fill")
                                    .foregroundColor(.blaze)
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Forest Fires")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                Spacer()
                                if !showFires {
                                    Text("\(firesList.count)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color(.secondarySystemBackground))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.secondary)
                                        .clipShape(Capsule())
                                        .scaleEffect(showWords ? 0 : 1)
                                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .identity))
                                        .animation(.spring())
                                }
                            }}
                        )
                        DisclosureGroup(
                            isExpanded: $showWords,
                            content: {
                                ForEach(wordsList) { word in
                                    NavigationLink(
                                        destination: ScrollView {
                                            Header(title: word.id, desc: word.definition)
                                                .padding(.vertical, 50)
                                        }
                                        .navigationBarTitle("Term", displayMode: .inline)
                                    ) {
                                        Text(word.id).foregroundColor(.secondary)
                                    }
                                }
                            },
                            label: { HStack {
                                Image(systemName: "a.book.closed.fill")
                                    .foregroundColor(.blaze)
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Terms and Definitions")
                                    .font(.headline)
                                    .fontWeight(.medium)
                                Spacer()
                                if !showWords {
                                    Text("\(wordsList.count)")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color(.secondarySystemBackground))
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 4)
                                        .background(Color.secondary)
                                        .clipShape(Capsule())
                                        .scaleEffect(showWords ? 0 : 1)
                                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .identity))
                                        .animation(.spring())
                                }
                            }}
                        )
                    }
                }
                .navigationBarItems(
                    leading: Menu(
                        content: {
                            Text("Sorting Mode")
                            Divider()
                            Button(action: { sorting = .alpha; getFires() }) {
                                HStack {
                                    Text("A-Z")
                                    Spacer()
                                    if sorting == .alpha { Image(systemName: "checkmark.circle.fill") }
                                }
                            }
                            Button(action: { sorting = .alphaReverse; getFires() }) {
                                HStack {
                                    Text("Z-A")
                                    Spacer()
                                    if sorting == .alphaReverse { Image(systemName: "checkmark.circle.fill") }
                                }
                            }
                            Button(action: { sorting = .size; getFires() }) {
                                HStack {
                                    Text("Largest Fires")
                                    Spacer()
                                    if sorting == .size { Image(systemName: "checkmark.circle.fill") }
                                }
                            }
                            Button(action: { sorting = .updated; getFires() }) {
                                HStack {
                                    Text("Latest Updated")
                                    Spacer()
                                    if sorting == .updated { Image(systemName: "checkmark.circle.fill") }
                                }
                            }
                        },
                        label: {
                            Image(systemName: "line.horizontal.3.decrease")
                                .font(Font.title2.weight(.regular))
                        }
                    ),
                    trailing: NavigationLink(destination: SettingsViewiPad()) {
                        Image(systemName: "gear")
                            .font(Font.title2.weight(.regular))
                    }
                )
                .navigationBarTitle("Search")
                .add(self.searchBar)
                
                VStack {
                    Image("bandage").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250)
                        .padding(.bottom, 20)
                    
                    Text("Nothing to see here, we just patched this part up with a bandage.")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(width: 350)
                        .padding(.bottom, 100)
                }
            }
            .onChange(of: searchBar.text, perform: { _ in
                getFires()
                getWords()
            })
            .onAppear {
                getFires()
                getWords()
            }
        }
    }
}
