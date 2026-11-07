import argon2 from "argon2";
import { IPasswordHasher } from "../../domain/interfaces/password.hasher.js";

export class Argon2PasswordHasher implements IPasswordHasher {
    async hash(password: string): Promise<string> {
        return argon2.hash(password, {
            type: argon2.argon2id
        })
    }

    async compare(password: string, hashedPassword: string): Promise<boolean> {
        return argon2.verify(hashedPassword, password);
    }
}