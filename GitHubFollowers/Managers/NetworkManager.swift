//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/24.
//

import UIKit

class NetworkManager {
    
    static let shared   = NetworkManager()
    let baseUrl         = "https://api.github.com/users/"
    let cache           = NSCache<NSString, UIImage>()
    
    // restrict it so there's only one instance of it. Solution -> make the init "private"
    private init() {} // can not initialize outside the class
    
    func getFollowers(for username: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        // 1. need an url for making network calls
        // In a network manager, typically there's a "base url"
       let endpoint = baseUrl + "\(username)/followers?per_page=100&page=\(page)"
        
        // Make sure we get a valid Url
        // When building an alert, wrapped it into main thread, can not call alert from the backgrond thread. So we pass the error message as the string to the closure to our VC that are using this, because the VC can present the UI of the alert
        guard let url = URL(string: endpoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        // .shared, this is a singleton of URLSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
             // We need to handle the above three variables (data, response, error) in this block of code.
            
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            // is there's a response, put it as a response
            // is the status code 200?
            guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            // if we get the data, we want to check if the data is good. If good, parse that JSON.
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            // error handling
            do {
                let decoder = JSONDecoder() // this decoder can throw, so mark as try
                decoder.keyDecodingStrategy = .convertFromSnakeCase // convert from snake case
                let followers = try decoder.decode([Follower].self , from: data) // we want an array of Followers from data
                completion(.success(followers))
            } catch {
                completion(.failure(.invalidData))
            }
        }
        
        task.resume() // this is what actually starts the network call
    }
    
}
