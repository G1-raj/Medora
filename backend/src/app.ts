import express from "express";
import { authController } from "./config/auth.container.js";
import { createAuthRoutes } from "./presentation/routes/auth.routes.js";
import { errorHandler } from "./presentation/middlewares/error.middleware.js";

const app = express();

app.use(express.json({ limit: "10kb" }));

app.get("/health", (req, res) => {
  res.json({
    success: true,
    message: "API is running"
  });
});

app.use("/api/v1/auth", createAuthRoutes(authController));

app.use(errorHandler);

export default app;