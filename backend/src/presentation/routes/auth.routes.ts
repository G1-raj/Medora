import { Router } from "express";
import { AuthController } from "../controllers/auth.controller.js";
import { authRateLimit, loginLimiter, logoutLimiter, sendOtpLimiter, verifyOtpLimiter } from "../middlewares/rate-limit.middleware.js";

export function createAuthRoutes(controller: AuthController) {
  const router = Router();

  router.post("/signup", authRateLimit, controller.signup);
  router.post("/login", loginLimiter,controller.login);
  router.post("/tokens/refresh", authRateLimit, controller.refreshAccessToken);
  router.post("/logout", logoutLimiter, controller.logout);

  
  router.post("/password-reset/otp", sendOtpLimiter, controller.sendOtp);
  router.post("/password-reset/verify", verifyOtpLimiter, controller.verifyOtp);
  router.post("/password-reset/confirm", authRateLimit, controller.changePassword);

  return router;
}