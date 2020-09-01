//
//  ArticleContent.swift
//  Blaze
//
//  Created by Nathan Choi on 8/31/20.
//

import WebKit
import SwiftUI
import Down

struct ArticleContent: View {
    @State var height = CGFloat.zero
    let html: String
    
    init(data: String) {
        self.html = data
    }
    
    var body: some View {
        HTMLWebView(contentHeight: $height, html: html)
            .frame(height: height)
    }
}

struct HTMLWebView: UIViewRepresentable {
    @Binding var contentHeight: CGFloat
    var webview: WKWebView = WKWebView()
    var html: String

    // Create webview
    func makeUIView(context: Context) -> WKWebView {
        webview.scrollView.bounces = false
        webview.navigationDelegate = context.coordinator
        webview.isOpaque = false
        webview.backgroundColor = .clear
        webview.scrollView.backgroundColor = .clear
        
        // Custom CSS
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
                            padding: 0;
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
                        hr {
                            border: 0;
                            height: 0.2px;
                            background: lightgray;
                        }
                        a {
                            text-decoration: none !important;
                            color: #63D2FF;
                        }
                        @media (prefers-color-scheme: dark) {
                            body {
                                background-color: #000;
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
                            a { color: #5AC7F9 }
                        }
                    </style>
                </HEAD>
                <BODY>
            """)
        let htmlEnd = "</BODY></HTML>"
        
        guard let rendered = try? Down(markdownString: html).toHTML(.smartUnsafe) else {
            webview.loadHTMLString("\(htmlStart)\(html)\(htmlEnd)", baseURL: nil)
            return webview
        }
        
        let cleanRendered = rendered
            .replacingOccurrences(of: "<p>&amp;nbsp;</p>", with: "<p></p>")
            .replacingOccurrences(of: "<p>&#x200B;</p>", with: "<p></p>")
        
        webview.loadHTMLString("\(htmlStart)\(cleanRendered)\(htmlEnd)", baseURL: nil)
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // Get height and send to binding variable
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: HTMLWebView

        init(_ parent: HTMLWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.clientHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);",
            completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.contentHeight = height as! CGFloat
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
}

