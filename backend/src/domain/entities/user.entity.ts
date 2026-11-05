export type UserRole = "USER" | "ADMIN";

export interface User {
    id: number;
    email: string;
    fullName: string;
    password: string;
    role: UserRole;
    createdAt: Date;
    updatedAt: Date;
}