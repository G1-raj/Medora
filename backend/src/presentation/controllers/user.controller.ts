import { Request, Response } from "express";
import { AppError } from "../../shared/errors/app.error.js";
import { UserService } from "../../application/services/user.service.js";


export class UserController {

    constructor(
        private readonly userService: UserService
    ) {}

    uploadImage = async (req: Request, res: Response) => {

        const userId = req.user?.id;

        if (!userId) {
            throw new AppError("Unauthorized", 401);
        }

        const file = req.files?.picture;

        if (!file) {
            throw new AppError("Image is required", 400);
        }


        const result = await this.userService.uploadProfilePicture({
            userId,
            file
        });

        return res.status(200).json({
            success: true,
            message: "Profile picture uploaded successfully",
            data: result
        });

    }

    deleteImage = async (req: Request, res: Response) => {

        const userId = req.user?.id;

        if (!userId) {
            throw new AppError("Unauthorized", 401);
        }

        const result = await this.userService.deleteProfilePicture({ userId });

        return res.status(200).json({
            success: true,
            message: result
        });
    }

}