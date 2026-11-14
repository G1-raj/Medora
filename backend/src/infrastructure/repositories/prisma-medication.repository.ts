import { prisma } from "../../config/database.js";
import { Medication } from "../../domain/entities/medication.entity.js";
import { IMedicationRepository, MedicationInput } from "../../domain/interfaces/medication.repository.js";
import { Status } from "../../domain/types/status.type.js";

export class PrismaMedicationRepository implements IMedicationRepository {
    async create(data: MedicationInput): Promise<Medication> {
        const med = await prisma.medication.create({
            data: {
                ...data
            }
        });

        return med;
    }

    async findById(id: number, userId: number): Promise<Medication | null> {
        const med = await prisma.medication.findFirst({
            where: {
                userId: userId,
                id: id
            }
        });

        return med;
    }

    async findAll(userId: number, status?: Status): Promise<Medication[]> {
        const allMed = await prisma.medication.findMany({
            where: {
                userId: userId,
                ...(status && { status })
            },
            orderBy: {
                createdAt: "desc"
            }
        });

        return allMed;
    }
}
