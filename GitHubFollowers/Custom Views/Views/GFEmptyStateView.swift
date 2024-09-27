//
//  GFEmptyStateView.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/27.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel = GFTitleLabel(textAlignment: .center, fontSize: 28)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        
        messageLabel.numberOfLines      = 3
        messageLabel.textColor          = .secondaryLabel
        
        
   
        
        NSLayoutConstraint.activate([
            // Constraint for message label
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
      
            
            
            
        ])
        
    }
    

}
