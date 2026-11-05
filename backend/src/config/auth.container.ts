import { AuthService } from "../application/services/auth.service.js";
import { PrismaUserRepository } from "../infrastructure/repositories/prisma-user.repository.js";
import { Argon2PasswordHasher } from "../infrastructure/security/argon2-password-hasher.js";
import { JwtTokenService } from "../infrastructure/security/jwt.token-service.js";
import { AuthController } from "../presentation/controllers/auth.controller.js";

const userRepository = new PrismaUserRepository();

const passwordHasher = new Argon2PasswordHasher();

const tokenService = new JwtTokenService(
  process.env.JWT_SECRET!,
  "15m"
);

const authService = new AuthService(
  userRepository,
  passwordHasher,
  tokenService
);

export const authController = new AuthController(authService);