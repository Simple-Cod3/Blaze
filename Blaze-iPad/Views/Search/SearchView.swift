//
//  SearchView.swift
//  Blaze-iPad
//
//  Created by Paul Wong on 10/31/20.
//

import SwiftUI
import ModalView

struct SearchView: View {
    @EnvironmentObject var fireback: FireBackend
    @ObservedObject var searchBar = SearchBar()
    
    private var terms = GlossaryDatabase.getAllWords().sorted()
    
    @State private var firesList = [ForestFire]()
    @State private var wordsList = [Term]()
    
    @State private var showFires = true
    @State private var showWords = false
    
    private func getFires() {
        DispatchQueue.main.async {
            let query = searchBar.text.lowercased()
            
            self.firesList = self.fireback.fires.filter {
                query.isEmpty ||
                    $0.name.lowercased().contains(query) ||
                    $0.location.lowercased().contains(query) ||
                    $0.searchKeywords?.lowercased().contains(query) == true ||
                    $0.searchDescription?.lowercased().contains(query) == true
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
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .foregroundColor(.secondary)
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
                                        Text(word.id)
                                            .font(.body)
                                            .fontWeight(.regular)
                                            .foregroundColor(.secondary)
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
                            Button("Sorting #1", action: {})
                            Button("Sorting #2", action: {})
                            Menu(
                                content: {
                                    Button("Even deeper lol.", action: {})
                                }, label: {
                                    Button("Sorting #Clickme", action: {})
                                }
                            )
                        },
                        label: {
                            Image(systemName: "line.horizontal.3.decrease")
                                .font(Font.title2.weight(.regular))
                        }
                    ),
                    trailing: NavigationLink(destination: Settings()) {
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
                        .font(.title3)
                        .fontWeight(.medium)
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