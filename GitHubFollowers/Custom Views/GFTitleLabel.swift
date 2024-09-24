//
//  GFTitleLabel.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/23.
//

import UIKit

class GFTitleLabel: UILabel {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        configureLabel()
    }
    
    func configureLabel() {
        textColor                 = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.9
        lineBreakMode             = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
