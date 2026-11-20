export const MEDICATION_STATUSES = ["ACTIVE", "INACTIVE"] as const;

export type Status = typeof MEDICATION_STATUSES[number];

// export type Status = "ACTIVE" | "INACTIVE"