//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/27.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        
        navigationItem.rightBarButtonItem = doneButton
        
        guard let username = username else { return }
        print(username)
        
        NetworkManager.shared.getUserInfo(username: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                presentGFAlertOnMainThread(title: "Error here", message: "\(error.rawValue)", buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC() {
        dismiss(animated: true)
    }
    
    func getUserInfo(username: String) {
        
        NetworkManager.shared.getUserInfo(username: username) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                presentGFAlertOnMainThread(title: "Error here", message: "\(error.rawValue)", buttonTitle: "OK")
            }
        }
    }

}
