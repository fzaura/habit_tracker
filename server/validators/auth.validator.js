const { body } = require("express-validator");

const registerValidator = [
  body("username")
    .trim()
    .notEmpty()
    .withMessage("Username is required.")
    .isLength({ max: 12, min: 5 })
    .withMessage("Username has to be between 5 and 12 characters long.")
    .escape(),

  body("email")
    .trim()
    .notEmpty()
    .withMessage("Email is required.")
    .isEmail()
    .withMessage("Please enter a valid email address.")
    .normalizeEmail()
    .escape(),

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
  body("email").trim().notEmpty().withMessage("Email is required."),

  body("password").trim().notEmpty().withMessage("Password is required."),
];

const updateUserValidator = [
  body("username")
    .optional()
    .trim()
    .notEmpty()
    .withMessage("Username is required.")
    .isLength({ max: 12, min: 5 })
    .withMessage("Username has to be between 5 and 12 characters long.")
    .escape(),

  body("email")
    .optional()
    .trim()
    .notEmpty()
    .withMessage("Email is required.")
    .isEmail()
    .withMessage("Please enter a valid email address.")
    .normalizeEmail()
    .escape(),

  body("password")
    .optional()
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
    .custom((value, { req }) => {
      if (req.body.password) {
        if (!value) {
          throw new Error("Please re-enter your password for confirmation");
        }
        if (value !== req.body.password) {
          throw new Error("Passwords do not match.");
        }
      }

      return true;
    }),
];

module.exports = { registerValidator, loginValidator, updateUserValidator };
