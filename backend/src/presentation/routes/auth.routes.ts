import { Router } from "express";
import { AuthController } from "../controllers/auth.controller.js";

export function createAuthRoutes(controller: AuthController) {
  const router = Router();

  router.post("/signup", controller.signup);
  router.post("/login", controller.login);

  return router;
}