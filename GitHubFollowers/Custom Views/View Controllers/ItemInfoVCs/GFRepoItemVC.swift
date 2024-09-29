//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/29.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        itemInfoViewOne.set(itemInfoType: .repos, with: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, with: user.publicGists)
        actionButton.set(backgroundColor: .systemPink, title: "Github Profile")
    }
    
}
