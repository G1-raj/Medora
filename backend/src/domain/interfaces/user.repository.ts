import { User } from "../entities/user.entity.js";

export interface IUserRepository {
    findByEmail(email: string): Promise<User | null>;

    create(data: {
        email: string,
        fullName: string,
        password: string
    }) : Promise<User>;

    saveOtp(data: {
        userId: number,
        otp: string
    }) : Promise<string>;
}