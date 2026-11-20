import { Status } from "../../domain/types/status.type.js";

export interface GetAllMedicationDto {
    limit?: number;
    cursor?: number;
    status?: Status
}
