//
//  PostService.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-05-19.
//

import UIKit
import Firebase

struct PostService {
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FireStoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption,
                        "timeStamp": Timestamp(date: Date()),
                        "likes": 0,
                        "imageUrl": imageUrl,
                        "ownerUid": uid,
                        "ownerImageUrl": user.profileImageUrl,
                        "ownerUsername": user.username] as [String : Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPost(completion: @escaping([Post]) -> Void) {
        COLLECTION_POSTS.order(by:"timeStamp", descending: true).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            let posts = documents.map { Post(postId: $0.documentID, dictionary: $0.data())}
            completion(posts)
        }
    }
    
    static func fetchPosts(forUser uid: String, completion: @escaping ([Post]) -> Void) {
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents else { return }
            
            var posts = documents.map ({ Post(postId: $0.documentID, dictionary: $0.data()) })
            
            posts.sort { (post1, post2) -> Bool in
                return post1.timeStamp.seconds > post2.timeStamp.seconds
            }
            
            completion(posts)
        }
    }
    
    static func likePost(post: Post, completion: @escaping (FireStoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).setData([:], completion: completion)
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping (FireStoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard post.likes > 0 else { return }
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes < 1])
        
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId)
                .delete(completion: completion)
        }
    }
    
    static func checkIfUserLikedPost(post: Post, completion: @escaping (Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
}