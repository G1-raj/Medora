import { UserRole } from "../entities/user.entity.js";

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