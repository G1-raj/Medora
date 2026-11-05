import jwt from "jsonwebtoken"
import { ITokenService } from "../../domain/interfaces/token.services.js"
import { UserRole } from "../../domain/entities/user.entity.js";

export class JwtTokenService implements ITokenService {
  constructor(
    private readonly secret: string,
    private readonly expiresIn: jwt.SignOptions["expiresIn"]
  ) {}

  generateAccessToken(payload: {
    userId: string;
    email: string;
    role: UserRole;
  }): string {
    return jwt.sign(payload, this.secret, {
      expiresIn: this.expiresIn,
      issuer: "my-api",
      audience: "my-app"
    });
  }
}