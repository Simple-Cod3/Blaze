//
//  NewsView.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import SwiftUI

struct NewsView: View {
    
    @EnvironmentObject var phone: PhoneBackend
    @EnvironmentObject var news: NewsBackend
    
    @State private var progress = 0.0
    @State private var newsShown = 10
    @State private var shown: NewsModals?
    
    private enum NewsModals: String, Identifiable {
        var id: String { rawValue }
        case phone, glossary
    }
        
    @Binding var showContacts: Bool
    @Binding var showGlossary: Bool
    @Binding var popup: Bool
    @Binding var secondaryPopup: Bool
    @Binding var secondaryShow: Bool
    
    init(showContacts: Binding<Bool>, showGlossary: Binding<Bool>, popup: Binding<Bool>, secondaryPopup: Binding<Bool>, secondaryShow: Binding<Bool>) {
        self._showContacts = showContacts
        self._showGlossary = showGlossary
        self._popup = popup
        self._secondaryPopup = secondaryPopup
        self._secondaryShow = secondaryShow
    }
    
    func textSize(textStyle: UIFont.TextStyle) -> CGFloat {
        return UIFont.preferredFont(forTextStyle: textStyle).pointSize
    }
    
    private var failed: some View {
        VStack(alignment: .center, spacing: 39) {
            Image(systemName: "xmark.octagon")
                .font(.title)
                .foregroundColor(.red)
            
            Text("Content ")
                .foregroundColor(Color(.tertiaryLabel))
            + Text("failed ")
                .foregroundColor(.red)
                .fontWeight(.medium)
            + Text("to load.")
                .foregroundColor(Color(.tertiaryLabel))
            
            Spacer()
        }
        .font(.subheadline)
        .multilineTextAlignment(.center)
        .padding(.top, 120)
        .padding(.horizontal, 80)
    }

    var body: some View {
        VStack(spacing: 0) {
            HeaderButton("News Overview")
                .padding(.bottom, popup ? 0 : UIConstants.bottomPadding+UIScreen.main.bounds.maxY*0.85)
            
            if popup {
                newsdata
            }
        }
    }
    
    private var newsdata: some View {
        VStack(spacing: 0) {
            Divider()
                .padding(.horizontal, UIConstants.margin)

            ScrollView {
                VStack(spacing: 0) {
                    Button(action: {
                        showContacts = true
                        showGlossary = false
                        
                        withAnimation(.spring(response: 0.39, dampingFraction: 0.9)) {
                            secondaryPopup = true
                            secondaryShow = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                popup = false
                            }
                        }
                    }) {
                        VerticalButton(
                            symbol: "phone.fill",
                            text: "Facility Contacts",
                            desc: "Find the nearest fire stations",
                            mark: "chevron.right",
                            color: .orange
                        )
                    }
                    .buttonStyle(DefaultButtonStyle())
                    .padding(.bottom, 13)
                    
                    Button(action: {
                        showContacts = false
                        showGlossary = true
                        
                        withAnimation(.spring(response: 0.49, dampingFraction: 0.9)) {
                            secondaryPopup = true
                            secondaryShow = true
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                popup = false
                            }
                        }
                    }) {
                        VerticalButton(
                            symbol: "character.book.closed.fill",
                            text: "Glossary",
                            desc: "Learn wildfire terms",
                            mark: "chevron.right",
                            color: .orange
                        )
                    }
                    .buttonStyle(DefaultButtonStyle())
                    
                    SubHeader(title: "Alerts", desc: "Latest news and alerts are sorted by time and in order.")
                        .padding(.vertical, UIConstants.margin)

                    if (news.newsList.count == 0) || news.failed {
                        failed
                    } else {
                        LazyVStack(spacing: 13) {
                            ForEach(news.newsList.prefix(newsShown)) { news in
                                NewsCardButton(news: news)
                            }
                            
                            if news.newsList.count > newsShown {
                                Button(action: {
                                    print(news.newsList.count)
                                    newsShown += 10
                                }) {
                                    MoreButton(symbol: "plus.circle", text: "Show More", color: .orange)
                                }
                            }
                        }
                    }
                }
                .padding(UIConstants.margin)
                .padding(.bottom, UIConstants.bottomPadding*2)
                .padding(.bottom, (textSize(textStyle: .largeTitle)*4))
            }
        }
    }
}
