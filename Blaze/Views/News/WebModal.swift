//
//  WebModal.swift
//  Blaze
//
//  Created by Nathan Choi on 9/8/20.
//

import SwiftUI
import WebKit

// MARK: - SwiftUI Modal View

/// Loading website modal
struct WebModal: View {
    var dismiss: () -> ()
    var url: URL
    
    var body: some View {
        NavigationView {
            WebView(url: url)
                .navigationBarTitle("News Update", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: { UIApplication.shared.open(url) }) {
                        Image(systemName: "safari")
                            .font(.system(size: 20))
                    }, trailing: Button(action: dismiss) {
                        CloseModalButton()
                    }
                )
        }
    }
}

// MARK: - SwiftUI Wrapper

/// Loading Websites
struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView  {
        let webkitview = WKWebView()
        webkitview.load(URLRequest(url: url))
        return webkitview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
