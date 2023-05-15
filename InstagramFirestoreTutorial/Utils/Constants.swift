//
//  Constants.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-24.
//

import Firebase



let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_FOLLOWERS = Firestore.firestore().collection("followers")
let COLLECTION_FOLLOWING = Firestore.firestore().collection("following")
