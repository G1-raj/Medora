
import { StrengthUnit } from "../types/strength-units.type.js";
import { MedicationForm } from "../types/medication-form.type.js";
import { Prisma } from "../../generated/prisma/client.js";

export interface UpdateMedicationInput {
    medicineName?: string;
    medicineComposition?: string[];
    strength?: Prisma.Decimal;
    strengthUnit?: StrengthUnit;
    medicineForm?: MedicationForm;
    medicineDirection?: string;
    reasonForMedication?: string | null;

    startDate?: Date;
    endDate?: Date | null;

    notes?: string | null;
}