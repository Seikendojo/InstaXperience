//
//  CommentService.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-05-27.
//

import Firebase


struct CommentService {
                
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(FireStoreCompletion)) {
        let data: [String: Any] = ["uid": user.uid,
                                   "comment": comment,
                                   "timestamp": Timestamp(date: Date()),
                                   "username": user.username,
                                   "profileImageUrl": user.profileImageUrl]
        
 
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
    }
    
    static func fetchComments(forPost postID: String, completion: @escaping ([Comment]) -> Void) {
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        query.addSnapshotListener { snapshot, error in
            
        }
        
    }
}

