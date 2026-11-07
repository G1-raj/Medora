import { UserRole } from "./user.entity.js";
import { ProfilePicture } from "./profile-picture.entity.js";

export interface UserResponse {
    id: number;
    email: string;
    fullName: string;
    role: UserRole;
    profilePicture?: ProfilePicture;

    createdAt: Date;
    updatedAt: Date;
}