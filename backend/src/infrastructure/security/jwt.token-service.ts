import jwt from "jsonwebtoken"
import { ITokenService } from "../../domain/interfaces/token.services.js"
import { UserRole } from "../../domain/types/user-role.type.js";
import { AppError } from "../../shared/errors/app.error.js";

export class JwtTokenService implements ITokenService {
  constructor(
    private readonly accessTokenSecret: string,
    private readonly refreshTokenSecret: string,
    private readonly expiresInA: jwt.SignOptions["expiresIn"],
    private readonly expiresInR: jwt.SignOptions["expiresIn"]
  ) {}

  generateAccessToken(payload: {
    userId: number;
    email: string;
    role: UserRole;
  }): string {
    return jwt.sign(payload, this.accessTokenSecret, {
      expiresIn: this.expiresInA,
      issuer: "my-api",
      audience: "my-app"
    });
  }

  generateRefreshTOken(payload: { 
    userId: number; 
    email: string; 
    role: UserRole; 
  }): string {
      return jwt.sign(payload, this.refreshTokenSecret, {
        expiresIn: this.expiresInR,
        issuer: "my-api",
        audience: "my-app"
      });
  }

  verifyRefreshToken(token: string): { userId: number; email: string; role: UserRole; } {
      try {
        const decoded = jwt.verify(
            token,
            this.refreshTokenSecret,
            {
                issuer: "my-api",
                audience: "my-app"
            }
        );

        if (
            typeof decoded === "string" ||
            typeof decoded.userId !== "number" ||
            typeof decoded.email !== "string" ||
            !["USER", "ADMIN"].includes(decoded.role as string)
        ) {
            throw new AppError("Invalid refresh token", 401);
        }

        return {
            userId: decoded.userId,
            email: decoded.email,
            role: decoded.role as UserRole
        };

    } catch (error) {
        if (error instanceof AppError) {
            throw error;
        }

        throw new AppError("Invalid or expired refresh token", 401);
    }
  }
}