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
    var post: Post?

    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    //MARK: - Actions
    
    @objc func handleRefresh() {
        posts.removeAll()
        fetchPosts()
    }

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
        guard post == nil else { return }
        
        PostService.fetchPost { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.collectionView.reloadData()
        }
    }

    
    //MARK: - Helpers
    
    func configureUI() {
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout",
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(handleLogout))
        }
    
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FeedCell
        
        cell.delegate = self
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }
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

//MARK: - FeedCellDelegate

extension FeedController: FeedCellDelegate {
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        
        if post.didLike {
            print("DEBUG: Unlike post here...")
            PostService.unlikePost(post: post) { _ in
                print("DEBUG: Unlike post did complete...")
                cell.likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
            }
        } else {
            print("DEBUG: Like post here...")
            PostService.likePost(post: post) { _ in
                cell.likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                print("DEBUG: Like post did complete...")
                cell.likeButton.tintColor = .red
            }
        }
    }
    
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
}
