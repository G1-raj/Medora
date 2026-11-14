import { rateLimit } from "express-rate-limit";

export const addMedicationLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    limit: 60,
    standardHeaders: "draft-8",
    legacyHeaders: false,
    message: {
        success: false,
        message: "Too many requests. Please try again later.",
    }
});

export const getMedicationLimiter = rateLimit({
    windowMs: 15 * 60 * 1000,
    limit: 60,

    standardHeaders: "draft-8",
    legacyHeaders: false,

    keyGenerator: (req) => {
        return req.user?.id
            ? `user:${req.user.id}`
            : `ip:${req.ip}`;
    },

    message: {
        success: false,
        message: "Too many requests. Please try again later."
    }
});