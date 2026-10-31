//
//  SendOtpValidator.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import Foundation

struct SendOtpFormErrors {
    var email: String?
    
    var hasErrors: Bool {
        email != nil
    }
}

struct SendOtpValidator {
    static func validate(email: String) -> SendOtpFormErrors {
        var errors = SendOtpFormErrors()
        
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
        
        
        return errors
    }
}
