import { prisma } from "../../config/database.js";
import { Medication } from "../../domain/entities/medication.entity.js";
import { IMedicationRepository, MedicationInput } from "../../domain/interfaces/medication.repository.js";

export class PrismaMedicationRepository implements IMedicationRepository {
    async create(data: MedicationInput): Promise<Medication> {
        const med = await prisma.medication.create({
            data: {
                ...data
            }
        });

        return med;
    }
}
