//
//  VerifyOtpValidator.swift
//  Medora
//
//  Created by Govine Rajput on 31/10/26.
//

import Foundation

struct VerifyOtpFormErrors {
    var otp: String?
    
    var hasErrors: Bool {
        otp != nil
    }
}

struct VerifyOtpValidator {
    static func validate(otp: String) -> VerifyOtpFormErrors {
        var errors = VerifyOtpFormErrors()
        
        if otp.isEmpty {
            errors.otp = "Otp is required"
        } else if otp.count != 6 || !otp.allSatisfy(\.isNumber) {
            errors.otp = "OTP must be exactly 6 digits"
        }
        
        return errors
    }
}
