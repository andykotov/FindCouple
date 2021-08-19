//
//  WebView.swift
//  FindCouple
//
//  Created by mr. Hakoda on 19.08.2021.
//

import UIKit
import WebKit
import SwiftUI

extension WebViewContainer {
    class Coordinator: NSObject, WKNavigationDelegate {
        @ObservedObject private var model: Model
        private let parent: WebViewContainer
        
        init(_ parent: WebViewContainer, _ model: Model) {
            self.parent = parent
            self.model = model
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            model.gameBehavior.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            model.gameBehavior.isLoading = false
            model.gameBehavior.title = webView.title ?? ""
            model.gameBehavior.canGoBack = webView.canGoBack
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            model.gameBehavior.isLoading = false
        }
    }
}

struct WebViewContainer: UIViewRepresentable {
    @ObservedObject var model: Model
    
    func makeCoordinator() -> WebViewContainer.Coordinator {
        Coordinator(self, model)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.model.gameBehavior.url) else {
            return WKWebView()
        }
        
        let request = URLRequest(url: url)
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(request)
        
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if model.gameBehavior.shouldGoBack {
            uiView.goBack()
            model.gameBehavior.shouldGoBack = false
        }
    }
}
