//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/19.
//

import UIKit


// Creating Reusable Button

// Creating a GFButton on top of the UIButton
class GFButton: UIButton {
    
    /// Step 1 - Create an init with a frame(so we can tell xcode how big the button is). We use override to customize our own button. In this case, we are creating "GFButton" which is a subclass of UIButton. Use "super" to call the default button "UIButton"
    override init(frame: CGRect) { /// This line init the parent one "UIButton". So we got everything that apple built inside
        super.init(frame: frame)
        configure()
    }
    
    
    // This is how to handle initialization via storyboard.
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    // MARK: UI of the Button
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}

