//
//  ChangePasswordView.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isLoading: Bool = false
    @State private var formErrors: ChangePasswordFormErrors = ChangePasswordFormErrors()
    
    let email: String
    var onPasswordChanged: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                header
                
                formFields
                
                AppButton(label: "Reset Password", isLoading: isLoading) {
                    changePassword()
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
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
       VStack(alignment: .leading, spacing: 8) {
           Text("Reset Password")
               .font(.largeTitle)
               .foregroundStyle(.black)
               .bold()
           
           Text("Set a new password for your account.")
               .multilineTextAlignment(.leading)
               .foregroundStyle(.gray)
       }
       .frame(maxWidth: .infinity, alignment: .leading)
   }
    
    private var formFields: some View {
        VStack(spacing: 6) {
            TextFormField(
                label: "Password",
                hintText: "Enter your password",
                fieldType: .password,
                text: $password
            )
            .onChange(of: password) {
                formErrors.password = nil
            }
            
            if let error = formErrors.password {
                validationMessage(error)
            }
            
            TextFormField(
                label: "Confirm Password",
                hintText: "Confirm your password",
                fieldType: .password,
                text: $confirmPassword
            )
            .onChange(of: confirmPassword) {
                formErrors.confirmPassword = nil
            }
            
            if let error = formErrors.confirmPassword {
                validationMessage(error)
            }
        }
    }
    
    private func validationMessage(_ message: String) -> some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.caption)
            .foregroundStyle(.red)
    }
    
    private func changePassword() {
        guard !isLoading else {
            return
        }
        
        let errors = ChangePasswordValidator.validate(
            password: password,
            confirmPassword: confirmPassword
        )
        
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

            onPasswordChanged()
        }
    }
}

#Preview {
    ChangePasswordView(
        email: "govindrajput7767@gmail.com",
        onPasswordChanged: {}
    )
}
