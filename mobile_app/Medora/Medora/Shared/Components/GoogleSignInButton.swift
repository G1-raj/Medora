//
//  GoogleSignInButton.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct GoogleSignInButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image("google_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                
                Text("Continue with Google")
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.white)
            .clipShape(
                RoundedRectangle(cornerRadius: 18)
            )
            .overlay {
                RoundedRectangle(cornerRadius: 18)
                    .stroke(.gray, lineWidth: 1)
            }
            .padding(.horizontal, 20)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Continue with Google")
    }
}

#Preview {
    GoogleSignInButton {
        print("Google sign in is pressed")
    }
}
