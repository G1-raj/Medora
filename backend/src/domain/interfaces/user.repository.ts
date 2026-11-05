import { User } from "../../generated/prisma/browser.js";

export interface IUserRepository {
    findByEmail(email: string): Promise<User | null>;

    create(data: {
        email: string,
        fullName: string,
        password: string
    }) : Promise<User>;
}