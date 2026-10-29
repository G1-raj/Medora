//
//  AppButton.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct AppButton: View {
    
    let label: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(label)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(.themeAccent)
                .font(.title2)
                .foregroundStyle(.white)
                .bold()
                .clipShape(
                    RoundedRectangle(cornerRadius: 32)
                )
                .padding(.horizontal, 30)
        }
    }
}

#Preview {
    AppButton(
        label: "Continue",
    ) {
        print("Button is pressed")
    }
}
