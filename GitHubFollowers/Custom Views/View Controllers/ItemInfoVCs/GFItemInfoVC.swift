//
//  GFItemInfoViewVC.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/29.
//

import UIKit

class GFItemInfoVC: UIViewController {
    
    // 1. define what's on the VC
    let stackView = UIStackView()
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton = GFButton()
    
    // 2. data model
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        configureBackgronudView()
        layoutUI()
        configureStackView()

    }
    
    // 3. init
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 4. add subview to view
    private func addSubview() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
    }
    
    // 5. background
    
    private func configureBackgronudView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
        
    }
    // 6. layout
    private func layoutUI() {
        let padding: CGFloat = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    // 7. configure stack view
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
    }


}
