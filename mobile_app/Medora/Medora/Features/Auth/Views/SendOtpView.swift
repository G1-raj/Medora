//
//  SendOtpView.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct SendOtpView: View {
    
    @State private var email: String = ""
    var onSendOtp: (String) -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                header
                
                inputField
                
                AppButton(label: "Send Otp") {
                    onSendOtp(email)
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
        TextFormField(
            label: "Email",
            hintText: "Enter your email",
            fieldType: .email,
            text: $email
        )
    }
}

#Preview {
    SendOtpView() { email in
    
    }
}
