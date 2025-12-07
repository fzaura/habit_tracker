/**
 * @fileoverview Habit repository interface definition.
 * Defines the contract for habit and habit completion data access operations.
 *
 * @module repositories/IHabitRepository
 */

/**
 * Interface for habit repository operations.
 * All methods must be implemented by concrete repository classes.
 *
 * @interface IHabitRepository
 */
class IHabitRepository {
  /**
   * Create a new habit for a user.
   *
   * @abstract
   * @param {Object} habitData - Habit information
   * @param {string} userId - ID of user creating habit
   * @returns {Promise<Object>} Created habit object
   * @throws {Error} Method not implemented
   */
  createHabit(habitData, userId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Delete a habit by ID for a specific user.
   *
   * @abstract
   * @param {string} habitId - Habit ID to delete
   * @param {string} userId - User ID for authorization
   * @returns {Promise<Object>} Deletion result
   * @throws {Error} Method not implemented
   */
  deleteHabit(habitId, userId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Update an existing habit.
   *
   * @abstract
   * @param {string} habitId - Habit ID to update
   * @param {Object} habitData - Updated habit data
   * @param {string} userId - User ID for authorization
   * @returns {Promise<Object>} Updated habit object
   * @throws {Error} Method not implemented
   */
  updateHabit(habitId, habitData, userId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Get all habits for a user (unpaginated).
   *
   * @abstract
   * @param {string} userId - User ID
   * @returns {Promise<Array>} Array of habit objects
   * @throws {Error} Method not implemented
   */
  getAllHabits(userId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Get paginated habits for a user.
   *
   * @abstract
   * @param {number} page - Page number
   * @param {number} limit - Items per page
   * @param {string} userId - User ID
   * @returns {Promise<Object>} Object with habits array and total count
   * @throws {Error} Method not implemented
   */
  getHabits(page, limit, userId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Create a habit completion record.
   *
   * @abstract
   * @param {string} habitId - Habit ID
   * @param {string} userId - User ID
   * @param {Date} date - Completion date
   * @returns {Promise<Object>} Created completion object
   * @throws {Error} Method not implemented
   */
  createCompletion(habitId, userId, date) {
    throw new Error("Method not implemented.");
  }

  /**
   * Get habit completions within a date range.
   *
   * @abstract
   * @param {string} userId - User ID
   * @param {Date} startDate - Start of date range
   * @param {Date} endDate - End of date range
   * @returns {Promise<Array>} Array of completion objects
   * @throws {Error} Method not implemented
   */
  getCompletedHabitsByDateRange(userId, startDate, endDate) {
    throw new Error("Method not implemented.");
  }
}

module.exports = IHabitRepository;
