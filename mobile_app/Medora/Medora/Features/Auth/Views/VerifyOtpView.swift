//
//  VerifyOtpView.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct VerifyOtpView: View {
    
    @State private var otp: String = ""
    @State private var isLoading: Bool = false
    @State private var formErrors: VerifyOtpFormErrors = VerifyOtpFormErrors()
    
    let email: String
    var onVerifyOtp: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                header
                
                otpField
                
                AppButton(label: "Verify Otp", isLoading: isLoading) {
                    verifyOtp()
                }
                
                resendTimer
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
            .padding(.bottom, 24)
            .frame(maxWidth: 500)
            .frame(maxWidth: .infinity)
        }
        .scrollDismissesKeyboard(.interactively)
        .background(.background)
    }
    
    private var header: some View {
       VStack(alignment: .leading, spacing: 8) {
           Text("Verify Your Email")
               .font(.largeTitle)
               .foregroundStyle(.black)
               .bold()
           
           Text("Enter the 6-digit code we sent to")
               .multilineTextAlignment(.leading)
               .foregroundStyle(.gray)
           
           Text(email)
               .multilineTextAlignment(.leading)
               .foregroundStyle(.gray)
       }
       .frame(maxWidth: .infinity, alignment: .leading)
   }
    
    private var otpField: some View {
        VStack(spacing: 6) {
            OtpField(
                otp: $otp
            )
            .onChange(of: otp) {
                formErrors.otp = nil
            }
            
            if let error = formErrors.otp {
                validationMessage(error)
            }
        }
    }
    
    private var resendTimer: some View {
        VStack{}
    }
    
    private func validationMessage(_ message: String) -> some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.caption)
            .foregroundStyle(.red)
    }
    
    private func verifyOtp() {
        guard !isLoading else {
            return
        }
        
        let errors = VerifyOtpValidator.validate(otp: otp)
        
        formErrors = errors
        guard !errors.hasErrors else {
            return
        }
        
        
        Task {
            isLoading = true
            
            defer {
                isLoading = false
            }
            
            try? await Task.sleep(for: .seconds(2))

            onVerifyOtp()
        }

        
    }
}

#Preview {
    VerifyOtpView(
        email: "govindrajput7767@gmail.com"
    ) {}
}
