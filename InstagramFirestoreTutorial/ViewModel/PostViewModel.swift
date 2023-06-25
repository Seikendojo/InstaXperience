//
//  PostViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-05-21.
//

import UIKit



struct PostViewModel {
    
    var post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var caption: String { return post.caption }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl) }
    
    var username: String { return post.ownerUsername}
    
    var likes: Int { return post.likes }
    
    var likeButtonTinColor: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName) 
    }
    
    var laikeLabelText: String {
        if post.likes != 1 {
            return " \(post.likes) likes"
        } else {
            return " \(post.likes) like"
        }
    }
    
    init(post: Post) {
        self.post = post
    }
}
