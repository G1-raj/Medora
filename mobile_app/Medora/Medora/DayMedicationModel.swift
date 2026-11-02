//
//  DayMedicationModel.swift
//  Medora
//
//  Created by Govine Rajput on 01/11/26.
//

import Foundation

enum MedicineType {
    case tablet
    case capsule
    case tube
    case liquid
}

struct DayMedicationModel: Identifiable {
    let id = UUID()
    
    let medicineName: String
    let noOfMedicines: Int?
    let noOfMl: Int?
    let medicinePower: Int?
    let medicineType: MedicineType
    let medicineTime: String
    let isDoseTaken: Bool
}


extension DayMedicationModel {
    var dosageDescription: String {
        switch medicineType {
        case .tablet:
            return "\(noOfMedicines ?? 0) tablet"

        case .capsule:
            return "\(noOfMedicines ?? 0) capsule"

        case .tube:
            return "\(noOfMedicines ?? 0) tube"

        case .liquid:
            return "\(noOfMl ?? 0) ml"
        }
    }
}
