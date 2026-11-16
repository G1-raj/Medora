import { DoseStatus } from "../types/dose-status.type.js";

export interface MedicationDose {
  id: number;
  scheduleId: number;

  scheduledAt: Date;
  takenAt: Date | null;

  status: DoseStatus;
  doseQuantity: number;

  notes: string | null;

  createdAt: Date;
  updatedAt: Date;
}