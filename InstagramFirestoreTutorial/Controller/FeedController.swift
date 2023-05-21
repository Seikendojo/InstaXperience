//
//  FeedController.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-03.
//

import UIKit
import Firebase

class FeedController: UICollectionViewController {
    
    //MARK: - Properties
    private let reuseIdentifier = "Cell"

    private var posts = [Post]()

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    //MARK: - Actions

   @objc func handleLogout() {
       do {
           try Auth.auth().signOut()
           let controller = LoginController()
           controller.delegate = self.tabBarController as? MainTabController
           let nav = UINavigationController(rootViewController: controller)
           nav.modalPresentationStyle = .fullScreen
           self.present(nav, animated: true)
           
       } catch {
           print("DEBUG: Signout failed!")
       }
    }
    
    //MARK: - API
    
    func fetchPosts() {
        PostService.fetchPost { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }

    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(handleLogout))
        navigationItem.title = "Feed"
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count  
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FeedCell
        
        let post = posts[indexPath.row]
        cell.viewModel = PostViewModel(post: post)
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

//Define size for each cell
extension FeedController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        return CGSize(width: width , height: height)
    }
}

