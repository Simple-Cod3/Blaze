//
//  SettingsCards.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct SettingsCardLink: View {
    
    private var title: String
    private var desc: String
    
    init(title: String, desc: String) {
        self.title = title
        self.desc = desc
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(desc)
                    .font(.system(size: textSize(textStyle: .subheadline)-1))
                    .foregroundColor(Color(.tertiaryLabel))
            }
            
            Spacer()

            Image(systemName: "chevron.right")
                .font(.body.weight(.medium))
                .foregroundColor(Color(.tertiaryLabel))
                .padding(.trailing, 5)
        }
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}

struct SettingsCardCustom<Content: View>: View {
        
    private var title: String
    private var desc: String
    private var content: () -> Content
    
    init(title: String, desc: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.desc = desc
        self.content = content
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(desc)
                    .font(.system(size: textSize(textStyle: .subheadline)-1))
                    .foregroundColor(Color(.tertiaryLabel))
            }
            
            Spacer()
            
            content()
        }
        .padding(16)
        .background(Color(.quaternarySystemFill))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .contentShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
    }
}
