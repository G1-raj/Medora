//
//  AddMedicatonView.swift
//  Medora
//
//  Created by Govine Rajput on 03/11/26.
//

import SwiftUI



//TODO: Update the view for Update Medications


struct AddMedicationView: View {

    @Environment(\.dismiss) var dismiss


    @State var medicationName = ""
    @State var medicationComposition = ""
    @State var medicationPower = ""
    @State var medicationUnit = "mg"

    @State var medicationForm: MedicationForm = .tablet

    @State var medicationDirection = ""
    @State var explainSickness = ""

    @State var startDate: Date? = Date()
    @State var endDate: Date? = nil

    @State var notes = ""


    let units = [
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
}


#Preview {
    AddMedicationView()
}
