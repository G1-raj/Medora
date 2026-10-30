//
//  TextButton.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct TextButton: View {
    
    let text: String
    let action: () -> Void
    
    var textColor: Color = .themeAccent
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundStyle(textColor)
                .bold()
        }
        .buttonStyle(.plain)
        .accessibilityLabel(text)
    }
}

#Preview {
    TextButton(text: "Forgot Password?") {
        print("Forgot password button is pressed")
    }
}
