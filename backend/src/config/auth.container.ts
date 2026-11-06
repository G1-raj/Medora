import { AuthService } from "../application/services/auth.service.js";
import { PrismaUserRepository } from "../infrastructure/repositories/prisma-user.repository.js";
import { Argon2PasswordHasher } from "../infrastructure/security/argon2-password-hasher.js";
import { JwtTokenService } from "../infrastructure/security/jwt.token-service.js";
import { AuthController } from "../presentation/controllers/auth.controller.js";

const accessTokenSecret = process.env.JWT_SECRET;
const refreshTokenSecret = process.env.REFRESH_TOKEN_SECRET;


if (!accessTokenSecret || !refreshTokenSecret) {
    throw new Error("JWT secrets are missing from environment variables");
}

const accessTokenExpiry = "15m";
const refreshTokenExpiry = "7d"

const userRepository = new PrismaUserRepository();

const passwordHasher = new Argon2PasswordHasher();

const tokenService = new JwtTokenService(
  accessTokenSecret,
  refreshTokenSecret,
  accessTokenExpiry,
  refreshTokenExpiry
);

const authService = new AuthService(
  userRepository,
  passwordHasher,
  tokenService
);

export const authController = new AuthController(authService);