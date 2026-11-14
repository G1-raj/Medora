import { MedicationService } from "../application/services/medication.service.js";
import { PrismaMedicationRepository } from "../infrastructure/repositories/prisma-medication.repository.js";
import { MedicationController } from "../presentation/controllers/medication.controller.js";

const medicationRepository = new PrismaMedicationRepository();

const medicationService = new MedicationService(
    medicationRepository
);

export const medicationController = new MedicationController(medicationService);