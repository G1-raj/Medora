import { prisma } from "../../config/database.js";
import { Session } from "../../domain/entities/session.entity.js";
import { ITokenRepository } from "../../domain/interfaces/token.repository.js";

export class PrismaTokenRepository implements ITokenRepository {
    async saveToken(data: { userId: number; refreshToken: string; }): Promise<void> {
        await prisma.session.create({
            data: {
                refreshToken: data.refreshToken,
                userId: data.userId,
                expiresAt: new Date(Date.now() + 7 * 24 * 60 * 60 * 1000)
            }
        });
    }

    async getAllActiveSessions(data: { userId: number; }): Promise<Session[]> {
        const sessions = await prisma.session.findMany({
            where: {
                userId: data.userId,
                expiresAt: {
                    gt: new Date()
                }
            }
        });

        return sessions;
    }

    async revokeSession(data: { sessionId: number; }): Promise<void> {
        await prisma.session.delete({
            where: {
                id: data.sessionId
            }
        });
    }

    async updateRefreshToken(data: { sessionId: number; refreshToken: string; }): Promise<void> {
        const expiresAt = new Date(
            Date.now() + 7 * 24 * 60 * 60 * 1000
        );

        await prisma.session.update({
            where: {
                id: data.sessionId
            },
            data: {
                refreshToken: data.refreshToken,
                expiresAt
            }
        });
    }
} 