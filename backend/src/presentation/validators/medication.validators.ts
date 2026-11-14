import { z } from "zod";

export const addMedicationSchema = z.object({
    medicineName: z.string().min(1, "Medicine name is required"),

    medicineComposition: z.array(
        z.string().min(1, "Composition cannot be empty")
    ).min(1, "At least one composition is required"),

    strength: z.number().positive("Strength must be greater than zero"),

    strengthUnit: z.enum([
        "MCG",
        "UG",
        "MG",
        "G",
        "ML",
        "MG_ML",
        "MCG_ML",
        "MG_5_ML",
        "PERCENT",
        "IU",
        "MEQ",
        "MMOL",
        "UNITS"
    ]).optional(),

    medicineForm: z.enum([
        "TABLET",
        "CAPSULE",
        "LIQUID",
        "OTHER"
    ]).optional(),

    medicineDirection: z.string().min(1, "Medicine direction is required"),

    reasonForMedication: z.string().nullable().optional(),

    status: z.enum(["ACTIVE", "INACTIVE"]).optional(),

    startDate: z.coerce.date(),

    endDate: z.coerce.date().nullable().optional(),

    notes: z.string().nullable().optional()
}).refine(
    (data) => !data.endDate || data.endDate >= data.startDate,
    {
        message: "End date cannot be earlier than start date",
        path: ["endDate"]
    }
);

export type AddMedicationDto = z.infer<typeof addMedicationSchema>;