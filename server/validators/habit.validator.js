const { body } = require("express-validator");
const { parse, isValid } = require("date-fns");

const validateDaysOfWeek = (value, { req }) => {
  const freqType = req.body.frequency?.type;

  if (freqType === "weekly") {
    if (!Array.isArray(value) || value.length === 0) {
      throw new Error(
        "daysOfWeek is required and must be a non-empty array for a 'weekly' habit."
      );
    }
    if (value.some((day) => typeof day !== "number" || day < 0 || day > 6)) {
      throw new Error(
        "Each day in daysOfWeek must be a number between 0 and 6."
      );
    }
  }
  return true;
};

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
    .withMessage("Frequency must be one of: daily, weekly"),

  body("frequency.daysOfWeek").custom(validateDaysOfWeek),

  body("endDate")
    .optional()
    .isISO8601()
    .withMessage("End date must be a valid date format (YYYY-MM-DD)")
    .toDate(),
];

const markCompleteValidator = [
  body("date", "Please provide a valid date in yyyy-MM-DD format.")
    .notEmpty()
    .custom((value) => {
      const date = parse(value, "yyyy-MM-dd", new Date());
      if (!isValid(date)) {
        throw new Error("Date provided is invalid.");
      }

      return true;
    }),
];

const updateHabitValidator = [
  body("name")
    .optional()
    .trim()
    .notEmpty()
    .withMessage("Habit name is required.")
    .isLength({ max: 100 })
    .withMessage("Habit name cannot exceed 100 characters.")
    .escape(),

  body("goal")
    .optional()
    .trim()
    .notEmpty()
    .withMessage("Habit goal cannot be empty.")
    .isLength({ max: 100 })
    .withMessage("Habit goal cannot exceed 100 characters")
    .escape(),

  body("frequency.type")
    .optional()
    .isIn(["daily", "weekly"])
    .withMessage("Frequency must be one of: daily, weekly"),

  body("frequency.daysOfWeek").custom(validateDaysOfWeek),

  body("endDate")
    .optional()
    .isISO8601()
    .withMessage("End date must be a valid date format (YYYY-MM-DD)")
    .toDate(),
];

module.exports = {
  addHabitValidator,
  markCompleteValidator,
  updateHabitValidator,
};
