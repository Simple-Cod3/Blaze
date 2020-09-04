//
//  WordCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/4/20.
//

import SwiftUI

struct WordCard: View {
    var word: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Image(systemName: "a.book.closed.fill")
                .font(.system(size: 30))
                .opacity(0.25)
            
            Text(word)
                .font(.title)
                .fontWeight(.bold)
                .opacity(0.75)
        }
        .padding(20)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
    }
}

struct WordCard_Previews: PreviewProvider {
    static var previews: some View {
        WordCard(word: "Anchor \nPoint")
        WordCard(word: "Environmental Impact \nStatement (EIS)")
    }
}
