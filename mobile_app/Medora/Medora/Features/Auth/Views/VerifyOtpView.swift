//
//  VerifyOtpView.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct VerifyOtpView: View {
    
    @State private var otp: String = ""
    let email: String
    
    var onVerifyOtp: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                
                header
                
                otpField
                
                AppButton(label: "Verify Otp") {
                    onVerifyOtp()
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
        OtpField(
            otp: $otp
        )
    }
    
    private var resendTimer: some View {
        VStack{}
    }
}

#Preview {
    VerifyOtpView(
        email: "govindrajput7767@gmail.com"
    ) {}
}
