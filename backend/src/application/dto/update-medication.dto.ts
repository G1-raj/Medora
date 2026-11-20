import { MedicationForm } from "../../domain/types/medication-form.type.js";
import { StrengthUnit } from "../../domain/types/strength-units.type.js";

export interface UpdateMedicationDto {
    medicineName?: string;
    medicineComposition?: string[];
    strength?: number;
    strengthUnit?: StrengthUnit;
    medicineForm?: MedicationForm;
    medicineDirection?: string;
    reasonForMedication?: string | null;
    startDate?: Date;
    endDate?: Date | null;
    notes?: string | null;
}