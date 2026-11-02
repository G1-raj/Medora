//
//  OtpField.swift
//  Medora
//
//  Created by Govine Rajput on 30/10/26.
//

import SwiftUI

struct OtpField: View {
    
    let length: Int
    @Binding var otp: String

    @FocusState private var isFocused: Bool

    init(length: Int = 6, otp: Binding<String>) {
        self.length = max(1, length)
        self._otp = otp
    }
    
    var body: some View {
        ZStack {
            // Actual input field
            TextField("", text: $otp)
                .keyboardType(.numberPad)
                .textContentType(.oneTimeCode)
                .focused($isFocused)
                .onChange(of: otp) { _, newValue in
                    let filtered = String(
                        newValue.filter { $0.isNumber }.prefix(length)
                    )

                    if filtered != newValue {
                        otp = filtered
                    }

                    if filtered.count == length {
                        isFocused = false
                    }
                }
                .frame(width: 1, height: 1)
                .opacity(0.01)

            // Visual OTP boxes
            HStack(spacing: 10) {
                ForEach(0..<length, id: \.self) { index in
                    let characters = Array(otp)
                    let digit = index < characters.count
                        ? String(characters[index])
                        : ""

                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)

                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                isFocused &&
                                index == min(otp.count, length - 1)
                                    ? Color.blue
                                    : Color.gray.opacity(0.5),
                                lineWidth: isFocused &&
                                index == min(otp.count, length - 1)
                                    ? 2 : 1
                            )

                        Text(digit)
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                }
            }
            .allowsHitTesting(false)
        }
        .contentShape(Rectangle())
        .padding(.horizontal, 20)
        .onTapGesture {
            isFocused = true
        }
    }
}

#Preview {
    @Previewable @State var otp = ""
    
    OtpField(otp: $otp)
}
