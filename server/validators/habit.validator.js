const { body } = require("express-validator");

const addHabitValidator = [
  body("name")
    .trim()
    .notEmpty()
    .withMessage("Habit name is required.")
    .isLength({ max: 100 })
    .withMessage("Habit name cannot exceed 100 characters.")
    .escape(),

  body("goal")
    .trim()
    .notEmpty()
    .withMessage("Habit goal cannot be empty.")
    .isLength({ max: 100 })
    .withMessage("Habit goal cannot exceed 100 characters")
    .escape(),

  body("completionStatus")
    .isBoolean()
    .withMessage("Completion status must be a boolean (true or false)"),

  body("frequency.type")
    .isIn(["daily", "weekly", "specific_days"])
    .withMessage("Frequency must be one of: daily, weekly, or specific_days"),

  body("frequency.times")
    .optional()
    .isInt({ min: 1, max: 7 })
    .withMessage("Times must be a positive number."),

  body("frequency.days")
    .optional()
    .isInt(
      { min: 1, max: 7 }.withMessage("Day must be a number between 1 and 7")
    ),

  body("endDate")
    .optional()
    .isISO8601()
    .withMessage("End date must be a valid date format (YYYY-MM-DD)")
    .toDate(),
];

module.exports = { addHabitValidator };
