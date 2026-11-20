import { Router } from "express";
import { UserController } from "../controllers/user.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";
import { deleteProfilePictureLimiter, getMeLimiter, uploadProfilePictureLimiter } from "../middlewares/user.rate-limit.middleware.js";


export function userRoutes(controller: UserController) {

    const router = Router();

    router.get("/", authMiddleware, getMeLimiter, controller.getMe);

    router.post("/profile-picture", authMiddleware, uploadProfilePictureLimiter, controller.uploadImage);
    router.delete("/profile-picture", authMiddleware, deleteProfilePictureLimiter, controller.deleteImage);

    return router;

}