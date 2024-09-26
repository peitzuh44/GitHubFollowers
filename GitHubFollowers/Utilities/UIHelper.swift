//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/24.
//

import UIKit


struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        // Configure Item Width
        let width                        = view.bounds.width
        let padding: CGFloat             = 12
        let minimumItemSpacing: CGFloat  = 10
        let avaliableWidth: CGFloat = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth: CGFloat = avaliableWidth / 3
        
        // initialize and configure flowLayout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        print(itemWidth)

        return flowLayout
    }
    
}
