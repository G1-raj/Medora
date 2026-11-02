//
//  ChangPasswordValidator.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import Foundation

struct ChangePasswordFormErrors {
    var password: String?
    var confirmPassword: String?
    
    var hasErrors: Bool {
        password != nil ||
        confirmPassword != nil
    }
}


struct ChangePasswordValidator {
    static func validate(password: String, confirmPassword: String) -> ChangePasswordFormErrors {
        var errors = ChangePasswordFormErrors()
        
        // Password
        if password.isEmpty {
            errors.password = "Password is required."
        } else if password.count < 8 {
            errors.password =
                "Password must be at least 8 characters."
        }

        // Confirm password
        if confirmPassword.isEmpty {
            errors.confirmPassword = "Please confirm your password."
        } else if password != confirmPassword {
            errors.confirmPassword = "Passwords do not match."
        }
        
        return errors
    }
}
