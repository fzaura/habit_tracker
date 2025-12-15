/**
 * @fileoverview Habit management controller handling CRUD operations for habits.
 * Processes habit creation, updates, deletion, retrieval, and completion tracking.
 *
 * @module controllers/habit
 * @requires express-validator
 * @requires ../services/HabitService
 */
const { validationResult } = require("express-validator");

/**
 * Factory function to create habit controller with injected dependencies.
 *
 * @memberof module:controllers/habit
 * @function createHabitController
 * @param {Object} habitService - Instance of HabitService for handling habit operations
 * @returns {Object} Object containing controller methods: createHabit, deleteHabit, updateHabit, getHabits, markAsCompleted
 */
const createHabitController = ({ habitService }) => {
  /**
   * Create a new habit for the authenticated user.
   * Validates input and creates habit with user association.
   *
   * @async
   * @function createHabit
   * @param {Object} req - Express request object
   * @param {Object} req.body - Request body
   * @param {string} req.body.name - Habit name
   * @param {string} req.body.goal - Habit description/goal
   * @param {Object} req.body.frequency - Frequency configuration
   * @param {string} req.body.endDate - Optional end date
   * @param {Object} req.user - Authenticated user from JWT
   * @param {string} req.user.userId - User ID
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with created habit
   */
  const createHabit = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { name, goal, frequency, endDate } = req.body;

    try {
      const newHabit = await habitService.createHabit(
        { name, goal, frequency, endDate },
        req.user.userId
      );

      return res
        .status(201)
        .json({ message: "New habit successfully added.", habit: newHabit });
    } catch (error) {
      next(error);
    }
  };

  /**
   * Delete a specific habit belonging to the authenticated user.
   * Ensures user authorization before deletion.
   *
   * @async
   * @function deleteHabit
   * @param {Object} req - Express request object
   * @param {Object} req.params - URL parameters
   * @param {string} req.params.id - Habit ID to delete
   * @param {Object} req.user - Authenticated user from JWT
   * @param {string} req.user.userId - User ID
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON success message
   */
  const deleteHabit = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id: habitId } = req.params;
    const userId = req.user.userId;

    try {
      const result = await habitService.deleteHabit(habitId, userId);

      return res.status(200).json({ message: "Task deleted successfully." });
    } catch (error) {
      next(error);
    }
  };

  /**
   * Update an existing habit belonging to the authenticated user.
   * Validates input and ensures user authorization.
   *
   * @async
   * @function updateHabit
   * @param {Object} req - Express request object
   * @param {Object} req.params - URL parameters
   * @param {string} req.params.id - Habit ID to update
   * @param {Object} req.body - Request body with updated fields
   * @param {string} [req.body.name] - Updated habit name
   * @param {string} [req.body.goal] - Updated habit goal
   * @param {Object} [req.body.frequency] - Updated frequency config
   * @param {string} [req.body.endDate] - Updated end date
   * @param {Object} req.user - Authenticated user from JWT
   * @param {string} req.user.userId - User ID
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with updated habit
   */
  const updateHabit = async (req, res, next) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { name, goal, frequency, endDate } = req.body;

    const { id: habitId } = req.params;
    const userId = req.user.userId;

    try {
      const updateHabit = await habitService.updateHabit(
        habitId,
        { name, goal, frequency, endDate },
        userId
      );

      return res
        .status(200)
        .json({ message: "Habit updated successfully.", habit: updateHabit });
    } catch (error) {
      next(error);
    }
  };

  /**
   * Retrieve paginated list of habits for the authenticated user.
   * Supports pagination via query parameters.
   *
   * @async
   * @function getHabits
   * @param {Object} req - Express request object
   * @param {Object} req.query - Query parameters
   * @param {number} [req.query.page=1] - Page number
   * @param {number} [req.query.limit=10] - Items per page
   * @param {Object} req.user - Authenticated user from JWT
   * @param {string} req.user.userId - User ID
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with paginated habits
   */
  const getHabits = async (req, res, next) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const userId = req.user.userId;

    try {
      const info = await habitService.getHabits(page, limit, userId);

      return res.status(200).json({ info });
    } catch (error) {
      next(error);
    }
  };

  /**
   * Mark a habit as completed for a specific date.
   * Prevents duplicate completions for the same date.
   *
   * @async
   * @function markAsCompleted
   * @param {Object} req - Express request object
   * @param {Object} req.params - URL parameters
   * @param {string} req.params.id - Habit ID
   * @param {Object} req.body - Request body
   * @param {string} req.body.dateString - Completion date (YYYY-MM-DD)
   * @param {Object} req.user - Authenticated user from JWT
   * @param {string} req.user.userId - User ID
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON success message
   */
  const markAsCompleted = async (req, res, next) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id: habitId } = req.params;
    const userId = req.user.userId;
    const { dateString } = req.body;

    try {
      const habit = await habitService.markAsCompleted(
        habitId,
        userId,
        dateString
      );

      return res
        .status(200)
        .json({ message: "Habit marked as completed successfully." });
    } catch (error) {
      next(error);
    }
  };

  return {
    createHabit,
    deleteHabit,
    updateHabit,
    getHabits,
    markAsCompleted,
  };
};

module.exports = createHabitController;
