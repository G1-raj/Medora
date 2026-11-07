import { Otp } from "../entities/otp.entity.js";

export interface IOtpRepository {
    saveOtp(data: {
        userId: number,
        otp: string
    }) : Promise<string>;

    readOtp(data: {
        userId: number
    }) : Promise<Otp | null>;

    markOtpUsed(data: {
        otpId: number
    }) : Promise<string>;
}