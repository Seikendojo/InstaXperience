//
//  AuthService.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-18.
//

import UIKit
import Firebase


struct AuthCedentials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

struct AuthService {
    
    typealias AuthDataResultCallback = (AuthDataResult?, Error?) -> Void
    
    static func logUserIn(withEmail email: String, password: String, completion:  AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    
    static func registerUser(withCredentials credentials: AuthCedentials, completion: @escaping(Error?) -> Void) {
        
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { results, error in
                
                if let error = error {
                    print("DEBG: Failed to register user \(error.localizedDescription)")
                    return
                }
                
                guard let uid = results?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl": imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                
                Firestore.firestore().collection("users").document(uid).setData(data, completion: completion)
            }
        }
    }
    
}
