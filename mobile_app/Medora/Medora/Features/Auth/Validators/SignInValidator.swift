//
//  SignInValidator.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import Foundation

struct SignInFormErrors {
    var email: String?
    var password: String?
    
    var hasErrors: Bool {
        email != nil ||
        password != nil
    }
}

struct SignInValidator {
    static func validate(email: String, password: String) -> SignInFormErrors {
        var errors = SignInFormErrors()
        
        
        //Email
        let trimmedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
    
        if trimmedEmail.isEmpty {
            errors.email = "Email is required."
        } else {
            let emailPattern =
                #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#

            let isValid = trimmedEmail.range(
                of: emailPattern,
                options: .regularExpression
            ) != nil

            if !isValid {
                errors.email = "Please enter a valid email."
            }
        }
        
        // Password
        if password.isEmpty {
            errors.password = "Password is required."
        } else if password.count < 8 {
            errors.password =
                "Password must be at least 8 characters."
        }
        
        
        return errors
    }
}
