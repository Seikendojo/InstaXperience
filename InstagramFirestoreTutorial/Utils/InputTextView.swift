//
//  InputTextView.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-05-18.
//

import UIKit

class InputTextView: UITextView {
    
    //MARK: - Properties
    
    var placeHolderText: String? {
        didSet { placeHolderLabel.text = placeHolderText}
    }
    
    private let placeHolderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeHolederShouldCenter = true {
        didSet {
            if placeHolederShouldCenter {
                placeHolderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
                placeHolderLabel.centerY(inView: self)
            } else {
                placeHolderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
            }
        }
    }

    //MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeHolderLabel)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleTextDidChange() {
        placeHolderLabel.isHidden = !text.isEmpty
    } 
}

