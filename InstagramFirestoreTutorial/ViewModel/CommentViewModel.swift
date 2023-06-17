//
//  CommentViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-06-17.
//

import Foundation

struct CommentViewModel {
    
    private let comment: Comment
    
    var profileImageUrl: URL? { return URL(string: comment.profileImageUrl) }
    
    var username: String { return comment.username }
    
    var commentText: String { return comment.commentText  }
    
    init(comment: Comment) {
        self.comment = comment
    }
}
