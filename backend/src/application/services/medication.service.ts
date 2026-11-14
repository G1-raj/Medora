import { IMedicationRepository } from "../../domain/interfaces/medication.repository.js";
import { MEDICATION_STATUSES, Status } from "../../domain/types/status.type.js";
import { Prisma } from "../../generated/prisma/client.js";
import { AppError } from "../../shared/errors/app.error.js";
import { AddMedicationDto } from "../dto/add-medication.dto.js";

export class MedicationService {
    constructor(
        private readonly medicationRepository: IMedicationRepository
    ) {}

    async addMedication(data: AddMedicationDto, userId: number) {

        if (!Number.isInteger(userId) || userId <= 0) {
            throw new AppError("Unauthorized", 401);
        }

        if (
            data.endDate &&
            data.endDate < data.startDate
        ) {
            throw new AppError(
                "End date cannot be earlier than start date",
                400
            );
        }

        const medication = await this.medicationRepository.create({ 
            userId,
            medicineName: data.medicineName,
            medicineComposition: data.medicineComposition,
            strength: new Prisma.Decimal(data.strength),
            strengthUnit: data.strengthUnit,
            medicineForm: data.medicineForm,
            medicineDirection: data.medicineDirection,
            reasonForMedication: data.reasonForMedication,
            status: data.status,
            startDate: data.startDate,
            endDate: data.endDate,
            notes: data.notes
        });

        return medication;
    }

    async getMedication(id: number, userId: number) {

        if (!Number.isInteger(userId) || userId <= 0) {
            throw new AppError("Unauthorized", 401);
        }

        if (!Number.isInteger(id) || id <= 0) {
            throw new AppError("Invalid medication", 400);
        }

        const medication = await this.medicationRepository.findById(id, userId);

        if (!medication) {
            throw new AppError("Medication not found", 404);
        }

        return medication;

    }

    async getAllMedications(userId: number, status?: Status) {
        if (!Number.isInteger(userId) || userId <= 0) {
            throw new AppError("Unauthorized", 401);
        }

        if (
            status !== undefined &&
            !MEDICATION_STATUSES.includes(status)
        ) {
            throw new AppError("Invalid medication status", 400);
        }

        const getAllMedications = await this.medicationRepository.findAll(userId, status);

        return getAllMedications;
    }
}