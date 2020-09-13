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
                .edgesIgnoringSafeArea(.bottom)
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
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

// MARK: - WebView Responsive

struct NativeWebView: View {
    @State var height: CGFloat = .zero
    var html: String
    
    var body: some View {
        WebViewNativeHeight(height: $height, html: html)
            .frame(height: height)
    }
}

struct WebViewNativeHeight : UIViewRepresentable {
    @Binding var height: CGFloat
    var html: String
    var webview: WKWebView = WKWebView()

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewNativeHeight

        init(_ parent: WebViewNativeHeight) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.height = height as! CGFloat
                }
            })
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        webview.loadHTMLString(html, baseURL:  nil)
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

