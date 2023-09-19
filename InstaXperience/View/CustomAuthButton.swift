//
//  CustomAuthButton.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-10.
//

import UIKit

class CustomAuthButton: UIButton {
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        setTitle(placeHolder, for: .normal)
        setTitleColor(.white, for: .normal)
        backgroundColor = UIColor(red: 0.99, green: 0.69, blue: 1.00, alpha: 1.00).withAlphaComponent(0.5)
        layer.cornerRadius = 5
        setHeight(50)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
