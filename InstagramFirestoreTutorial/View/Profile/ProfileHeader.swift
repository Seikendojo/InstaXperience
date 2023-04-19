//
//  ProfileHeader.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-19.
//

import UIKit



class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemPink
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
