//
//  SettingsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI
import ModalView

struct SearchView: View {
    @EnvironmentObject var fireback: FireBackend
    @ObservedObject var searchBar = SearchBar()
    
    var terms = GlossaryDatabase.getAllWords().sorted()
    
    @State var firesList = [ForestFire]()
    @State var wordsList = [Term]()
    
    @State var showFires = true
    @State var showWords = true
    
    private func getFires() {
        DispatchQueue.main.async {
            let query = searchBar.text.lowercased()
            
            self.firesList = self.fireback.fires.filter {
                query.isEmpty ||
                $0.name.lowercased().contains(query) ||
                $0.location.lowercased().contains(query)
            }.sorted(by: {$0.name < $1.name})
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
                                    NavigationLink(destination: FireMapView(fireData: fire)) {
                                        Text(fire.name)
                                            .font(.headline)
                                            .fontWeight(.regular)
                                            .foregroundColor(.secondary)
                                    }
                                }},
                            label: { HStack {
                                Image(systemName: "flame")
                                    .foregroundColor(.blaze)
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Forest Fires").font(.headline)
                                Spacer()
                                if !showFires {
                                    Text("\(firesList.count)")
                                        .scaleEffect(showFires ? 0 : 1)
                                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .identity))
                                        .animation(.spring())
                                }
                            }}
                        )
                        DisclosureGroup(
                            isExpanded: $showWords,
                            content: {
                                ForEach(wordsList) { word in
                                    NavigationLink(destination: Header(title: word.id, desc: word.definition)
                                            .navigationBarTitle("Term", displayMode: .inline)
                                    ) {
                                        Text(word.id)
                                            .font(.headline)
                                            .fontWeight(.regular)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            },
                            label: { HStack {
                                Image(systemName: "a.book.closed")
                                    .foregroundColor(.blaze)
                                    .font(.system(size: 17, weight: .semibold))
                                Text("Terms and Definitions").font(.headline)
                                Spacer()
                                if !showWords {
                                    Text("\(wordsList.count)")
                                        .scaleEffect(showWords ? 0 : 1)
                                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .identity))
                                        .animation(.spring())
                                }
                            }}
                        )
                    }
                    Section {
                        NavigationLink(destination: Settings()) {
                            Text("Settings").font(.headline)
                        }
                    }
                }
                    .navigationBarTitle("Search")
                    .add(self.searchBar)
            }
                .onChange(of: searchBar.text, perform: { value in
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

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(FireBackend())
    }
}
