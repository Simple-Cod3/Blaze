//
//  GlossaryView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI
import ModalView
import SwiftUIListSeparator

struct GlossaryView: View {
    @ObservedObject var bar = SearchBar()
    @State private var wordsList = [Term]()
    
    private var letters = Array(GlossaryDatabase.terms.keys).sorted()
    private var terms = GlossaryDatabase.getAllWords().sorted()
    
    var dismiss: () -> Void
    
    init(dismiss: @escaping () -> Void) {
        self.dismiss = dismiss
    }
    
    private func getWords() {
        DispatchQueue.main.async {
            let query = bar.text.lowercased()
            
            self.wordsList = self.terms.filter {
                query.isEmpty ||
                $0.id.lowercased().contains(query)
            }.sorted()
        }
    }
    
    var body: some View {
        ModalPresenter {
            NavigationView {
                List {
                    if bar.text == "" {
                        ForEach(letters, id: \.self) { letter in
                            ExpandAlphabetView(key: letter, dismiss: dismiss)
                        }
                        .listRowInsets(
                            EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 20)
                        )
                    } else {
                        ForEach(wordsList) { word in
                            NavigationLink(
                                destination: ScrollView {
                                    Header(title: word.id, desc: word.definition)
                                        .padding(.vertical, 50)
                                }.navigationBarTitle("Term", displayMode: .inline)
                            ) {
                                Text(word.id)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .onChange(of: bar.text) { _ in
                            self.getWords()
                        }
                    }
                }
                    .listSeparatorStyle(.none)
                    .navigationBarTitle(Text("Glossary"), displayMode: .large)
                    .navigationBarItems(trailing: Button(action: dismiss) {
                        CloseModalButton()
                    })
                    .add(bar)
            }
        }.onAppear {
            self.getWords()
        }
    }
}
