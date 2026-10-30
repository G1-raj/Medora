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
    
    let email: String
    
    var onPasswordChanged: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                header
                
                formFields
                
                AppButton(label: "Reset Password") {
                    onPasswordChanged()
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
            
            TextFormField(
                label: "Confirm Password",
                hintText: "Confirm your password",
                fieldType: .password,
                text: $confirmPassword
            )
        }
    }
}

#Preview {
    ChangePasswordView(
        email: "govindrajput7767@gmail.com",
        onPasswordChanged: {}
    )
}
