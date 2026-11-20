export interface Session {
    id: number;
    userId: number;
    refreshToken: string;
    expiresAt: Date;
    createdAt: Date;
    updatedAt: Date;
}