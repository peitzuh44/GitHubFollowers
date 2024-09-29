//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/29.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        itemInfoViewOne.set(itemInfoType: .followers, with: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, with: user.following)
        actionButton.set(backgroundColor: .systemOrange, title: "Github Profile")
    }
    
}
