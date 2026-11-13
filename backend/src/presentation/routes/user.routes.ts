import { Router } from "express";
import { UserController } from "../controllers/user.controller.js";
import authMiddleware from "../middlewares/auth.middleware.js";


export function createUserRoutes(controller: UserController) {

    const router = Router();

    router.get("/", authMiddleware, controller.getMe);

    router.post("/profile-picture", authMiddleware, controller.uploadImage);
    router.delete("/profile-picture", authMiddleware, controller.deleteImage);

    return router;

}