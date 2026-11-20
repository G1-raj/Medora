import { ScheduleFrequency } from "../types/schedule-frequency.type.js";

export interface DoseSchedule {
  id: number;
  medicationId: number;

  frequency: ScheduleFrequency;
  times: string[];
  weekDays: number[];

  intervalHours: number | null;

  doseQuantity: number;

  startDate: Date;
  endDate: Date | null;

  isActive: boolean;

  createdAt: Date;
  updatedAt: Date;
}