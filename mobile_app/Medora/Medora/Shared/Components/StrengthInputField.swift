//
//  StrengthInputField.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//

import SwiftUI


struct StrengthInputField: View {

    @Binding var strength: String
    @Binding var selectedUnit: String

    var hintText: String
    var units: [String]

    var body: some View {
        HStack(spacing: 0) {

            // Strength input
            TextField(hintText, text: $strength)
                .keyboardType(.decimalPad)
                .padding(.horizontal, 14)
                .frame(maxWidth: .infinity)
                .frame(height: 48)

            // Divider
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(width: 1, height: 32)

            // Unit selector
            Menu {
                ForEach(units, id: \.self) { unit in
                    Button {
                        selectedUnit = unit
                    } label: {
                        if selectedUnit == unit {
                            Label(unit, systemImage: "checkmark")
                        } else {
                            Text(unit)
                        }
                    }
                }
            } label: {
                HStack(spacing: 12) {
                    Text(selectedUnit)
                        .foregroundStyle(.primary)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundStyle(.secondary)
                }
                .padding(.horizontal, 14)
                .frame(height: 48)
                .contentShape(Rectangle())
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 9))
        .overlay {
            RoundedRectangle(cornerRadius: 9)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        }
    }
}



#Preview {
    
    @Previewable @State var strength = ""
    @Previewable @State var unit = ""
    
    StrengthInputField(
        strength: $strength,
        selectedUnit: $unit,
        
        hintText: "Medication",
        units: ["MG", "ML"]
    )
}
