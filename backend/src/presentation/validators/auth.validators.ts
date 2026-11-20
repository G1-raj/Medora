import { z } from "zod";

export const signupSchema = z.object({
  fullName: z.string().trim().min(2).max(100),
  email: z.string().trim().email().transform(v => v.toLowerCase()),
  password: z.string().min(12).max(128)
});

export const loginSchema = z.object({
  email: z.string().trim().email().transform(v => v.toLowerCase()),
  password: z.string().min(1).max(128)
});

export const sendOtpSchema = z.object({
  email: z.string().trim().email().transform(v => v.toLowerCase()),
});

export const verifyOtpSchema = z.object({
  email: z.string().trim().email().transform(v => v.toLowerCase()),
  otp: z.string().trim()
});

export const changePasswordSchema = z.object({
  email: z.string().trim().email().transform(v => v.toLowerCase()),
  password: z.string().min(1).max(128)
});

export const refreshTokenSchema = z.object({
    refreshToken: z.string().min(1)
});