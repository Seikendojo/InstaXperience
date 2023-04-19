//
//  AuthenticationViewModel.swift
//  InstagramFirestoreTutorial
//
//  Created by Seiken Dojo on 2023-04-11.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}
protocol AuthenticationViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }

    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(red: 0.33, green: 0.00, blue: 0.92, alpha: 1.00) : UIColor(red: 0.99, green: 0.69, blue: 1.00, alpha: 1.00).withAlphaComponent(0.5)
    }

    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}


struct RegistrationViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    var fullname: String?
    var username: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
        && fullname?.isEmpty == false && username?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? UIColor(red: 0.33, green: 0.00, blue: 0.92, alpha: 1.00) : UIColor(red: 0.99, green: 0.69, blue: 1.00, alpha: 1.00).withAlphaComponent(0.5)
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
 
    
}
