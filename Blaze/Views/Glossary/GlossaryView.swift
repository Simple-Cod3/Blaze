//
//  GlossaryView.swift
//  Blaze
//
//  Created by Nathan Choi on 9/5/20.
//

import SwiftUI

struct GlossaryView: View {
    
    @ObservedObject var bar = SearchBar()
    
    @State var wordsList = [Term]()
    
    @Binding var popup: Bool
    @Binding var showDefinition: String
    @Binding var secondaryPopup: Bool
    @Binding var secondaryShow: Bool
    
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
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
            
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                DragBar()

                HStack(spacing: 0) {
                    if showDefinition != "" {
                        Button(action: {
                            withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                                showDefinition = ""
                            }
                        }) {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(Color(.tertiaryLabel))
                                .contentShape(Rectangle())
                                .padding(.trailing, 11)
                        }
                    }
                    
                    Text("Glossary")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    Spacer()
                    
                    Button(action: {
                        if secondaryPopup {
                            popup = true
                        } else {
                            popup = false
                        }
                        
                        withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                            secondaryShow = false
                            showDefinition = ""
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2.weight(.semibold))
                            .foregroundColor(Color(.tertiaryLabel))
                            .contentShape(Rectangle())
                    }
                }
                .padding(.bottom, UIConstants.margin)
            }
            .padding(.horizontal, UIConstants.margin)
            .contentShape(Rectangle())
            .padding(.bottom, secondaryPopup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
                
            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                ScrollViewReader { value in
                    VStack(spacing: 0) {
                        GlossaryCards(showDefinition: $showDefinition, value: value)
                    }
                    .onAppear { getWords() }
                    .padding(UIConstants.margin)
                    .padding(.bottom, UIConstants.bottomPadding)
                    .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
                }
            }
        }
    }
}
