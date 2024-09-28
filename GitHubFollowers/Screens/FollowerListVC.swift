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
    var filteredFollowers: [Follower] = []
    var currentpage: Int = 1
    var hasMoreFollowers: Bool = true
    var isSearching: Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureViewController()
        getFollowers(userName: username, page: currentpage)
        configureDataSource()
        configureSearchController()
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
    
    func configureSearchController() {
        let searchController                                   = UISearchController()
        searchController.searchResultsUpdater                  = self
        searchController.searchBar.delegate                    = self
        searchController.searchBar.placeholder                 = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation  = false
        navigationItem.searchController         = searchController
        
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
                
                if self.followers.isEmpty {
                    let message = "This user has no follower."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData(on: followers)
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
    
    
    func updateData(on followers: [Follower]) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        let destVC = UserInfoVC()
        destVC.username = follower.login
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
}


extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        // set the text that user entered as a filter and make sure the text is not empty
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        
        // $0 means each item
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
    
    
}
