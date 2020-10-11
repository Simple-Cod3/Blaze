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
        
    private var terms = GlossaryDatabase.getAllWords().sorted()
    
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
                    if bar.text != "" {
                        ForEach(terms) { term in
                            ExpandAlphabetView(key: term.id)
                        }
                        .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 20))
                    } else {
                        ForEach(wordsList) { word in
                            NavigationLink(destination: ScrollView{Header(title: word.id, desc: word.definition).padding(.vertical, 50)}
                                    .navigationBarTitle("Term", displayMode: .inline)
                            ) {
                                Text(word.id)
                                    .font(.headline)
                                    .fontWeight(.medium)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                    .listSeparatorStyle(.none)
                    .navigationBarTitle(Text("Glossary").font(.system(size: 80)), displayMode: .large)
                    .add(bar)
            }
        }
    }
}

struct ExpandAlphabetView: View {
    @State var expand = false
    @State var show = false
    var key: String
    
    var glossary = GlossaryDatabase.terms
    
    var body: some View {
        NavigationLink(
            destination:
                ScrollView {
                    VStack(spacing: 20) {
                        (Text(key.uppercased()).foregroundColor(.blaze) +
                            Text(key.lowercased()).foregroundColor(Color.blaze.opacity(0.3)))
                            .font(.system(size: 80))
                            .bold()
                            .fixedSize()
                            .padding(.bottom, 40)
                        
                        ForEach(glossary[key]!) { term in
                            WordCard(term: term)
                                .padding(.horizontal, 20)
                        }
                    }
                }.navigationBarTitle("", displayMode: .large)
        ) {
            HStack {
                (Text(key.uppercased()).foregroundColor(.blaze) +
                    Text(key.lowercased()).foregroundColor(Color.blaze.opacity(0.3)))
                    .font(.system(size: 50))
                    .bold()
                    .fixedSize()
                    .padding(.trailing, 40)
                Spacer()
                ForEach(glossary[key]!.prefix(2)) { term in
                    Text(term.id)
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }.padding(.leading, 20)
        }
    }
}

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
