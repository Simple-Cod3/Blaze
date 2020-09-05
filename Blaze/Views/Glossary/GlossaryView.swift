//
//  GlossaryView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI
import ModalView

struct GlossaryView: View {
    var body: some View {
        ModalPresenter {
            ScrollView {
                VStack {
                    Image("hydrant").resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .padding(20)
                    
                    HStack {
                        Header(title: "Glossary", desc: "Tap on any word below to view it's definition.")
                        Spacer()
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
