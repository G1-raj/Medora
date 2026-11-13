import { Router } from "express";
import { AuthController } from "../controllers/auth.controller.js";
import { authRateLimit, loginLimiter, sendOtpLimiter, verifyOtpLimiter } from "../middlewares/rate-limit.middleware.js";

export function createAuthRoutes(controller: AuthController) {
  const router = Router();

  router.post("/signup", authRateLimit, controller.signup);
  router.post("/login", loginLimiter,controller.login);
  router.post("/refresh", authRateLimit, controller.refreshAccessToken);

  
  router.post("/forgot-password/send-otp", sendOtpLimiter, controller.sendOtp);
  router.post("/forgot-password/verify-otp", verifyOtpLimiter, controller.verifyOtp);
  router.post("/forgot-password/change-password", authRateLimit, controller.changePassword);

  return router;
}