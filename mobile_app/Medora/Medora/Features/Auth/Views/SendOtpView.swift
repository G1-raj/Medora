//
//  SendOtpView.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct SendOtpView: View {
    
    @State private var email: String = ""
    @State private var isLoading: Bool = false
    @State private var formErrors: SendOtpFormErrors = SendOtpFormErrors()
    
    
    
    var onSendOtp: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header
                
                inputField
                
                AppButton(label: "Send Otp", isLoading: isLoading) {
                    sendOtp()
                }
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
           Text("Forgot Password?")
               .font(.largeTitle)
               .foregroundStyle(.black)
               .bold()
           
           Text("No worries! Enter your email and we'll \n send you a verification code")
               .multilineTextAlignment(.leading)
               .foregroundStyle(.gray)
       }
       .frame(maxWidth: .infinity, alignment: .leading)
   }
    
    
   private var inputField: some View {
       VStack(spacing: 6) {
           TextFormField(
               label: "Email",
               hintText: "Enter your email",
               fieldType: .email,
               text: $email
           )
           .onChange(of: email) {
               formErrors.email = nil
           }
           
           if let error = formErrors.email {
                validationMessage(error)
           }
           
           
       }
    }
    
    private func validationMessage(_ message: String) -> some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.caption)
            .foregroundStyle(.red)
    }
    
    private func sendOtp() {
        guard !isLoading else {
            return
        }
        
        let errors = SendOtpValidator.validate(email: email)
        
        formErrors = errors
        guard !errors.hasErrors else {
            return
        }
        
        let normalizedEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
        
        Task {
            isLoading = true
            
            defer {
                isLoading = false
            }
            
            try? await Task.sleep(for: .seconds(2))

            onSendOtp(email)
        }
    }
}

#Preview {
    SendOtpView() { email in
    
    }
}
