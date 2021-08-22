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
    @State var wordsList = [Term]()
    
    var letters = Array(GlossaryDatabase.terms.keys).sorted()
    var terms = GlossaryDatabase.getAllWords().sorted()
    
    private func getWords() {
        DispatchQueue.main.async {
            let query = bar.text.lowercased()
            
            self.wordsList = self.terms.filter {
                query.isEmpty ||
                $0.id.lowercased().contains(query)
            }.sorted()
        }
    }
    
    @Binding var showDefinition: Bool
        
    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, 20)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    if bar.text == "" {
//                        ForEach(letters, id: \.self) { letter in
                        GlossaryCard(showDefinition: $showDefinition)
//                        }
                    } else {
                        LazyVStack(spacing: 13) {
                            ForEach(wordsList) { word in
                                NavigationLink(
                                    destination: ScrollView {
            //                                    Header(title: word.id, desc: word.definition)
            //                                        .padding(.vertical, 50)
                                    }.navigationBarTitle("Term", displayMode: .inline)
                                ) {
                                    Text(word.id)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .onChange(of: bar.text) { _ in
                                self.getWords()
                            }
                        }
                    }
                }
                .add(bar)
                .onAppear {
                    self.getWords()
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 16)
            }
        }
    }
}
