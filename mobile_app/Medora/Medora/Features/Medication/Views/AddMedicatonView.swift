//
//  AddMedicatonView.swift
//  Medora
//
//  Created by Govine Rajput on 03/11/26.
//

import SwiftUI



//TODO: Update the view for Update Medications


struct AddMedicatonView: View {

    @Environment(\.dismiss) private var dismiss


    @State private var medicationName = ""
    @State private var medicationComposition = ""
    @State private var medicationPower = ""
    @State private var medicationUnit = "mg"

    @State private var medicationForm: MedicationForm = .tablet

    @State private var medicationDirection = ""
    @State private var explainSickness = ""

    @State private var startDate: Date? = Date()
    @State private var endDate: Date? = nil

    @State private var notes = ""

    // MARK: - Constants

    private let units = [
        "mcg", "µg", "mg", "g",
        "mL", "mg/mL", "mcg/mL",
        "mg/5 mL", "%", "IU",
        "mEq", "mmol", "Units"
    ]


    var body: some View {
        VStack(spacing: 0) {

            header

            ScrollView {
                VStack(spacing: 22) {

                    imageSection

                    medicationDetailsSection

                    medicationInstructionsSection

                    dateSection

                    notesSection
                }
                .padding(.horizontal, 24)
                .padding(.top, 28)
                .padding(.bottom, 24)
                .background(.white)
                .frame(maxWidth: 500)
                .frame(maxWidth: .infinity)
            }
            .scrollDismissesKeyboard(.interactively)
            .background(Color(.systemGroupedBackground))
        }
        .background(.white)
        .safeAreaInset(edge: .bottom, spacing: 0) {
            bottomAction
        }
        .toolbar(.hidden, for: .navigationBar)
    }


    private var header: some View {
        ZStack {
            Text("Add Medication")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(.black)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.black)
                        .frame(width: 36, height: 36)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)

                Spacer()
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(.white)
    }


    private var imageSection: some View {
        VStack(spacing: 10) {

            Image("capsule_tablet")
                .resizable()
                .scaledToFit()
                .padding(35)
                .frame(width: 120, height: 120)
                .background(Color.red.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 18))

            Text("Add a Photo (Optional)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 4)
    }


    private var medicationDetailsSection: some View {
        VStack(spacing: 18) {

            TextFormField(
                label: "Medication Name",
                hintText: "e.g. Metformin",
                fieldType: .empty,
                text: $medicationName
            )

            TextFormField(
                label: "Medication Composition",
                hintText: "e.g. Paracetamol",
                fieldType: .empty,
                text: $medicationComposition
            )

            strengthField

            medicationFormSelector
        }
    }


    private var strengthField: some View {
        VStack(alignment: .leading, spacing: 6) {

            fieldLabel("Strength")

            StrengthInputField(
                strength: $medicationPower,
                selectedUnit: $medicationUnit,
                hintText: "e.g. 500",
                units: units
            )
        }
    }


    private var medicationFormSelector: some View {
        VStack(alignment: .leading, spacing: 6) {

            fieldLabel("Medication Form")

            MedicationFormSelector(
                selectedForm: $medicationForm
            )
        }
    }


    private var medicationInstructionsSection: some View {
        VStack(spacing: 18) {

            inputField(
                label: "Directions",
                hintText: "e.g. 1 tablet, 2 times daily",
                text: $medicationDirection
            )

            inputField(
                label: "Reason for Medication",
                hintText: "e.g. Fever, cold, diabetes",
                text: $explainSickness
            )
        }
    }


    private var dateSection: some View {
        VStack(spacing: 18) {

            DateInputField(
                title: "Start Date",
                date: $startDate,
                isRequired: true
            )

            DateInputField(
                title: "End Date",
                date: $endDate
            )
        }
    }


    private var notesSection: some View {
        inputField(
            label: "Notes (Optional)",
            hintText: "Add any additional notes",
            text: $notes
        )
    }



    private var bottomAction: some View {
        VStack(spacing: 0) {

            AppButton(label: "Add Medication") {
                addMedication()
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 14)
        .padding(.bottom, 10)
        .frame(maxWidth: .infinity)
        .background(.white)
        .overlay(alignment: .top) {
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(height: 1)
        }
    }


    private func fieldLabel(_ title: String) -> some View {
        Text(title)
            .font(.title3)
            .foregroundStyle(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func inputField(
        label: String,
        hintText: String,
        text: Binding<String>
    ) -> some View {

        VStack(alignment: .leading, spacing: 6) {

            fieldLabel(label)

            ZStack(alignment: .topLeading) {

                if text.wrappedValue.isEmpty {
                    Text(hintText)
                        .foregroundStyle(.gray.opacity(0.7))
                        .padding(.horizontal, 5)
                        .padding(.vertical, 8)
                        .allowsHitTesting(false)
                }

                TextEditor(text: text)
                    .scrollContentBackground(.hidden)
                    .background(.clear)
            }
            .frame(height: 100)
            .padding(8)
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 9))
            .overlay {
                RoundedRectangle(cornerRadius: 9)
                    .stroke(Color.gray.opacity(0.25), lineWidth: 1)
            }
        }
        .frame(maxWidth: .infinity)
    }


    private func addMedication() {

        guard !medicationName.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty else {
            return
        }

        print("Medication Name:", medicationName)
        print("Composition:", medicationComposition)
        print("Strength:", medicationPower)
        print("Unit:", medicationUnit)
        print("Form:", medicationForm)
        print("Directions:", medicationDirection)
        print("Reason:", explainSickness)
        print("Start Date:", String(describing: startDate))
        print("End Date:", String(describing: endDate))
        print("Notes:", notes)

        // Save medication here
    }
}


#Preview {
    AddMedicatonView()
}
