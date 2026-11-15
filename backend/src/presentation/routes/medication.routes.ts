import { Router } from "express";
import { MedicationController } from "../controllers/medication.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";
import { addMedicationLimiter, getMedicationLimiter, updateStatusLimiter } from "../middlewares/medication.rate-limit.middleware.js";

export function medicationRoutes(controller: MedicationController) {
    const router = Router();

    router.use(authMiddleware);

    router.post("/", addMedicationLimiter, controller.addMedication);

    router.get("/:id", getMedicationLimiter, controller.getMedication);
    router.get("/", getMedicationLimiter, controller.getAllMedication);

    router.patch("/:id/status", updateStatusLimiter, controller.updateMedicationStatus);

    return router
}