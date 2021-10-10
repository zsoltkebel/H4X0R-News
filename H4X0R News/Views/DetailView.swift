//
//  DetailView.swift
//  H4X0R News
//
//  Created by Zsolt Kébel on 09/10/2021.
//

import SwiftUI

struct DetailView: View {
    
    let post: Post?
    let webView: WebView?
    
    init(post: Post) {
        self.post = post
        webView = WebView(urlString: post.url)
    }
    
    var body: some View {
        ZStack {
            if webView?.urlString == nil {
                Text(post!.title)
            } else {
                webView
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            BottomBarButton(imageName: "chevron.backward") {
                                webView?.webView.goBack()
                            }
                            BottomBarButton(imageName: "chevron.forward") {
                                webView?.webView.goForward()
                            }
                            Spacer()
                            BottomBarButton(imageName: "arrow.clockwise") {
                                webView?.webView.reload()
                            }
                        }
                    }
            }
        }
    }
}

struct BottomBarButton: View {
    let imageName: String
    let onPressed: () -> Void
    
    var body: some View {
        Button {
            onPressed()
        } label: {
            Image(systemName: imageName)
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(post: Post(objectID: "1", points: 0, title: "Title", url: "https://www.google.com"))
        }
    }
}


