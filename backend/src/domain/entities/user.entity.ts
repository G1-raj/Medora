import { ProfilePicture } from "./profile-picture.entity.js";
import { Session } from "./session.entity.js";
import { Otp } from "./otp.entity.js";
import { UserRole } from "../types/user-role.type.js";



export interface User {
    id: number;
    email: string;
    fullName: string;
    password: string;
    role: UserRole;

    profilePicture?: ProfilePicture;
    session?: Session[];
    otp?: Otp[];

    createdAt: Date;
    updatedAt: Date
}





