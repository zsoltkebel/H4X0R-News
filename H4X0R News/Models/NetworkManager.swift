//
//  File.swift
//  H4X0R News
//
//  Created by Zsolt Kébel on 09/10/2021.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var posts = [Post]()
    
    func fetchData() {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func fetchData() async -> [Post] {
        if let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            do {
                let (data, _) = try await session.data(from: url)
                let decoder = JSONDecoder()
                let results = try decoder.decode(Results.self, from: data)
                DispatchQueue.main.async {
                    self.posts = results.hits
                }
                return results.hits
            } catch {
                print(error)
            }
        }
        return []
    }
}
