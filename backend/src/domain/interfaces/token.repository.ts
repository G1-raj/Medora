import { Session } from "../entities/session.entity.js";

export interface ITokenRepository {
    saveToken(data: {
        userId: number;
        refreshToken: string;
    }) : Promise<void>;

    getAllActiveSessions(data: {
        userId: number,
    }) : Promise<Session[]>
}