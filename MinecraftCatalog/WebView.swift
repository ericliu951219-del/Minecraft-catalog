import SwiftUI
import WebKit
struct WebView: UIViewRepresentable {
    let url: URL
    func makeUIView(context: Context) -> WKWebView {
        let view = WKWebView()
        view.load(URLRequest(url: url))
        view.allowsBackForwardNavigationGestures = true
        return view
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
