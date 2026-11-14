import { Request, Response } from "express";
import { MedicationService } from "../../application/services/medication.service.js";
import { AppError } from "../../shared/errors/app.error.js";
import { addMedicationSchema } from "../validators/medication.validators.js";


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

}