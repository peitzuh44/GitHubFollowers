//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    // reuse id
    static let reuseID = "FollowerCell"
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    let padding: CGFloat = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        
        // Layout of the UIImageView
        NSLayoutConstraint.activate([
            // all the cells have contentView
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            // the width of the cell can vary
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            // setting the height equal to the height
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        
    }
}
