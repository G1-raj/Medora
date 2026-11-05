import { prisma } from "../../config/database.js";
import { IUserRepository } from "../../domain/interfaces/user.repository.js";
import { User } from "../../domain/entities/user.entity.js";

export class PrismaUserRepository implements IUserRepository {

    private toDomain(user: {
        id: number;
        email: string;
        fullName: string;
        password: string;
        role: "USER" | "ADMIN";
        createdAt: Date;
        updatedAt: Date;
    }): User {
        return {
            id: user.id,
            email: user.email,
            fullName: user.fullName,
            password: user.password,
            role: user.role,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt
        };
    }

    async findByEmail(email: string): Promise<User | null> {
        const user =  await prisma.user.findUnique({
            where: {
                email: email
            }
        });

        return user ? this.toDomain(user) : null;
    }

    async create(data: { email: string; fullName: string; password: string; }): Promise<User> {
        const user = await  prisma.user.create({
            data: data
        });

        return this.toDomain(user);
    }
}