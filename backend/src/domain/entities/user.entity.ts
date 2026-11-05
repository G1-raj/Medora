export interface User {
    id: number;
    email: string;
    fullName: string;
    password: string;
    role: "USER" | "ADMIN"
    
    createdAt: Date;
    updatedAt: Date;
}