import jwt from "jsonwebtoken"
import { ITokenService, TokenPayload } from "../../domain/interfaces/token.services.js"
import { UserRole } from "../../domain/types/user-role.type.js";
import { AppError } from "../../shared/errors/app.error.js";

type TokenType = "ACCESS" | "REFRESH";

export class JwtTokenService implements ITokenService {
  constructor(
    private readonly accessTokenSecret: string,
    private readonly refreshTokenSecret: string,
    private readonly expiresInA: jwt.SignOptions["expiresIn"],
    private readonly expiresInR: jwt.SignOptions["expiresIn"]
  ) {}

  generateAccessToken(payload: TokenPayload): string {
    return jwt.sign({...payload, tokenType: "ACCESS" as TokenType }, 
      this.accessTokenSecret, {
      expiresIn: this.expiresInA,
      issuer: "my-api",
      audience: "my-app",
      algorithm: "HS256"
    });
  }

  generateRefreshToken(payload: TokenPayload): string {
      return jwt.sign({...payload, tokenType: "REFRESH" as TokenType }, 
        this.refreshTokenSecret, {
        expiresIn: this.expiresInR,
        issuer: "my-api",
        audience: "my-app",
        algorithm: "HS256"
      });
  }

  verifyRefreshToken(token: string): TokenPayload {
      try {
        const decoded = jwt.verify(
            token,
            this.refreshTokenSecret,
            {
                issuer: "my-api",
                audience: "my-app",
                algorithms: ["HS256"]
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