//
//  WebModal.swift
//  Blaze
//
//  Created by Nathan Choi on 9/8/20.
//

import SwiftUI
import UIKit
import WebKit

// MARK: - SwiftUI Modal View

/// Loading website modal
struct WebModal: View {
    var dismiss: () -> ()
    var url: URL
    
    private func actionSheet() {
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows[1].rootViewController?.present(av, animated: true, completion: nil)
    }
    
    var body: some View {
        NavigationView {
            URLWebView(url: url)
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
struct URLWebView: UIViewRepresentable {
    let url: URL
    var webview = WKWebView()
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    func makeUIView(context: Context) -> WKWebView {
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url))
        
        return webview
    }
    
    // Get height and send to binding variable
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: URLWebView

        init(_ parent: URLWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                if navigationAction.navigationType == .linkActivated {
                    guard let url = navigationAction.request.url else {
                        decisionHandler(.allow)
                        return
                    }
                    
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.scheme == "http" || components?.scheme == "https"
                    {
                        UIApplication.shared.open(url)
                        decisionHandler(.cancel)
                    } else {
                        decisionHandler(.allow)
                    }
                } else {
                    decisionHandler(.allow)
                }
            }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

// MARK: - WebView Responsive

struct NativeWebView: View {
    @State var height: CGFloat = .zero
    var html: String
    
    var body: some View {
        HTMLWebView(height: $height, html: html)
            .frame(height: height)
    }
}

struct HTMLWebView : UIViewRepresentable {
    @Binding var height: CGFloat
    var html: String
    var webview = WKWebView()
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // Get height and send to binding variable
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLWebView

        init(_ parent: HTMLWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.body.scrollHeight",
            completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.height = height as! CGFloat
                }
            })
        }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                if navigationAction.navigationType == .linkActivated {
                    guard let url = navigationAction.request.url else {
                        decisionHandler(.allow)
                        return
                    }
                    
                    let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                    if components?.scheme == "http" || components?.scheme == "https"
                    {
                        UIApplication.shared.open(url)
                        decisionHandler(.cancel)
                    } else {
                        decisionHandler(.allow)
                    }
                } else {
                    decisionHandler(.allow)
                }
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
                padding: 0px;
                margin: 0;
                line-height: 150%;
                font-size: 1.125rem;
                overflow-wrap: break-word;
            }

            li {
                padding-left: 0.5em;
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
}
