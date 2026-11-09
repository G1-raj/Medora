import { Otp } from "../entities/otp.entity.js";

export interface IOtpRepository {
    saveOtp(data: {
        userId: number,
        otp: string
    }) : Promise<void>;

    readOtp(data: {
        userId: number
    }) : Promise<Otp | null>;

    markOtpUsed(data: {
        otpId: number
    }) : Promise<boolean>;
}