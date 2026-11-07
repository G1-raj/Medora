import { UserRole } from "../types/user-role.type.js";

export interface ITokenService {
    generateAccessToken(payload: {
        userId: number,
        email: string,
        role: UserRole
    }): string;

    generateRefreshTOken(payload: {
        userId: number,
        email: string,
        role: UserRole
    }): string;
}