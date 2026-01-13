const { z } = require("zod");

const usernameRule = z
  .string()
  .trim()
  .min(5, "Username cannot be shorter than 5 characters.")
  .max(12, "Username length cannot exceed 12 characters.");

const emailRule = z.email("Please provide a valid email.");

const registerPasswordRule = z
  .string()
  .trim()
  .min(10, "Password cannot be shorter than 10 characters.")
  .regex(/\d/, "Password must contain at least one number.")
  .regex(
    /[!@#$%^&*(),.?":{}|<>]/,
    "Password must contain at least one special characters."
  );

const loosePasswordRule = z.string().trim().min(1, "Password is required.");
const refreshTokenRule = z.string().trim().min(1, "Refresh token is required.");

module.exports = {
  registerSchema: z.object({
    body: z
      .object({
        username: usernameRule,
        email: emailRule,
        password: registerPasswordRule,
        confirmPassword: loosePasswordRule,
      })
      .refine((data) => data.password === data.confirmPassword, {
        message: "Passwords do not match.",
        path: ["confirmPassword"],
      }),
  }),

  loginSchema: z.object({
    body: z.object({
      email: emailRule,
      password: loosePasswordRule,
    }),
  }),

  refreshTokenSchema: z.object({
    body: z.object({
      refreshToken: refreshTokenRule,
    }),
  }),
};
