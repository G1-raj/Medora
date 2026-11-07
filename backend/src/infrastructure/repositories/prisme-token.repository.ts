import { prisma } from "../../config/database.js";
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
} 