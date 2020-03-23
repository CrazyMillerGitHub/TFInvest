//
//  NewsTopicView.swift
//  News
//
//  Created by Михаил Борисов on 23.03.2020.
//  Copyright © 2020 Mikhail Borisov. All rights reserved.
//

import SwiftUI
import WebKit

struct NewsTopicView: UIViewRepresentable {

    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }

}
