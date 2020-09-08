//
//  GlossaryView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI
import ModalView

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
    
    var body: some View {
        ModalPresenter {
            ScrollView {
                VStack(spacing: 0) {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(20)
                    
                    Header(title: title, desc: description)
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(on.keys).sorted(), id: \.self) { key in
                            HStack(alignment: .bottom) {
                                Header(title: key.capitalized)
                                Spacer()
                                Button(
                                    on[key] == true ? "Hide" : "Show",
                                    action: {
                                        withAnimation(.spring()) {
                                            on[key]?.toggle()
                                        }
                                    })
                                    .padding(.trailing, 20)
                                    .foregroundColor(.secondary)
                            }
                            Divider().padding(.horizontal, 20)
                            if on[key] != false {
                                ForEach(glossary[key]!) { term in
                                    WordCard(term: term)
                                        .padding(.horizontal, 20)
                                        .transition(.asymmetric(insertion: .move(edge: .bottom), removal: .scale))
                                }
                            }
                        }.animation(.spring(), value: on)
                    }
                }
            }
        }
    }
}

struct GlossaryView_Previews: PreviewProvider {
    static var previews: some View {
        GlossaryView()
    }
}
