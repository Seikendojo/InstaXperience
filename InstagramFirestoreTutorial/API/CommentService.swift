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
        
        // func currentPostDoc() -> DocumentReference? {
        //    if Auth.auth().currentUser != nil {
        //        return COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        //    }
        //    return nil
       // }
    
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        
    }
    
    static func fetchComments() {
        
        
    }
}

