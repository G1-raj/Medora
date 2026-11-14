import { IMedicationRepository } from "../../domain/interfaces/medication.repository.js";
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
}