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

    async findAll(
        userId: number, 
        limit: number,
        cursor?: number,
        status?: Status
    ) {
        const medications = await prisma.medication.findMany({
            where: {
                userId: userId,
                ...(status && { status })
            },
            take: limit + 1,
            ...(cursor && {
                cursor: {
                    id: cursor
                },
                skip: 1
            }),
            orderBy: {
                id: "desc"
            }
        });

        const hasMore = medications.length > limit;

        if(hasMore) {
            medications.pop();
        }

        return {
            medications,
            nextCursor: hasMore
                ? medications[medications.length - 1].id
                : null
        }
    }
}
