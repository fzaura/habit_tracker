/**
 * @module validators/habit
 * @description Express-validator middleware chains for habit management endpoints.
 * Provides validation for habit creation, updates, completion marking, and parameter validation.
 */
const { body, param } = require("express-validator");
const { parse, isValid } = require("date-fns");

/**
 * Custom validator for daysOfWeek field in weekly habits.
 * Ensures daysOfWeek is a valid array of day indices (0-6) for weekly frequency type.
 *
 * @memberof module:validators/habit
 * @function validateDaysOfWeek
 * @param {Array} value - Array of day indices
 * @param {Object} context - Express-validator context
 * @param {Object} context.req - Express request object
 * @returns {boolean} True if validation passes
 * @throws {Error} Validation error message
 */
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

/**
 * Validation chain for creating new habits.
 * Validates habit name, goal, frequency configuration, and optional end date.
 *
 * @memberof module:validators/habit
 * @constant {Array} addHabitValidator
 * @type {Array}
 */
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

/**
 * Validation chain for marking habit as completed.
 * Validates date format (YYYY-MM-DD).
 *
 * @memberof module:validators/habit
 * @constant {Array} markCompleteValidator
 * @type {Array}
 */
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

/**
 * Validation chain for updating existing habits.
 * All fields are optional. Validates habit name, goal, frequency, and end date.
 *
 * @memberof module:validators/habit
 * @constant {Array} updateHabitValidator
 * @type {Array}
 */
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

/**
 * Validation chain for MongoDB ObjectId parameters.
 * Validates ID format in URL parameters.
 *
 * @memberof module:validators/habit
 * @constant {Array} validateIdParam
 * @type {Array}
 */
const validateIdParam = [
  param("id").isMongoId().withMessage("Invalid ID format in URL"),
];

module.exports = {
  addHabitValidator,
  markCompleteValidator,
  updateHabitValidator,
  validateIdParam,
};
