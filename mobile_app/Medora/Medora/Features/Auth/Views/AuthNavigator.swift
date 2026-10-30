//
//  AuthNavigator.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct AuthNavigator: View {
    
    var onLogIn: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 30)

                    header

                    Spacer(minLength: 40)

                    VStack(spacing: 16) {
                        AppleSignInButton {
                            print("Apple Sign in pressed")
                        }

                        GoogleSignInButton {
                            print("Google sign in pressed")
                        }
                    }

                    divider
                        .padding(.vertical, 28)

                    continueWithEmail

                    Spacer(minLength: 40)

                    termsAndServices
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
                }
                .padding(.horizontal, 24)
                .padding(.top, 32)
                .padding(.bottom, 24)
                .frame(maxWidth: 500)
                .frame(maxWidth: .infinity)
                .frame(minHeight: geometry.size.height)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(.background)
        }
        .toolbar(.hidden, for: .navigationBar)
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
        TextButton(text: "Continue With Email") {
            onLogIn()
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
    
    
}

#Preview {
    AuthNavigator(
        onLogIn: {
            print("Login view")
        }
    )
}
