import { Session } from "../entities/session.entity.js";

export interface ITokenRepository {
    saveToken(data: {
        userId: number;
        refreshToken: string;
    }) : Promise<void>;

    getAllActiveSessions(data: {
        userId: number,
    }) : Promise<Session[]>

    revokeSession(data: {
        sessionId: number;
    }): Promise<void>;

    updateRefreshToken(data: {
        sessionId: number;
        refreshToken: string;
    }): Promise<void>;
}