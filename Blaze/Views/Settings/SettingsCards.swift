//
//  SettingsCards.swift
//  Blaze
//
//  Created by Paul Wong on 9/7/20.
//

import SwiftUI

struct SettingsCardLink<Content: View>: View {
    
    private var title: String
    private var desc: String
    private var content: () -> Content
    
    init(title: String, desc: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.desc = desc
        self.content = content
    }
    
    var body: some View {
        NavigationLink(destination: content()) {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                    
                    Text(desc)
                        .font(.subheadline)
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
}

struct SettingsCardCustom<Content: View>: View {
    
    @Binding var loading: Bool
    
    private var title: String
    private var desc: String
    private var content: () -> Content
    
    init(title: String, desc: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.desc = desc
        self._loading = .constant(false)
        self.content = content
    }
    
    init(title: String, desc: String, loading: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.desc = desc
        self._loading = loading
        self.content = content
    }
    
    var body: some View {
//        VStack(alignment: .leading, spacing: 5) {
//            HStack(alignment: .top, spacing: 0) {
//                Text(title)
//                    .fontWeight(.medium)
//                    .font(.title3)
//                    .foregroundColor(.primary)
//
//                Spacer()
//
//                ProgressView()
//                    .scaleEffect(loading ? 1 : 0)
//                    .animation(.spring())
//            }
//            Text(desc).foregroundColor(.secondary)
//
//            Divider()
//                .padding(.vertical, 10)
//                .padding(.bottom, 5)
//
//            content()
//        }
//        .padding(20)
//        .background(Color(.secondarySystemBackground))
//        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                
                Text(desc)
                    .font(.subheadline)
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
