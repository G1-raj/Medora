import { UserService } from "../application/services/user.service.js";

import { PrismaUserRepository } from "../infrastructure/repositories/prisma-user.repository.js";
import { PrismaProfilePictureRepository } from "../infrastructure/repositories/prisma-profile-picture.repository.js";

import { CloudinaryImageService } from "../infrastructure/services/cloudinary-image.service.js";

import { UserController } from "../presentation/controllers/user.controller.js";

const userRepository = new PrismaUserRepository();

const profilePictureRepository = new PrismaProfilePictureRepository();

const cloudinaryImageService = new CloudinaryImageService();

const userService = new UserService(
    userRepository,
    profilePictureRepository,
    cloudinaryImageService
);

export const userController = new UserController(userService);