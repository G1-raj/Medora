import { MedicationForm } from "../../domain/types/medication-form.type.js";
import { Status } from "../../domain/types/status.type.js";
import { StrengthUnit } from "../../domain/types/strength-units.type.js";


export interface AddMedicationDto {
    medicineName: string;
    medicineComposition: string[];
    strength: number;
    strengthUnit?: StrengthUnit;
    medicineForm?: MedicationForm;
    medicineDirection: string;
    reasonForMedication?: string | null;

    status?: Status;

    startDate: Date;
    endDate?: Date | null;

    notes?: string | null;
}