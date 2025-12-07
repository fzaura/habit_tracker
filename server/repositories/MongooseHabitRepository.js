/**
 * @fileoverview Mongoose implementation of habit repository.
 * Provides MongoDB-specific habit and habit completion data access operations.
 *
 * @module repositories/MongooseHabitRepository
 * @requires ./IHabitRepository
 * @requires ../models/habit.model
 * @requires ../models/habitCompletion.model
 */
const IHabitRepo = require("./IHabitRepository");
const Habit = require("../models/habit.model");
const HabitCompletion = require("../models/habitCompletion.model");

/**
 * Mongoose implementation of habit repository interface.
 * Handles habit and completion CRUD operations using MongoDB.
 *
 * @class MongooseHabitRepository
 * @extends IHabitRepo
 */
class MongooseHabitRepository extends IHabitRepo {
  /**
   * Create a new habit for a user.
   *
   * @async
   * @param {Object} habitData - Habit information
   * @param {string} userId - User ID to associate with habit
   * @returns {Promise<Object>} Created habit document
   */
  async createHabit(habitData, userId) {
    const habitToCreate = {
      ...habitData,
      userId,
    };

    const newHabit = await Habit.create(habitToCreate);

    return newHabit;
  }

  /**
   * Delete a habit by ID for a specific user.
   *
   * @async
   * @param {string} habitId - Habit ID to delete
   * @param {string} userId - User ID for authorization
   * @returns {Promise<Object>} Deletion result
   */
  async deleteHabit(habitId, userId) {
    const result = Habit.deleteOne({ _id: habitId, userId });

    return result;
  }

  /**
   * Update an existing habit.
   *
   * @async
   * @param {string} habitId - Habit ID to update
   * @param {Object} habitData - Updated habit data
   * @param {string} userId - User ID for authorization
   * @returns {Promise<Object|null>} Updated habit (lean) or null
   */
  async updateHabit(habitId, habitData, userId) {
    const updatedHabit = await Habit.findOneAndUpdate(
      { _id: habitId, userId },
      habitData,
      { new: true, runValidators: true }
    ).lean();

    return updatedHabit;
  }

  /**
   * Get all habits for a user (unpaginated).
   *
   * @async
   * @param {string} userId - User ID
   * @returns {Promise<Array>} Array of habit objects (lean)
   */
  async getAllHabits(userId) {
    return Habit.find({ userId }).lean();
  }

  /**
   * Get paginated habits for a user.
   *
   * @async
   * @param {number} page - Page number (1-indexed)
   * @param {number} limit - Items per page
   * @param {string} userId - User ID
   * @returns {Promise<Object>} Object with habits array and total count
   */
  async getHabits(page, limit, userId) {
    const skip = (page - 1) * limit;

    const [habits, total] = await Promise.all([
      Habit.find({ userId })
        .sort({ createdAt: -1 })
        .limit(limit)
        .skip(skip)
        .lean(),
      Habit.countDocuments({ userId }),
    ]);

    return { habits, total };
  }

  /**
   * Create a habit completion record.
   *
   * @async
   * @param {string} habitId - Habit ID
   * @param {string} userId - User ID
   * @param {Date} date - Completion date
   * @returns {Promise<Object>} Created completion document
   */
  async createCompletion(habitId, userId, date) {
    const newHabitCompletion = HabitCompletion.create({
      habitId: habitId,
      userId,
      date,
    });

    return newHabitCompletion;
  }

  /**
   * Get habit completions within a date range for a user.
   *
   * @async
   * @param {string} userId - User ID
   * @param {Date} startDate - Start of date range
   * @param {Date} endDate - End of date range
   * @returns {Promise<Array>} Array of completion objects (lean)
   */
  async getCompletedHabitsByDateRange(userId, startDate, endDate) {
    const completions = await HabitCompletion.find({
      userId,
      dateOfCompletion: {
        $gte: startDate,
        $lte: endDate,
      },
    }).lean();

    return completions;
  }
}

module.exports = MongooseHabitRepository;
