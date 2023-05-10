//
//  UserCellViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-05-09.
//

import Foundation


struct UserCellViewModel {
    
    private let user: User
    
    var profileImageViewUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
