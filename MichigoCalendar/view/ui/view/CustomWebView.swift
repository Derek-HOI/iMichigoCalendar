//
//  CustomWebView.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/8/25.
//

import SwiftUI
import WebKit

struct CustomWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.allowsBackForwardNavigationGestures = true
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // 업데이트 로직이 필요하면 추가
    }
}
