import jwt from "jsonwebtoken"
import { ITokenService } from "../../domain/interfaces/token.services.js"
import { UserRole } from "../../domain/types/user-role.type.js";

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
}