//
//  GFBodyLabel.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/23.
//

import UIKit

class GFBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabel()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configureLabel()
    }
    

    func configureLabel() {
        textColor                 = .secondaryLabel
        font                      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
