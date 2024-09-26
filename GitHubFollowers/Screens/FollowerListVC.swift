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
    var currentpage: Int = 1
    var hasMoreFollowers: Bool = true
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(userName: username, page: currentpage)
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
        
        collectionView.delegate = self
    }
   
    func getFollowers(userName: String, page: Int) {
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(for: username, page: currentpage) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers) // append a list sequence of followers
                // here we have a created a strong reference to the class itself
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


extension FollowerListVC: UICollectionViewDelegate {
    // delegate - sitting back and wating for action
    
    // When user end dragging, we have to determine whether or not we are at the bottom to decide whether we should load data.
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y // How far we scrolled down.
        let contentHeight = scrollView.contentSize.height // the total height need to display all the items per network call.
        let screenHeight = scrollView.frame.size.height // the scrren height
        
        if offsetY > contentHeight - screenHeight {
            guard hasMoreFollowers else { return }
            currentpage += 1
            getFollowers(userName: username, page: currentpage)
        }
         
    }
}
