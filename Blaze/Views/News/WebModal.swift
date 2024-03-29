//
//  WebModal.swift
//  Blaze
//
//  Created by Nathan Choi on 9/8/20.
//

import SwiftUI
import UIKit
import WebKit
import SafariServices
import Fuzi

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
                if components?.scheme == "http" || components?.scheme == "https" {
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

struct HTMLWebView: UIViewRepresentable {
    
    @Binding var height: CGFloat
    var html: String
    var webview = WKWebView()
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
    
    // Get height and send to binding variable
    class Coordinator: NSObject, WKNavigationDelegate {
        private var parent: HTMLWebView
        
        init(_ parent: HTMLWebView) {
            self.parent = parent
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript(
                "document.body.scrollHeight",
                completionHandler: { height, _ in
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
                if components?.scheme == "http" || components?.scheme == "https" {
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
    
    func makeUIView(context: Context) -> WKWebView {
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

            body {
                font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
                padding: 0px;
                margin: 0;
                line-height: 150%;
                font-size: 1.125rem;
                overflow-wrap: break-word;
            }

            li {
                margin: 0;
                padding-left: 0.2em;
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
        webview.loadHTMLString(htmlStart + html + htmlEnd, baseURL: nil)
        return webview
    }
}

// MARK: - SFSafari View Wrapper
struct SafariViewBootleg: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariViewBootleg>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariViewBootleg>) {
    }
}

// MARK: - INCIWEB HTML Parser
struct InciWebContent: View {
    @State var html = ""
    @State var showLoading = false
    @State var ranOnce = false
    
    var url: URL
    
    func getLatestInfo() {
        URLSession.shared.dataTask(with: url) { unsafeData, _, error in
            guard let data: Data = unsafeData else {
                print("🚫 Couldn't get Inciweb data")
                DispatchQueue.main.async {
                    withAnimation {
                        self.html = "<p>Couldn't find extra information.</p>"
                    }
                }
                return
            }
            
            do {
                let document = try HTMLDocument(data: data)
                
                var builtHTML = ""

                let paragraphs = document.xpath("//*[@id=\"incidentOverview\"]/div/div/p")
                if paragraphs.count > 0 {
                    for pTag in paragraphs {
                        builtHTML += pTag.rawXML
                    }
                } else {
                    DispatchQueue.main.async {
                        withAnimation {
                            self.html = "<p>Couldn't find extra information.</p>"
                        }
                    }
                    return
                }

                DispatchQueue.main.async {
                    withAnimation {
                        self.html = builtHTML
                    }
                }

                print("🎉 Got info for", url)
            } catch {
                print("🚫 Couldn't get Inciweb data: \(error)")
            }
        }.resume()
    }
    
    var body: some View {
        Group {
            if html == "" {
                HStack(spacing: 10) {
                    Spacer()
                    ProgressView()
                    Text("Loading...")
                    Spacer()
                }
                .scaleEffect(showLoading ? 1 : 0.0001)
                .animation(.spring())
                .onAppear { showLoading = true }
            } else {
                NativeWebView(html: html)
            }
        }
        .onAppear {
            if !ranOnce {
                ranOnce = true
                getLatestInfo()
            }
        }
    }
}
