import { IUserRepository } from "../../domain/interfaces/user.repository.js";
import { IPasswordHasher } from "../../domain/interfaces/password.hasher.js";
import { ITokenService } from "../../domain/interfaces/token.services.js";
import { SignupDto } from "../dto/signup.dto.js";
import { LoginDto } from "../dto/login.dto.js";
import { AppError } from "../../shared/errors/app.error.js";
import { SendEmailDto } from "../dto/send-email.dto.js";
import { VerifyOtpDto } from "../dto/verify-otp.dto.js";
import { ChangePasswordDto } from "../dto/change-password.dto.js";
import { generateOtp } from "../../infrastructure/services/otp.service.js";
import { sendEmail } from "../../infrastructure/services/email.service.js";
import { IOtpRepository } from "../../domain/interfaces/otp.repository.js";
import { ITokenRepository } from "../../domain/interfaces/token.repository.js";

export class AuthService {
    constructor(
        private readonly userRepository: IUserRepository,
        private readonly otpRepository: IOtpRepository,
        private readonly tokenRepository: ITokenRepository,
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

        return {
            user: this.toSafeUser(user),
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

        const refreshToken = this.tokenService.generateRefreshTOken({
            userId: user.id,
            email: user.email,
            role: user.role
        });

        const refreshTokenHash = await this.passwordHasher.hash(refreshToken);

        await this.tokenRepository.saveToken({
            userId: user.id,
            refreshToken: refreshTokenHash
        });

        return {
            user: this.toSafeUser(user),
            accessToken,
            refreshToken
        };
    }

    async sendOtp(data: SendEmailDto) {
        const user = await this.userRepository.findByEmail(data.email);

        if (!user) {
            throw new AppError("Invalid email", 401);
        }

        //generate otp
        const otp = generateOtp();
        const hashedOtp = await this.passwordHasher.hash(otp);

        await this.otpRepository.saveOtp({
            userId: user.id,
            otp: hashedOtp
        });

        //send otp through email
        await sendEmail(user.email, otp);

        return "Otp sent successfully"

    }

    async verifyOtp(data: VerifyOtpDto) {
        const user = await this.userRepository.findByEmail(data.email);

        if (!user) {
            throw new AppError("Invalid email", 401);
        }

        const otpRecord = await this.otpRepository.readOtp({userId: user.id});

        if(!otpRecord) {
            throw new AppError("Invalid or Expired Otp", 400);
        }

        const isValidOtp = await this.passwordHasher.compare(data.otp, otpRecord.otpHash);

        if(!isValidOtp) {
            throw new AppError("Invalid Otp", 400);
        }

        const markedUsed = await this.otpRepository.markOtpUsed({otpId: otpRecord.id});

        if (!markedUsed) {
            throw new AppError("OTP already used or expired", 400);
        }

        return "Otp verified successfully";
    }

    async changePassword(data: ChangePasswordDto) {
        const user = await this.userRepository.findByEmail(data.email);

        if (!user) {
            throw new AppError("Invalid email", 401);
        }

        const hashedPassword = await this.passwordHasher.hash(data.password);

        const updatedUser = await this.userRepository.updatePassword({
            email: user.email, 
            password: hashedPassword
        });

        return {
            updatedUser
        }
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