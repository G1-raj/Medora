//
//  LoginView.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct LoginView: View {
    
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var formErrors: SignInFormErrors = SignInFormErrors()
    
    @State private var isLoading: Bool = false
    
    var onSignUp: () -> Void
    var onForgotPassword: () -> Void
    
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header
                
                formFields
                
                forgotPasswordButton
                
                AppButton(label: "Sign In", isLoading: isLoading) {
                    signIn()
                }
                
                divider
                
                oAuthButtons
                    .padding(.bottom, 20)
                
                footer
                
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
            Text("Sign In")
                .font(.largeTitle)
                .foregroundStyle(.black)
                .bold()
            
            Text("Welcome back! Sign in to continue \nyour health journey.")
                .multilineTextAlignment(.leading)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var oAuthButtons: some View {
        VStack(spacing: 16) {
            AppleSignInButton {
                print("Apple SIgn in button is pressed")
            }
            
            
            GoogleSignInButton {
                print("Google sign in button is pressed")
            }
        }
    }
    
    private var formFields: some View {
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
        }
    }
    
    private func validationMessage(_ message: String) -> some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.caption)
            .foregroundStyle(.red)
    }
    
    private var forgotPasswordButton: some View {
        TextButton(text: "Forgot Password?") {
            onForgotPassword()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private var divider: some View {
        HStack(spacing: 8) {
            Rectangle()
                .fill(.gray)
                .frame(height: 1)
                
            
            Text("or")
            
            Rectangle()
                .fill(.gray)
                .frame(height: 1)
        }
        .padding(.horizontal, 30)
    }
    
    private var footer: some View {
        HStack(spacing: 4) {
            Spacer()

            Text("Don't have an account?")
                .foregroundStyle(.secondary)

            TextButton(text: "Sign Up") {
                onSignUp()
            }
            .fontWeight(.semibold)
            .tint(.themeAccent)

            Spacer()
        }
        .font(.subheadline)
    }
    
    private func signIn() {
        guard !isLoading else {
            return
        }
        
        let errors = SignInValidator.validate(
            email: email,
            password: password
        )
        
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

            print("Form validation successful")
        }
    }
    
    
}

#Preview {
    LoginView(
        onSignUp: {}, onForgotPassword: {}
    )
}
