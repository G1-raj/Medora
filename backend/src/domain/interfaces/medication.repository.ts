import { Prisma } from "../../generated/prisma/client.js";
import { Medication } from "../entities/medication.entity.js";
import { MedicationForm } from "../types/medication-form.type.js";
import { Status } from "../types/status.type.js";
import { StrengthUnit } from "../types/strength-units.type.js";

export interface MedicationInput {
    userId: number;
    medicineName: string;
    medicineComposition: string[];
    strength: Prisma.Decimal;
    strengthUnit?: StrengthUnit;
    medicineForm?: MedicationForm;
    medicineDirection: string;
    reasonForMedication?: string | null;

    status?: Status;

    startDate: Date;
    endDate?: Date | null;

    notes?: string | null;
}

export interface IMedicationRepository {
    create(data: MedicationInput) : Promise<Medication>;

    findById(id: number, userId: number) : Promise<Medication | null>;

    findAll(userId: number, status?: Status) : Promise<Medication[]>;

}

