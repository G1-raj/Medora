import { prisma } from "./database.js";
import { IUserRepository } from "../domain/interfaces/user.repository.js";
import { User } from "../domain/entities/user.entity.js";

export class PrismaUserRepository implements IUserRepository {
    async findByEmail(email: string): Promise<User | null> {
        return prisma.user.findUnique({
            where: {
                email: email
            }
        })
    }

    async create(data: { email: string; fullName: string; password: string; }): Promise<User> {
        return prisma.user.create({
            data: data
        });
    }
}