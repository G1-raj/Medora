import { UploadedFile } from "express-fileupload";

export interface ICloudinaryService {
    uploadImage(file: UploadedFile): Promise<{
        imageUrl: string;
        imageId: string;
    }>;

    deleteImage(imageId: string): Promise<void>;
}