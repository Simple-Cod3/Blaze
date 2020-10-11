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
    @State var title = "Glossary"
    @State var description = "Tap on any word below to view it's definition."
    @State var on: [String : Bool]
    
    var glossary = GlossaryDatabase.terms
    
    init() {
        var termsToBool: [String : Bool] = [:]
        
        for key in Array(GlossaryDatabase.terms.keys) {
            termsToBool[key] = false
        }
        
        self._on = State(initialValue: termsToBool)
    }
    
    func getStuff(_ key: String) -> Bool {
        return on[key]!
    }
    
    var body: some View {
        ModalPresenter {
            List {
                Header(title: title, desc: description, padding: 10)
                Spacer()
                
                ForEach(Array(on.keys).sorted(), id: \.self) { key in
                    ExpandAlphabetView(key: key)
                }
                .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 20))
            }
            .listSeparatorStyle(.none)
        }
    }
}

struct ExpandAlphabetView: View {
    @State var expand = false
    var key: String
    
    var glossary = GlossaryDatabase.terms
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $expand,
            content: {
                ForEach(glossary[key]!) { term in
                    WordCard(term: term)
                }
            },
            label: {
                HStack(alignment: .bottom) {
                    Header(title: key.capitalized + key)
                    Spacer()
                }
            }
        )
    }
}

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
