//
//  AuthNavigationView.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct AuthNavigationView: View {
    
    @State private var userEmail: String = ""
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            OnboardingView(
                onGetStarted: {
                    path.append(AuthRoute.authNavigator)
                }
            )
            .navigationDestination(for: AuthRoute.self) { route in
                switch route {
                case .authNavigator:
                    AuthNavigator {
                        path.append(AuthRoute.logIn)
                    }
                case .logIn:
                    LoginView(
                        onSignUp: {
                            path.append(AuthRoute.signUp)
                        },
                        
                        onForgotPassword: {
                            path.append(AuthRoute.sendOTP)
                        }
                    )
                    
                case .signUp:
                    SignUpView {
                        path = NavigationPath()
                        path.append(AuthRoute.logIn)
                    }
                    
                case .sendOTP:
                    SendOtpView { email in
                        userEmail = email
                        path.append(AuthRoute.verifyOTP)
                    }
                    
                case .verifyOTP:
                    VerifyOtpView(email: userEmail) { 
                        path.append(AuthRoute.changePassword)
                    }
                    
                case .changePassword:
                    ChangePasswordView(email: userEmail) {
                        path = NavigationPath()
                        path.append(AuthRoute.logIn)
                    }
                }
            }
        }
    }
}

#Preview {
    AuthNavigationView()
}
