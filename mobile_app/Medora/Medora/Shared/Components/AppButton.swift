//
//  AppButton.swift
//  Medora
//
//  Created by Govine Rajput on 29/10/26.
//

import SwiftUI

struct AppButton: View {
    
    let label: String
    var isLoading = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            if isLoading {
                ProgressView()
                    .tint(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.themeAccent)
                    .clipShape(
                        RoundedRectangle(cornerRadius: 18)
                    )
                    .padding(.horizontal, 30)
            } else {
                Text(label)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(.themeAccent)
                    .font(.title2)
                    .foregroundStyle(.white)
                    .bold()
                    .clipShape(
                        RoundedRectangle(cornerRadius: 18)
                    )
                    .padding(.horizontal, 30)
            }
        }
        .disabled(isLoading)
    }
}

#Preview {
    AppButton(
        label: "Continue",
        isLoading: true
    ) {
        print("Button is pressed")
    }
}
