/**
 * @fileoverview Habit service managing habit CRUD operations and completion tracking.
 * Handles business logic for habit management and validation.
 *
 * @module services/HabitService
 * @requires ../repositories/IHabitRepository
 */

/**
 * Service class for habit management operations.
 * Handles habit creation, updates, deletion, retrieval, and completion tracking.
 *
 * @class HabitService
 */
class HabitService {
  /**
   * Create a HabitService instance.
   *
   * @constructor
   * @param {Object} habitRepository - Repository for habit data operations
   */
  constructor({ habitRepository }) {
    this.habitRepository = habitRepository;
  }

  /**
   * Create a new habit for a user.
   * Validates required fields and normalizes daily frequency.
   *
   * @async
   * @function createHabit
   * @param {Object} habitData - Habit information
   * @param {string} habitData.name - Habit name
   * @param {string} habitData.goal - Habit description/goal
   * @param {Object|string} habitData.frequency - Frequency config or 'daily'
   * @param {string} habitData.endDate - End date
   * @param {string} userId - ID of user creating the habit
   * @returns {Promise<Object>} Created habit object
   * @throws {Error} If required fields are missing
   */
  async createHabit(habitData, userId) {
    if (!habitData.name) {
      throw new Error("Habit name is required");
    }
    if (!habitData.goal) {
      throw new Error("Habit goal is required");
    }
    if (!habitData.frequency) {
      throw new Error("Habit frequency is required");
    }
    if (!habitData.endDate) {
      throw new Error("Habit end date is required");
    }

    if (habitData.frequency === "daily") {
      habitData.frequency = {
        type: "daily",
        daysOfWeek: [0, 1, 2, 3, 4, 5, 6],
      };
    }

    const newHabit = await this.habitRepository.createHabit(habitData, userId);
    return newHabit;
  }

  /**
   * Delete a habit belonging to a specific user.
   * Ensures user authorization before deletion.
   *
   * @async
   * @function deleteHabit
   * @param {string} habitId - ID of habit to delete
   * @param {string} userId - ID of user requesting deletion
   * @returns {Promise<Object>} Deletion result
   * @throws {Error} If habit not found or user unauthorized
   */
  async deleteHabit(habitId, userId) {
    const result = await this.habitRepository.deleteHabit(habitId, userId);

    if (!result || result.deletedCount === 0) {
      const error = new Error("Habit not found or user unauthorized.");
      error.status = 404;
      throw error;
    }

    return result;
  }

  /**
   * Update an existing habit with new data.
   * Validates required parameters and normalizes daily frequency.
   *
   * @async
   * @function updateHabit
   * @param {string} habitId - ID of habit to update
   * @param {Object} habitData - Updated habit information
   * @param {string} [habitData.name] - Updated habit name
   * @param {string} [habitData.goal] - Updated goal
   * @param {Object|string} [habitData.frequency] - Updated frequency
   * @param {string} [habitData.endDate] - Updated end date
   * @param {string} userId - ID of user requesting update
   * @returns {Promise<Object>} Updated habit object
   * @throws {Error} If required parameters missing or habit not found
   */
  async updateHabit(habitId, habitData, userId) {
    if (!habitId) {
      throw new Error("Habit ID is required.");
    }
    if (!habitData) {
      throw new Error("Habit data is required.");
    }
    if (!userId) {
      throw new Error("User ID is required.");
    }

    if (habitData.frequency === "daily") {
      habitData.frequency = {
        type: "daily",
        daysOfWeek: [0, 1, 2, 3, 4, 5, 6],
      };
    }
    const updatedHabit = await this.habitRepository.updateHabit(
      habitId,
      habitData,
      userId
    );

    if (!updatedHabit) {
      throw new Error("Habit not found or user unauthorized.");
    }

    return updatedHabit;
  }

  /**
   * Retrieve paginated list of habits for a user.
   * Returns habits with pagination metadata.
   *
   * @async
   * @function getHabits
   * @param {number} page - Page number (1-indexed)
   * @param {number} limit - Number of items per page
   * @param {string} userId - ID of user
   * @returns {Promise<Object>} Object with data array and pagination info
   */
  async getHabits(page, limit, userId) {
    const { habits, total } = await this.habitRepository.getHabits(
      page,
      limit,
      userId
    );

    const totalPages = Math.ceil(total / limit);

    const info = {
      data: habits,
      pagination: {
        totalItems: total,
        totalPages: totalPages,
        currentPage: page,
      },
    };

    return info;
  }

  /**
   * Mark a habit as completed for a specific date.
   * Prevents duplicate completions on the same date.
   *
   * @async
   * @function markAsCompleted
   * @param {string} habitId - ID of habit to mark complete
   * @param {string} userId - ID of user
   * @param {string} dateString - Date in ISO format (YYYY-MM-DD)
   * @returns {Promise<Object>} Created completion record
   * @throws {Error} If required params missing, date invalid, or already completed
   */
  async markAsCompleted(habitId, userId, dateString) {
    if (!userId) {
      throw new Error("User ID is required.");
    }
    if (!habitId) {
      throw new Error("Habit ID is required.");
    }
    if (!dateString) {
      throw new Error("Date string is required.");
    }

    const date = new Date(dateString);
    if (isNaN(date.getTime())) {
      throw new Error("Invalid date string.");
    }

    const startOfDay = new Date(dateString);
    startOfDay.setUTCHours(0, 0, 0, 0);
    const endOfDay = new Date(dateString);
    endOfDay.setUTCHours(23, 59, 59, 999);

    const completionsToday =
      await this.habitRepository.getCompletedHabitsByDateRange(
        userId,
        startOfDay,
        endOfDay
      );

    const isCompleted = completionsToday.some(
      (c) => c.habitId.toString() === habitId
    );
    if (isCompleted) {
      throw new Error("Habit is already completed.");
    }

    return await this.habitRepository.createCompletion(habitId, userId, date);
  }
}

module.exports = HabitService;
