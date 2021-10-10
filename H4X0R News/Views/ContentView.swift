//
//  ContentView.swift
//  H4X0R News
//
//  Created by Zsolt Kébel on 09/10/2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) { post in
                NavigationLink(destination: DetailView(post: post)) {
                    HStack {
                        Text(String(post.points))
                        Text(post.title)
                    }
                }
            }
            
            .navigationTitle("H4X0R NEWS")
            .overlay(
                networkManager.posts.count == 0 ? ProgressView() : nil
            )
            .refreshable {
                await networkManager.fetchData()
            }
        }
        .onAppear {
            networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//let posts = [
//    Post(id: "1", title: "Hello"),
//    Post(id: "2", title: "Hola"),
//    Post(id: "3", title: "Hello"),
//]
