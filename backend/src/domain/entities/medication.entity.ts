import { Prisma } from "../../generated/prisma/client.js";
import { MedicationForm } from "../types/medication-form.type.js";
import { Status } from "../types/status.type.js";
import { StrengthUnit } from "../types/strength-units.type.js";

export interface Medication {
    id: number;
    userId: number;

    medicineName: string;
    medicineComposition: string[];
    strength: Prisma.Decimal;
    strengthUnit: StrengthUnit;
    medicineForm: MedicationForm;
    medicineDirection: string;
    reasonForMedication: string | null;

    status: Status;

    startDate: Date;
    endDate: Date | null;

    notes: string | null;

    createdAt: Date;
    updatedAt: Date

}
