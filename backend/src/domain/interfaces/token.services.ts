import { UserRole } from "../entities/user.entity.js";

export interface ITokenService {
    generateAccessToken(payload: {
        userId: string,
        email: string,
        role: UserRole
    }): string;
}