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
    
    var glossary = GlossaryDatabase.terms
    
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
                        ForEach(Array(glossary.keys).sorted(), id: \.self) { key in
                            Header(title: key.capitalized)
                            ForEach(glossary[key]!) { term in
                                WordCard(term: term)
                                    .padding(.horizontal, 20)
                            }
                        }
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
