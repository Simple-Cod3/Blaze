//
//  TestCard.swift
//  Blaze
//
//  Created by Paul Wong on 9/2/20.
//

import SwiftUI

struct TestCard: View {
    var title: String
    var acres: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(systemName: "flame.fill")
                .font(.system(size: 30))
                .opacity(0.5)
                .padding(.bottom, 5)
            
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .opacity(0.75)
            
            Spacer()
            
            HStack {
                Text(acres)
                    .font(.body)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                
                Spacer()
                
                InfoButton(text: "Map")
            }
        }
        .padding(20)
        .frame(width: 250, height: 210)
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(15)
    }
}

struct InfoButton: View {
    var text: String
        
    var body: some View {
        VStack {
            Text(text)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 7)
        .background(Color.orange)
        .cornerRadius(20)
    }


}


struct TestCard_Previews: PreviewProvider {
    static var previews: some View {
        TestCard(title: "ElkHorn Fire", acres: "39,995 Acres")
        InfoButton(text: "Map")
    }
}
