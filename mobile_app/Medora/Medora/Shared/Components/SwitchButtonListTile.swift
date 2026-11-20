//
//  SwitchButtonListTile.swift
//  Medora
//
//  Created by Govine Rajput on 02/11/26.
//

import SwiftUI

struct SwitchButtonListTile: View {

    let label: String
    let subLabel: String
    let icon: String
    let iconColor: Color

    @Binding var isEnabled: Bool
    var onToggle: () -> Void = {}

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(iconColor)
                .frame(width: 40, height: 40)
                .background(iconColor.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 12))

            VStack(alignment: .leading, spacing: 4) {
                Text(label)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(.primary)

                Text(subLabel)
                    .font(.system(size: 11))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 4)

            Toggle("", isOn: $isEnabled)
                .labelsHidden()
                .tint(.themeAccent)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 14)
        .contentShape(Rectangle())
        .onTapGesture {
            onToggle()
        }
    }
}

#Preview {
    
    @Previewable @State var isEnabled = false
    
    SwitchButtonListTile(
        label: "Pharmacy",
        subLabel: "Preferred pharmacy & contact",
        icon: "pills.fill",
        iconColor: .themeAccent,
        isEnabled: $isEnabled
    ) {
        isEnabled.toggle()
    }
    .padding(.horizontal, 24)
}
