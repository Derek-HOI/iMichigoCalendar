//
//  WebViewDialog.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/8/25.
//

import SwiftUI

struct WebViewDialog: View {
    let url: URL
    let onDismiss: () -> Void

    var body: some View {
        NavigationView {
            CustomWebView(url: url)
                .edgesIgnoringSafeArea(.all)
                .navigationBarItems(leading: Button("Close") {
                    onDismiss()
                })
        }
    }
}
