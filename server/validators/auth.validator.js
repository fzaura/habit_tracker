/**
 * @module validators/auth
 * @description Express-validator middleware chains for authentication endpoints.
 * Provides validation for registration, login, user updates, and token refresh.
 */
const { body } = require("express-validator");

/**
 * Validation chain for user registration.
 * Validates username (5-12 chars), email format, password strength, and password confirmation.
 *
 * @memberof module:validators/auth
 * @constant {Array} registerValidator
 * @type {Array}
 */
const registerValidator = [
  body("username")
    .trim()
    .notEmpty()
    .withMessage("Username is required.")
    .isLength({ max: 12, min: 5 })
    .withMessage("Username has to be between 5 and 12 characters long."),
  body("email")
    .trim()
    .notEmpty()
    .withMessage("Email is required.")
    .isEmail()
    .withMessage("Please enter a valid email address.")
    .normalizeEmail(),
  body("password")
    .trim()
    .notEmpty()
    .withMessage("Password is required.")
    .isLength({ min: 10 })
    .withMessage("Password cannot be shorter than 10 characters.")
    .matches(/\d/)
    .withMessage("Password must contain at least one number.")
    .matches(/[!@#$%^&*(),.?":{}|<>]/)
    .withMessage(
      "Password must contain at least at least one special character."
    ),

  body("confirmPassword")
    .trim()
    .notEmpty()
    .withMessage("Please re-enter your password for confirmation.")
    .custom((value, { req }) => {
      if (value !== req.body.password) {
        throw new Error("Passwords do not match.");
      }

      return true;
    }),
];

const loginValidator = [
  body("email")
    .trim()
    .notEmpty()
    .withMessage("Email is required.")
    .normalizeEmail(),

  body("password").trim().notEmpty().withMessage("Password is required."),
];

const refreshTokenValidator = [
  body("refreshToken")
    .trim()
    .notEmpty()
    .withMessage("Refresh token is required."),
];

module.exports = {
  registerValidator,
  loginValidator,
  refreshTokenValidator,
};
