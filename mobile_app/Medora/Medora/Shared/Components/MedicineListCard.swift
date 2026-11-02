//
//  MedicineListCard.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import SwiftUI

struct MedicineListCard: View {
    
    let medicine: DayMedicationModel
    
    var body: some View {
        HStack(spacing: 12) {
            
            // Dose status icon
            Image(systemName: medicine.isDoseTaken
                  ? "checkmark.circle.fill"
                  : "circle")
                .font(.title)
                .foregroundStyle(.themeAccent)
            
            // Medicine details
            VStack(alignment: .leading, spacing: 6) {
                Text(medicine.medicineName)
                    .bold()

                HStack(spacing: 8) {
                    Text(medicine.dosageDescription)

                    if let power = medicine.medicinePower {
                        Circle()
                            .fill(.gray)
                            .frame(width: 5, height: 5)

                        Text("\(power) mg")
                    }
                }
                .font(.caption)
                .foregroundStyle(.gray)
            }
            
            Spacer()
            
            // Medicine timing
            Image(systemName: "clock")
                .font(.caption)
                .foregroundStyle(.gray)

            Text(medicine.medicineTime)
                .font(.caption)
                .foregroundStyle(.gray)

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.gray)
            
            
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        MedicineListCard(
            medicine: DayMedicationModel(
                medicineName: "Metformin",
                noOfMedicines: 1,
                noOfMl: nil,
                medicinePower: 1000,
                medicineType: .tablet,
                medicineTime: "12:00 AM",
                isDoseTaken: false
            )
        )
    }
    .padding(.horizontal, 20)
}
