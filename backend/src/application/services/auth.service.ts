import { IUserRepository } from "../../domain/interfaces/user.repository.js";
import { IPasswordHasher } from "../../domain/interfaces/password.hasher.js";
import { ITokenService } from "../../domain/interfaces/token.services.js";
import { SignupDto } from "../dto/signup.dto.js";
import { LoginDto } from "../dto/login.dto.js";
import { AppError } from "../../shared/errors/app.error.js";

export class AuthService {
    constructor(
        private readonly userRepository: IUserRepository,
        private readonly passwordHasher: IPasswordHasher,
        private readonly tokenService: ITokenService,
    ) {}

    async signup(data: SignupDto) {
        const existingUser = await this.userRepository.findByEmail(data.email);

        if(existingUser) {
            throw new AppError("User already exists", 409);
        }

        const hashedPassword = await this.passwordHasher.hash(data.password);

        const user = await this.userRepository.create({
            email: data.email,
            fullName: data.fullName,
            password: hashedPassword
        });

        const accessToken = this.tokenService.generateAccessToken({
            userId: user.id,
            email: user.email,
            role: user.role
        });

        return {
            user: this.toSafeUser(user),
            accessToken
        }
    }

    async login(data: LoginDto) {
        const user = await this.userRepository.findByEmail(data.email);

        if (!user) {
            throw new AppError("Invalid email or password", 401);
        }

        const isPasswordValid = await this.passwordHasher.compare(data.password, user.password);

        if (!isPasswordValid) {
            throw new AppError("Invalid email or password", 401);
        }

        const accessToken = this.tokenService.generateAccessToken({
            userId: user.id,
            email: user.email,
            role: user.role
        });

        return {
            user: this.toSafeUser(user),
            accessToken
        };
    }

    private toSafeUser(user: {
        id: number,
        email: string,
        fullName: string,
        role: string,
        createdAt: Date,
        updatedAt: Date,
    }) {
        return {
            id: user.id,
            email: user.email,
            fullName: user.fullName,
            role: user.role,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt
        }
    }
}