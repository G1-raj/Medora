import "dotenv/config";
import app from "./app.js";
import { prisma } from "./config/database.js";

const PORT = Number(process.env.PORT ?? 3000);

async function bootstrap() {
  try {
    if (!process.env.JWT_SECRET || process.env.JWT_SECRET.length < 32) {
      throw new Error("JWT_SECRET must contain at least 32 characters");
    }

    await prisma.$connect();

    const server = app.listen(PORT, () => {
      console.log(`Server running on port ${PORT}`);
    });

    const shutdown = async () => {
      server.close(async () => {
        await prisma.$disconnect();
        process.exit(0);
      });
    };

    process.once("SIGTERM", shutdown);
    process.once("SIGINT", shutdown);
  } catch (error) {
    console.error("Application startup failed:", error);
    await prisma.$disconnect();
    process.exit(1);
  }
}

void bootstrap();