import { Request, Response } from "express";
import { AuthService } from "../../application/services/auth.service.js";
import { AppError } from "../../shared/errors/app.error.js";
import { 
  changePasswordSchema, 
  loginSchema, 
  refreshTokenSchema, 
  sendOtpSchema, 
  signupSchema, 
  verifyOtpSchema 
} from "../validators/auth.validators.js";



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

    res.cookie("refreshToken", result.refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "strict",
        path: "/api/auth",
        maxAge: 7 * 24 * 60 * 60 * 1000
    });

    return res.status(200).json({
      success: true,
      message: "Login successful",
      data: {
        user: result.user,
        accessToken: result.accessToken
      }
    });
  };

  refreshAccessToken = async (req: Request, res: Response) => {
    const refreshToken = req.cookies?.refreshToken;

    if (!refreshToken) {
        throw new AppError("Refresh token is required", 401);
    }

    const result = await this.authService.refreshAccessToken({refreshToken});

    res.cookie("refreshToken", result.refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "strict",
        path: "/api/auth",
        maxAge: 7 * 24 * 60 * 60 * 1000
    });

    return res.status(200).json({
        success: true,
        message: "Access token refreshed successfully",
        data: {
            accessToken: result.accessToken
        }
    });
  }

  sendOtp = async (req: Request, res: Response) => {
    const input = sendOtpSchema.parse(req.body);

    const result = await this.authService.sendOtp(input);

    return res.status(200).json({
      success: true,
      message: result
    });
  }

  verifyOtp = async (req: Request, res: Response) => {
    const input = verifyOtpSchema.parse(req.body);

    const result = await this.authService.verifyOtp(input);

    return res.status(200).json({
      success: true,
      message: result
    });

  }

  changePassword = async (req: Request, res: Response) => {
    const input = changePasswordSchema.parse(req.body);

    const result = await this.authService.changePassword(input);

    res.clearCookie("refreshToken", {
        httpOnly: true,
        secure: process.env.NODE_ENV === "production",
        sameSite: "strict",
        path: "/api/auth",
    });

    return res.status(200).json({
      success: true,
      data: result,
      message: "Password changed successfully"
    });
  }

  logout = async (req: Request, res: Response) => {
    const input = refreshTokenSchema.parse(req.body);

    const result = await this.authService.logOut(input);

    return res.status(200).json({
        success: true,
        message: result
    });
  }

  
}