const { body } = require("express-validator");

const updateUserValidator = [
  body("username")
    .optional()
    .trim()
    .isLength({ max: 12, min: 5 })
    .withMessage("Please check username length."),

  body("email")
    .optional()
    .trim()
    .isEmail()
    .withMessage("Please enter a valid email address.")
    .normalizeEmail(),

  body("password")
    .optional()
    .trim()
    .isLength({ min: 10 })
    .withMessage("Password cannot be shorter than 10 characters.")
    .matches(/\d/)
    .withMessage("Password must contain at least one number.")
    .matches(/[!@#$%^&*(),.?":{}|<>]/)
    .withMessage(
      "Password must contain at least at least one special character."
    ),

  body("confirmPassword")
    .if((value, { req }) => req.body.password)
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

module.exports = { updateUserValidator };
