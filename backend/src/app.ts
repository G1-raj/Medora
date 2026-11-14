import express from "express";
import { authController } from "./config/auth.container.js";
import { createAuthRoutes } from "./presentation/routes/auth.routes.js";
import { errorHandler } from "./presentation/middlewares/error.middleware.js";
import { userRoutes } from "./presentation/routes/user.routes.js";
import { userController } from "./config/user.container.js";
import { cloudinaryConnect } from "./config/cloudinary.js";
import fileUpload from "express-fileupload";
import cookieParser from "cookie-parser";
import { medicationRoutes } from "./presentation/routes/medication.routes.js";
import { medicationController } from "./config/medication.container.js";

cloudinaryConnect();

const app = express();

app.use(express.json({ limit: "10kb" }));

app.get("/health", (req, res) => {
  res.json({
    success: true,
    message: "API is running"
  });
});

app.use(fileUpload({
  useTempFiles: true,
  tempFileDir: "/tmp/",
}));
app.use(cookieParser());
app.use("/api/v1/auth", createAuthRoutes(authController));
app.use("/api/v1/me", userRoutes(userController));
app.use("/api/v1/medications", medicationRoutes(medicationController));

app.use(errorHandler);

export default app;