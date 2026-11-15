import { prisma } from "../../config/database.js";
import { Medication } from "../../domain/entities/medication.entity.js";
import { IMedicationRepository, MedicationInput } from "../../domain/interfaces/medication.repository.js";
import { MEDICATION_STATUSES, Status } from "../../domain/types/status.type.js";
import { AppError } from "../../shared/errors/app.error.js";

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

    async updateStatus(userId: number, medicationId: number, status: Status): Promise<Medication> {
        const result =  await prisma.medication.updateMany({
            where: {
                id: medicationId,
                userId,
            },
            data: {
                status
            }
        });

        if (result.count === 0) {
            throw new AppError("Medication not found", 404);
        }

        return prisma.medication.findFirstOrThrow({
            where: {
                id: medicationId,
                userId
            }
        });
    }

    async delete(userId: number, medicationId: number): Promise<boolean> {
        const result = await prisma.medication.deleteMany({
            where: {
                userId,
                id: medicationId
            }
        });

        return result.count > 0;
    }
}
