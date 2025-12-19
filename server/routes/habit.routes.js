/**
 * @module routes/habit
 * @description Habit management routes for creating, updating, deleting, and tracking habits.
 * All routes require JWT authentication.
 */
const express = require("express");

const {
  addHabitValidator,
  markCompleteValidator,
  updateHabitValidator,
  validateIdParam,
} = require("../validators/habit.validator");

module.exports = ({ habitController, authMiddleware }) => {
  const router = express.Router();
  router.use(authMiddleware);

  /**
   * @name POST /
   * @description Create a new habit
   * @memberof module:routes/habit
   * @param {string} Authorization - Bearer token in header
   * @param {Object} req.body - Habit data
   * @param {string} req.body.name - Habit name
   * @param {string} req.body.goal - Habit description/goal
   * @param {Object} req.body.frequency - Frequency configuration
   * @param {string} req.body.frequency.type - 'daily' or 'weekly'
   * @param {number[]} [req.body.frequency.daysOfWeek] - Days of week (0-6) for weekly habits
   * @param {string} [req.body.endDate] - Optional end date (ISO format)
   * @returns {Object} 201 - Habit created successfully
   * @returns {Object} 400 - Validation errors
   * @returns {Object} 401 - Authentication required
   */
  /**
   * @name GET /
   * @description Get paginated list of user's habits
   * @memberof module:routes/habit
   * @param {string} Authorization - Bearer token in header
   * @param {number} [page=1] - Page number for pagination
   * @param {number} [limit=10] - Items per page
   * @returns {Object} 200 - Paginated habits list with metadata
   * @returns {Object} 401 - Authentication required
   */
  router
    .route("/")
    .post(addHabitValidator, habitController.createHabit)
    .get(habitController.getHabits);

  /**
   * @name DELETE /:id
   * @description Delete a specific habit
   * @memberof module:routes/habit
   * @param {string} Authorization - Bearer token in header
   * @param {string} id - Habit ID (ObjectId format)
   * @returns {Object} 200 - Habit deleted successfully
   * @returns {Object} 400 - Invalid habit ID format
   * @returns {Object} 401 - Authentication required
   * @returns {Object} 404 - Habit not found or unauthorized
   */
  /**
   * @name PUT /:id
   * @description Update a specific habit
   * @memberof module:routes/habit
   * @param {string} Authorization - Bearer token in header
   * @param {string} id - Habit ID (ObjectId format)
   * @param {Object} req.body - Updated habit data (all optional)
   * @param {string} [req.body.name] - Updated habit name
   * @param {string} [req.body.goal] - Updated habit goal
   * @param {Object} [req.body.frequency] - Updated frequency configuration
   * @param {string} [req.body.endDate] - Updated end date
   * @returns {Object} 200 - Habit updated successfully
   * @returns {Object} 400 - Validation errors or invalid ID format
   * @returns {Object} 401 - Authentication required
   * @returns {Object} 404 - Habit not found or unauthorized
   */
  router
    .route("/:id")
    .delete(validateIdParam, habitController.deleteHabit)
    .put(validateIdParam, updateHabitValidator, habitController.updateHabit);

  /**
   * @name POST /:id/completions
   * @description Mark a habit as completed on a specific date
   * @memberof module:routes/habit
   * @param {string} Authorization - Bearer token in header
   * @param {string} id - Habit ID (ObjectId format)
   * @param {Object} req.body - Completion data
   * @param {string} req.body.date - Completion date in YYYY-MM-DD format
   * @returns {Object} 201 - Habit marked as completed
   * @returns {Object} 400 - Validation errors or invalid ID format
   * @returns {Object} 401 - Authentication required
   * @returns {Object} 404 - Habit not found or unauthorized
   * @returns {Object} 409 - Habit already completed for this date
   */
  router.post(
    "/:id/completions",
    validateIdParam,
    markCompleteValidator,
    habitController.markAsCompleted
  );

  return router;
};
