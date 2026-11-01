//
//  DayMedicationCard.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct DayMedicationCard: View {
    
    @State private var medicineDoses: [DayMedicationModel] = [
        DayMedicationModel(
            medicineName: "Paracetamol",
            noOfMedicines: 1,
            noOfMl: nil,
            medicinePower: 500,
            medicineType: .tablet,
            medicineTime: "09:00 AM",
            isDoseTaken: true
        ),
        DayMedicationModel(
            medicineName: "Vitamin C",
            noOfMedicines: 1,
            noOfMl: nil,
            medicinePower: 1000,
            medicineType: .capsule,
            medicineTime: "01:00 PM",
            isDoseTaken: false
        ),
        DayMedicationModel(
            medicineName: "Cough Syrup",
            noOfMedicines: nil,
            noOfMl: 5,
            medicinePower: nil,
            medicineType: .liquid,
            medicineTime: "08:00 PM",
            isDoseTaken: false
        )
    ]
    
    var body: some View {
        VStack(spacing: 16) {
            ForEach($medicineDoses) { $dose in

                MedicineListCard(
                    medicine: dose
                )

                if dose.id != medicineDoses.last?.id {
                    Divider()
                        .overlay(.gray.opacity(0.15))
                }
            }
        }
        .padding(15)
        .background(.white)
        .clipShape(
            RoundedRectangle(cornerRadius: 18)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 18)
                .stroke(.black.opacity(0.04), lineWidth: 1)
        }
        .shadow(
            color: .black.opacity(0.08),
            radius: 12,
            x: 0,
            y: 4
        )
    }
}

#Preview {
    VStack {
        DayMedicationCard()
    }
    .padding(.horizontal, 20)
    
}
