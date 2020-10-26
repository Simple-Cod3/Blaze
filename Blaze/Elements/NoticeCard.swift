//
//  NoticeCard.swift
//  Blaze
//
//  Created by Paul Wong on 10/26/20.
//

import SwiftUI

struct NoticeCard: View {
    var title: String
    var text: String
    
    init(title: String = "1.0", text: String = "Placeholder") {
        self.title = title
        self.text = text
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .center) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.title3)
                    
                    Text(title)
                        .font(.title3)
                        .fontWeight(.medium)
                }
                
                Text(text)
                    .foregroundColor(Color.secondary)
            }
            Spacer()
        }
        .padding(20)
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.horizontal, 20)
    }
}

struct NoticeCard_Previews: PreviewProvider {
    static var previews: some View {
        NoticeCard(
            title: "Deprecated Source",
            text: "Placeholder"
        )
    }
}
