import { Request, Response } from "express";
import { MedicationService } from "../../application/services/medication.service.js";
import { AppError } from "../../shared/errors/app.error.js";
import { addMedicationSchema } from "../validators/medication.validators.js";
import { Status } from "../../domain/types/status.type.js";


export class MedicationController {

    constructor(
        private readonly medicationService: MedicationService
    ) {}

    addMedication = async (req: Request, res: Response) => {
        const userId = req.user?.id;

        if (!userId) {
            throw new AppError("Unauthorized", 401);
        }

        const input = addMedicationSchema.parse(req.body);

        const result = await this.medicationService.addMedication(
            input,
            userId
        );

        return res.status(201).json({
            success: true,
            message: "Medication added successfully",
            data: result
        });
    }

    getMedication = async (req: Request, res: Response) => {
        const userId = req.user?.id;


        if (!userId) {
            throw new AppError("Unauthorized", 401);
        }

        const medicationId = Number(req.params.id);

        if (!Number.isInteger(medicationId) || medicationId <= 0) {
            throw new AppError("Invalid medication id", 400);
        }

        const result = await this.medicationService.getMedication(medicationId, userId);

        return res.status(200).json({
            success: true,
            message: "Medication fetched successfully",
            data: result
        });
    }

    getAllMedication = async (req: Request, res: Response) => {
        const userId = req.user?.id;

        if (!userId) {
            throw new AppError("Unauthorized", 401);
        }

        const status = req.query.status;

        if (status !== undefined && typeof status !== "string") {
            throw new AppError("Invalid medication status", 400);
        }

        const result = await this.medicationService.getAllMedications(
            userId,
            status as Status | undefined
        );

        return res.status(200).json({
            success: true,
            message: "All medication fetched successfully",
            data: result
        });
    }

}