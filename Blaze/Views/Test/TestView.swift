//
//  TestView.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct TestView: View {
    @State var cards = [WordCard(word: "Anchor \nPoint"), WordCard(word: "Anchor \nPoint"), WordCard(word: "Anchor \nPoint")]
    @State var selected: Int = 0

    var body: some View {
        HStack {
            ForEach(cards.indices, id: \.self) { i in
                Button(action: {
                    self.selected = i
                })  {
                    WordCard(word: "Anchor \nPoint")
                        .foregroundColor(i == selected ? .orange : .black)
                        .background(i == selected ? Color.orange : Color(UIColor.secondarySystemBackground))
                        .cornerRadius(15)
                }
            }
        }
    }
}

// Tab bar is needed.

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
