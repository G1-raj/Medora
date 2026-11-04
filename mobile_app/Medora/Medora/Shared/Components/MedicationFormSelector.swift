//
//  MedicationFormSelector.swift
//  Medora
//
//  Created by Govine Rajput on 04/11/26.
//

import SwiftUI


enum MedicationForm: String, CaseIterable, Identifiable {
    case tablet = "Tablet"
    case capsule = "Capsule"
    case liquid = "Liquid"
    case other = "Other"

    var id: String { rawValue }
}

struct MedicationFormSelector: View {

    @Binding var selectedForm: MedicationForm

    private let accentColor = Color(
        red: 0.16,
        green: 0.40,
        blue: 0.31
    )

    private let backgroundColor = Color(
        red: 0.94,
        green: 0.96,
        blue: 0.92
    )

    var body: some View {
        HStack(spacing: 5) {
            ForEach(MedicationForm.allCases) { form in

                Button {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        selectedForm = form
                    }
                } label: {
                    Text(form.rawValue)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(
                            selectedForm == form
                            ? .white
                            : Color.primary
                        )
                        .frame(maxWidth: .infinity)
                        .frame(height: 34)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    selectedForm == form
                                    ? accentColor
                                    : backgroundColor
                                )
                        }
                }
                .buttonStyle(.plain)
            }
        }
    }
}


#Preview {
    @Previewable @State var selected: MedicationForm = .tablet
    
    MedicationFormSelector(
        selectedForm: $selected
    )
}
