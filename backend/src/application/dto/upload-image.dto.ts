import { UploadedFile } from "express-fileupload";

export interface UploadImageDto {
    userId: number;
    file: UploadedFile | UploadedFile[];
}