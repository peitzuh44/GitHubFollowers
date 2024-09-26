//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/23.
//

import UIKit


// although it's global, when marking as fileprivate, it can only be access within this file.
fileprivate var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true) 
        }
    }
    
    func showLoadingView() {
        // initialze the container view
        
        containerView = UIView(frame: view.bounds) // view.bounds occupies the whole screen
        
        // add container view to the view
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        
        ])
        
        activityIndicator.startAnimating()
        
    }
    
    func dismissLoadingView() {
        
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
}
