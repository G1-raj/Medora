import { prisma } from "../../config/database.js";
import { ProfilePicture } from "../../domain/entities/profile-picture.entity.js";
import { IProfilePictureRepository } from "../../domain/interfaces/profile-picture.repository.js";

export class PrismaProfilePictureRepository implements IProfilePictureRepository {
    async findByUserId(data: { userId: number; }): Promise<ProfilePicture | null> {
        const profilePicture = await prisma.profilePicture.findUnique({
            where: {
                userId: data.userId
            }
        });

        return profilePicture;
    }

    async create(data: { userId: number; imageUrl: string; imageId: string; }): Promise<ProfilePicture> {
        const newProfilePicture = await prisma.profilePicture.create({
            data: {
                userId: data.userId,
                imageUrl: data.imageUrl,
                imageId: data.imageId
            }
        });

        return newProfilePicture;
    }

    async update(data: { userId: number; imageUrl: string; imageId: string; }): Promise<ProfilePicture> {
        const updatedProfilePicture = await prisma.profilePicture.update({
            where: {
                userId: data.userId
            },
            data: {
                imageUrl: data.imageUrl,
                imageId: data.imageId
            }
        });

        return updatedProfilePicture;
    }

    async delete(data: { userId: number; }): Promise<void> {
        await prisma.profilePicture.delete({
            where: {
                userId: data.userId
            }
        });
    }
}