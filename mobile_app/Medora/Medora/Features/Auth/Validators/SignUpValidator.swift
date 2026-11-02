//
//  SignUpValidator.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import Foundation

struct SignUpFormErrors {
    var fullName: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    var hasErrors: Bool {
        fullName != nil ||
        email != nil ||
        password != nil ||
        confirmPassword != nil
    }
}

struct SignUpValidator {
    static func validate(fullName: String, email: String, password: String, confirmPassword: String) -> SignUpFormErrors {
        var errors = SignUpFormErrors()
        
        let trimmedName = fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let trimmedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        // Full name
        if trimmedName.isEmpty {
            errors.fullName = "Full name is required."
        }
        
        // Email
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

        // Confirm password
        if confirmPassword.isEmpty {
            errors.confirmPassword = "Please confirm your password."
        } else if password != confirmPassword {
            errors.confirmPassword = "Passwords do not match."
        }

        return errors
    }
}
