import { UserRole } from "../types/user-role.type.js";

export type TokenPayload = {
    userId: number;
    email: string;
    role: UserRole;
}

export interface ITokenService {
    generateAccessToken(payload: TokenPayload): string;

    generateRefreshToken(payload: TokenPayload): string;

    verifyRefreshToken(token: string): TokenPayload;
}