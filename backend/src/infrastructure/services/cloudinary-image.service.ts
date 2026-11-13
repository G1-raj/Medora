import { v2 as cloudinary } from "cloudinary";
import { UploadedFile } from "express-fileupload";
import { ICloudinaryService } from "../../domain/interfaces/cloudinary.service.js";
import { AppError } from "../../shared/errors/app.error.js";

const fileSupportedType = (
    type: String, 
    supportedType: String[]
) : Boolean => {
    return supportedType.includes(type);
}

export class CloudinaryImageService implements ICloudinaryService {
    async uploadImage(file: UploadedFile): Promise<{ imageUrl: string; imageId: string; }> {
        try {

            const supportedTypes: String[] = ["jpg", "jpeg", "png"];
            const fileType = file.name.split(".").pop()?.toLowerCase();

            if(!fileType || !fileSupportedType(fileType, supportedTypes)) {
                throw new Error("File type not supported");
            }

            const options = {
                folder: "threesocials"
            };

            const response = await cloudinary.uploader.upload(
                file.tempFilePath,
                options
            );

            return {
                imageUrl: response.secure_url,
                imageId: response.public_id
            }
            
        } catch (error) {
            throw new AppError("Failed to upload profile picture", 500);
        }
    }

    async deleteImage(imageId: string): Promise<void> {
        const result = await cloudinary.uploader.destroy(imageId, {
            invalidate: true
        });

        if(result.result != "ok") {
            throw new Error(`Failed to delete image: ${result.result}`);
        }
    }
}