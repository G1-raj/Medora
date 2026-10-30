//
//  AppleSignInButton.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct AppleSignInButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
        .buttonStyle(.plain)
        .accessibilityLabel("Continue with Apple")
    }
}

#Preview {
    AppleSignInButton {
        print("Apple sign in button is pressed")
    }
}
