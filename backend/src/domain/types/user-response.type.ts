import { UserRole } from "./user-role.type.js";
import { ProfilePicture } from "../entities/profile-picture.entity.js";

export interface UserResponse {
    id: number;
    email: string;
    fullName: string;
    role: UserRole;
    profilePicture?: ProfilePicture;

    createdAt: Date;
    updatedAt: Date;
}