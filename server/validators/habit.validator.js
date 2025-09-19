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

  body("frequency.type")
    .isIn(["daily", "weekly"])
    .withMessage("Frequency must be one of: daily, weekly, or specific_days"),

  body("frequency.timesPerDay")
    .isInt({ min: 1, max: 7 })
    .withMessage("Times must be a positive number."),

  body("frequency.daysOfWeek")
    .isArray()
    .withMessage("daysOfWeek must be an array.")
    .custom((days) => {
      if (days.some((day) => typeof day !== number || day < 0 || day > 7)) {
        throw new console.error(
          "Each day in daysOfWeek must be a number between 0 and 6"
        );
      }

      return true;
    }),

  body("endDate")
    .optional()
    .isISO8601()
    .withMessage("End date must be a valid date format (YYYY-MM-DD)")
    .toDate(),
];

module.exports = { addHabitValidator };
