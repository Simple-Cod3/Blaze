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
    
    func actionSheet() {
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows[1].rootViewController?.present(av, animated: true, completion: nil)
    }
    
    var body: some View {
        NavigationView {
            WebView(url: url)
                .edgesIgnoringSafeArea(.bottom)
                .navigationBarTitle("News Update", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: actionSheet) {
                        Image(systemName: "square.and.arrow.up")
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
        /// Modifiers
        webview.scrollView.isScrollEnabled = false
        webview.isOpaque = false
        webview.backgroundColor = .clear
        webview.scrollView.backgroundColor = .clear
        webview.navigationDelegate = context.coordinator
        
        /// Custom CSS
        let htmlStart = ("""
<HTML>
    <HEAD>
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no,
            maximum-scale=1.0,
            user-scalable=no\">
        <style>
            * { user-select: none; -webkit-user-select: none; }

            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
                padding: 5px;
                margin: 0;
                line-height: 150%;
                font-size: 1.125rem;
                overflow-wrap: break-word;
            }
            
            h1 {
                color: #000;
                font-size: 1.563rem;
            }

            h2 {
                color: #000;
                font-size: 1.438rem;
            }

            h3 {
                color: #000;
                font-size: 1.25rem;
            }

            img {
                max-width: 100%;
                object-fit: contain;
            }

            hr {
                border: 0;
                height: 0.2px;
                background: lightgray;
            }

            a {
                text-decoration: none !important;
                color: #F85E2A;
            }

            @media (prefers-color-scheme: dark) {
                body {
                    color: #fff;
                }

                h1 {
                    color: #fff;
                    font-size: 1.563rem;
                }

                h2 {
                    color: #fff;
                    font-size: 1.438rem;
                }

                h3 {
                    color: #fff;
                    font-size: 1.25rem;
                }

                a { color: #F85E2A }
            }
        </style>
    </HEAD>
    <BODY>
""")
        let htmlEnd = "</BODY></HTML>"
        webview.loadHTMLString(htmlStart + html + htmlEnd, baseURL:  nil)
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
