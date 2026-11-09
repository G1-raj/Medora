import { prisma } from "../../config/database.js";
import { IOtpRepository } from "../../domain/interfaces/otp.repository.js";
import { Otp } from "../../domain/entities/otp.entity.js";

export class PrismaOtpRepository implements IOtpRepository {

    async saveOtp(data: {
        userId: number;
        otp: string;
    }): Promise<void> {

        const expiresAt = new Date(
            Date.now() + 15 * 60 * 1000
        );

        await prisma.$transaction([
            prisma.otp.updateMany({
                where: {
                    userId: data.userId,
                    used: false
                },
                data: {
                    used: true
                }
            }),

            prisma.otp.create({
                data: {
                    userId: data.userId,
                    otpHash: data.otp,
                    expiresAt
                }
            })
        ]);
    }

    async readOtp(data: { userId: number; }): Promise<Otp | null> {
        const otpRecord = await prisma.otp.findFirst({
            where: {
                userId: data.userId,
                used: false,
                expiresAt: {
                    gt: new Date()
                }
            },
            orderBy: {
                createdAt: "desc"
            }
        });

        return otpRecord;
    }

    async markOtpUsed(data: { otpId: number; }): Promise<boolean> {

        const result = await prisma.otp.updateMany({
            where: {
                id: data.otpId,
                used: false,
                expiresAt: {
                    gt: new Date()
                }
            },
            data: {
                used: true
            }
        });

        return result.count === 1;
    }
}