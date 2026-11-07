import { Router } from "express";
import { AuthController } from "../controllers/auth.controller.js";

export function createAuthRoutes(controller: AuthController) {
  const router = Router();

  router.post("/signup", controller.signup);
  router.post("/login", controller.login);
  router.post("/forgot-password/send-otp", controller.sendOtp);
  router.post("/forgot-password/verify-otp", controller.verifyOtp);
  router.post("/forgot-password/change-password", controller.changePassword);

  return router;
}