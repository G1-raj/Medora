import { UpdatePassword } from "../entities/update-password.entity.js";
import { User } from "../entities/user.entity.js";

export interface IUserRepository {
    findByEmail(email: string): Promise<User | null>;

    create(data: {
        email: string,
        fullName: string,
        password: string
    }) : Promise<User>;

    updatePassword(data: {
        email: string,
        password: string
    }) : Promise<UpdatePassword>
}