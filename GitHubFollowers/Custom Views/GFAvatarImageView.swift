//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "github-placeholder")!
    let cache            = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius  = 10.0 // this is only setting on UI Image View
        clipsToBounds       = true // this bounds the corner radius to the image
        image               = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        // Step 1 - make sure that there's a url
        // Step 2 - define the task
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
    
        guard let url = URL(string: urlString) else { return }
        // we are not handling error because we alrady have the placeholder
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            // make sure there's no error, valid response and did return data.
            if error != nil { return }
            guard let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            guard let self = self else { return }
            cache.setObject(image, forKey: cacheKey)
            // Update UI on the main thread
                DispatchQueue.main.async {
                    self.image = image // everytime we use self here, we want to mark it as weak.
                }
        }
        task.resume()

    }
}
