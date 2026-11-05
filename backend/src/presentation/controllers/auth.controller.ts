import { Request, Response } from "express";
import { z } from "zod";
import { AuthService } from "../../application/services/auth.service.js";

const signupSchema = z.object({
  fullName: z.string().trim().min(2).max(100),
  email: z.string().trim().email().transform(v => v.toLowerCase()),
  password: z.string().min(12).max(128)
});

const loginSchema = z.object({
  email: z.string().trim().email().transform(v => v.toLowerCase()),
  password: z.string().min(1).max(128)
});

export class AuthController {
  constructor(private readonly authService: AuthService) {}

  signup = async (req: Request, res: Response) => {
    const input = signupSchema.parse(req.body);

    const result = await this.authService.signup(input);

    return res.status(201).json({
      success: true,
      message: "Account created successfully",
      data: result
    });
  };

  login = async (req: Request, res: Response) => {
    const input = loginSchema.parse(req.body);

    const result = await this.authService.login(input);

    return res.status(200).json({
      success: true,
      message: "Login successful",
      data: result
    });
  };
}