//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Pei-Tzu Huang on 2024/9/23.
//

import UIKit

class FollowerListVC: UIViewController {
    
    // enums are hashable by default
    enum Section {
        case main
    }
    // initialize all the subViews here
    var username: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var followers: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: Configure Collection View
    func configureCollectionView() {
        
        // 1. initialize the object(collection view)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        
        // 2. use the view
        view.addSubview(collectionView)
        
        // 3. register the cell
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
   
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let followers):
                self.followers = followers // here we have a created a strong reference to the class itself
                self.updateData()
                print(followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            // "as! FollowerCell" to cast it to our custom cell
            
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData() {
        // need to know each section and each individual item which is follower
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        // there's animation, so you should switch to the main thread.
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }
}
