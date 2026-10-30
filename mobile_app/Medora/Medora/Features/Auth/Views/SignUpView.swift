//
//  SignUpView.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct SignUpView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var formErrors = SignUpFormErrors()
    
    @State private var isLoading: Bool = false
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 28) {
                    
                    appBar
                    
                    header
                    
                    formFields
                    
                    AppButton(label: "Create Account", isLoading: isLoading) {
                        createAccount()
                    }
                    .padding(.bottom, 30)
                    
                    
                    
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
    }
    
    private var appBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .bold()
            }
            
            Spacer()
        }
    }
    
    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Create Account")
                .font(.largeTitle)
                .foregroundStyle(.black)
                .bold()
            
            Text("Let's set up your account to get started \nwith Medora.")
                .multilineTextAlignment(.leading)
                .foregroundStyle(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var formFields: some View {
        VStack(spacing: 6) {
            TextFormField(
                label: "Full Name",
                hintText: "Enter your full name",
                fieldType: .username,
                text: $fullName
            )
            .onChange(of: fullName) {
                formErrors.fullName = nil
            }
            
            if let error = formErrors.fullName {
                validationMessage(error)
            }
            
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
                formErrors.confirmPassword = nil
            }
            
            if let error = formErrors.password {
                validationMessage(error)
            }
            
            TextFormField(
                label: "Confrim Password",
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
    
    private var footer: some View {
        HStack(spacing: 4) {
            Spacer()

            Text("Already have an account?")
                .foregroundStyle(.secondary)

            NavigationLink("Sign In") {
                // Replace with your actual SignInView
                Text("Sign In")
            }
            .fontWeight(.semibold)
            .tint(.themeAccent)

            Spacer()
        }
        .font(.subheadline)
    }
    
    private func validationMessage(_ message: String) -> some View {
        Label(message, systemImage: "exclamationmark.circle.fill")
            .font(.caption)
            .foregroundStyle(.red)
    }
    
    
    @MainActor
    private func createAccount() {
        
        guard !isLoading else { return }
        
        let errors = SignUpValidator.validate(
            fullName: fullName,
            email: email,
            password: password,
            confirmPassword: confirmPassword
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
    SignUpView()
}
