import { IMedicationRepository } from "../../domain/interfaces/medication.repository.js";
import { MEDICATION_STATUSES, Status } from "../../domain/types/status.type.js";
import { Prisma } from "../../generated/prisma/client.js";
import { AppError } from "../../shared/errors/app.error.js";
import { AddMedicationDto } from "../dto/add-medication.dto.js";
import { GetAllMedicationDto } from "../dto/get-allmedication.dto.js";

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

    async getAllMedications(
        userId: number, 
        query: GetAllMedicationDto
    ) {
        if (!Number.isInteger(userId) || userId <= 0) {
            throw new AppError("Unauthorized", 401);
        }

        const limit = query.limit ?? 10;

        if (!Number.isInteger(limit) || limit <= 0 || limit > 100) {
            throw new AppError("Invalid limit", 400);
        }

        if (
            query.cursor !== undefined &&
            (!Number.isInteger(query.cursor) || query.cursor <= 0)
        ) {
            throw new AppError("Invalid cursor", 400);
        }

        if (
            query.status !== undefined &&
            !MEDICATION_STATUSES.includes(query.status)
        ) {
            throw new AppError("Invalid medication status", 400);
        }

        return await this.medicationRepository.findAll(
            userId,
            limit,
            query.cursor,
            query.status
        );
    }

    async updateStatus(userId: number, medicationId: number, status: Status) {
        if (!Number.isInteger(userId) || userId <= 0) {
            throw new AppError("Unauthorized", 401);
        }

        if (!Number.isInteger(medicationId) || medicationId <= 0) {
            throw new AppError("Invalid medication ID", 400);
        }

        if (!MEDICATION_STATUSES.includes(status)) {
            throw new AppError("Invalid medication status", 400);
        }

        return await this.medicationRepository.updateStatus(
            userId,
            medicationId,
            status
        );
    }

    async deleteMedication(userId: number, medicationId: number) {
        if (!Number.isInteger(userId) || userId <= 0) {
            throw new AppError("Unauthorized", 401);
        }

        if (!Number.isInteger(medicationId) || medicationId <= 0) {
            throw new AppError("Invalid medication ID", 400);
        }

        const deleted = await this.medicationRepository.delete(
            userId,
            medicationId
        );

        if(!deleted) {
            throw new AppError("Medication not found", 404);
        }

        return true;
    }
}