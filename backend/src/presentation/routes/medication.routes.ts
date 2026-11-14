import { Router } from "express";
import { MedicationController } from "../controllers/medication.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";
import { addMedicationLimiter } from "../middlewares/medication.rate-limit.middleware.js";

export function medicationRoutes(controller: MedicationController) {
    const router = Router();

    router.post("/", authMiddleware, addMedicationLimiter, controller.addMedication);

    return router
}