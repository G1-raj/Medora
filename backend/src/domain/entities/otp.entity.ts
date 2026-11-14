export interface Otp {
    id: number;
    userId: number;
    otpHash: string;
    expiresAt: Date;
    used: boolean;
    createdAt: Date;
    updatedAt: Date;
}