//
//  UserService.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-24.
//

import Firebase

typealias FireStoreCompletion = (Error?) -> Void

struct UserService {
    
    static func fetchUser(completion: @escaping(User) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)
        }
    }
    
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        
        COLLECTION_USERS.getDocuments { snapshot, error in
            guard let snapshot = snapshot else { return }
            let usersArray = snapshot.documents.map { User(dictionary: $0.data()) }
            completion(usersArray)
            
        }
    }
    
    static func follow(uid: String, completion: @escaping (FireStoreCompletion)) {
        guard let curretnUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(curretnUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(curretnUid).setData([:], completion: completion)
        }
    }
    
    static func unfollow(uid: String, completion: @escaping (FireStoreCompletion)) {
        
    }
}
