//
//  AuthNavigator.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct AuthNavigator: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer(minLength: 30)

                header

                Spacer(minLength: 40)
                
                VStack(spacing: 16) {
                    loginWithAppleButton
                    loginWithGoogleButton
                }
                
                divider
                    .padding(.vertical, 28)
                
                continueWithEmail
                
                Spacer(minLength: 40)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.background)
            .toolbar(.hidden)
            .safeAreaInset(edge: .bottom, spacing: 0) {
                termsAndServices
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 12)
                    .frame(maxWidth: .infinity)
                    .background(.background)
            }
        }
    }
    
    private var header: some View {
        VStack(spacing: 12) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .accessibilityHidden(true)

            Text("Your health, in rhythm.")
                .font(.title3.weight(.semibold))
                .foregroundStyle(.themeAccent)
                .multilineTextAlignment(.center)
        }
    }
    
    private var continueWithEmail: some View {
        Button {
            
        } label: {
            Text("Continue with Email")
                .foregroundStyle(.themeAccent)
                .bold()
        }
    }
    
    private var termsAndServices: some View {
        VStack {
            Text("By continuing, you agree to our")
            
            HStack {
                Text("Terms of Service")
                    .foregroundStyle(.themeAccent)
                    .bold()
                    .onTapGesture {
                        print("Terms of service")
                    }
                
                Text("and")
                
                Text("Privacy Policy")
                    .foregroundStyle(.themeAccent)
                    .bold()
                    .onTapGesture {
                        print("Privacy Policy")
                    }
            }
        }
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
    
    private var loginWithAppleButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 16) {
                Image(systemName: "apple.logo")
                    .font(.system(size: 30))
                    .foregroundStyle(.white)
                
                Text("Continue with Apple")
                    .foregroundStyle(.white)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.themeAccent)
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .padding(.horizontal, 20)
        }
    }
    
    private var loginWithGoogleButton: some View {
        Button {
            
        } label: {
            HStack(spacing: 16) {
                Image("google_logo")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 30, height: 30)
                
                Text("Continue with Google")
                    .foregroundStyle(.black)
                    .bold()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    AuthNavigator()
}
