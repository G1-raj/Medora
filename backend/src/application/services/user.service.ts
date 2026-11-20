import { UploadedFile } from "express-fileupload";
import { IUserRepository } from "../../domain/interfaces/user.repository.js";
import { IProfilePictureRepository } from "../../domain/interfaces/profile-picture.repository.js";
import { ICloudinaryService } from "../../domain/interfaces/cloudinary.service.js";
import { AppError } from "../../shared/errors/app.error.js";
import { UploadImageDto } from "../dto/upload-image.dto.js";
import { DeleteImageDto } from "../dto/delete-image.dto.js";

export class UserService {
    constructor(
        private readonly userRepository: IUserRepository,
        private readonly profilePictureRepository: IProfilePictureRepository,
        private readonly cloudinaryImageService: ICloudinaryService
    ) {}

    async getMe(userId: number) {
        if (!userId) {
            throw new AppError("Unauthorized", 401);
        }

        const user = await this.userRepository.findById(userId);

        if (!user) {
            throw new AppError("User not found", 404);
        }

        return {
            id: user.id,
            email: user.email,
            fullName: user.fullName,
            role: user.role,
            profilePicture: user.profilePicture ?? null,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt
        };
    }

    async uploadProfilePicture(data: UploadImageDto) {
        if(!data.userId) {
            throw new AppError("Invalid user", 401);
        }

        if(!data.file) {
            throw new AppError("Image is required", 400);
        }

        if(Array.isArray(data.file)) {
            throw new AppError("Only one image is allowed", 400);
        }

        const existingPicture = await this.profilePictureRepository.findByUserId({ userId: data.userId });

        const image = await this.cloudinaryImageService.uploadImage(data.file);

        let profilePicture;

        try {


            if (existingPicture) {
                profilePicture = await this.profilePictureRepository.update({
                    userId: data.userId,
                    imageUrl: image.imageUrl,
                    imageId: image.imageId
                });
            } else {
                profilePicture = await this.profilePictureRepository.create({
                    userId: data.userId,
                    imageUrl: image.imageUrl,
                    imageId: image.imageId
                });
            }

            if (existingPicture) {
                await this.cloudinaryImageService.deleteImage(
                    existingPicture.imageId
                );
            }

            return profilePicture;
            
        } catch (error) {
            throw error;
        }
    }


    async deleteProfilePicture(data: DeleteImageDto) {

        if(!data.userId) {
            throw new AppError("Invalid user", 401);
        }

        //get image from database
        const image = await this.profilePictureRepository.findByUserId({ userId: data.userId });

        if(!image) {
            throw new AppError("Profile picture not found", 404);
        }

        //delete image from database
        await this.profilePictureRepository.delete({
            userId: data.userId,
        });

        //delete image from cloudinary
        await this.cloudinaryImageService.deleteImage(image.imageId);


        return "Profile picture deleted successfully";

    }
}