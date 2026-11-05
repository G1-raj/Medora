export interface User {
    id: string;
    email: string;
    fullName: string;
    password: string;
    role: "USER" | "ADMIN"
    
    createdAt: Date;
    updatedAt: Date;
}