/**
 * @fileoverview Prisma implementation of habit repository.
 * Provides PostgreSQL-specific habit and habit completion data access operations using Prisma ORM.
 *
 * @module repositories/PrismaHabitRepository
 * @requires ./IHabitRepository
 * @requires @prisma/client
 */
const IHabitRepo = require("./IHabitRepository");

/**
 * Prisma implementation of habit repository interface.
 * Handles habit and completion CRUD operations using Prisma ORM with PostgreSQL.
 *
 * @class PrismaHabitRepository
 * @extends IHabitRepo
 */
class PrismaHabitRepository extends IHabitRepo {
  /**
   * Create a PrismaHabitRepository instance.
   *
   * @constructor
   * @param {Object} dependencies - Injected dependencies
   * @param {Object} dependencies.db - Prisma client instance
   */
  constructor({ db }) {
    super();
    this.db = db;
  }

  /**
   * Create a new habit for a user.
   *
   * @async
   * @param {Object} habitData - Habit information
   * @param {string} habitData.name - Habit name
   * @param {string} habitData.goal - Habit goal/description
   * @param {Object} habitData.frequency - Frequency configuration
   * @param {Date|string} [habitData.endDate] - Optional end date
   * @param {string} userId - User ID to associate with habit
   * @returns {Promise<Object>} Created habit document
   */
  async createHabit(habitData, userId) {
    const newHabit = await this.db.habit.create({
      data: {
        name: habitData.name,
        goal: habitData.goal,
        frequency: habitData.frequency,
        endDate: habitData.endDate ? new Date(habitData.endDate) : null,
        userId: userId,
      },
    });

    return newHabit;
  }

  /**
   * Delete a habit by ID for a specific user.
   *
   * @async
   * @param {string} habitId - Habit ID to delete
   * @param {string} userId - User ID for authorization
   * @returns {Promise<Object>} Deletion result with count
   */
  async deleteHabit(habitId, userId) {
    const result = await this.db.habit.deleteMany({
      where: { AND: [{ id: habitId }, { userId: userId }] },
    });

    return result;
  }

  /**
   * Update an existing habit.
   *
   * @async
   * @param {string} habitId - Habit ID to update
   * @param {Object} habitData - Updated habit data
   * @param {string} [habitData.name] - Updated name
   * @param {string} [habitData.goal] - Updated goal
   * @param {Object} [habitData.frequency] - Updated frequency
   * @param {Date|string} [habitData.endDate] - Updated end date
   * @param {string} userId - User ID for authorization
   * @returns {Promise<Object|null>} Updated habit or null
   */
  async updateHabit(habitId, habitData, userId) {
    const updatedHabit = await this.db.habit.updateMany({
      where: { AND: [{ id: habitId }, { userId }] },
      data: {
        name: habitData.name || undefined,
        goal: habitData.goal || undefined,
        frequency: habitData.frequency || undefined,
        endDate: habitData.endDate ? new Date(habitData.endDate) : undefined,
      },
    });

    if (updatedHabit.count > 0) {
      const habit = await this.db.habit.findUnique({ where: { id: habitId } });
      return habit;
    }

    return null;
  }

  /**
   * Get all habits for a user (unpaginated).
   *
   * @async
   * @param {string} userId - User ID
   * @returns {Promise<Array>} Array of habit objects
   */
  async getAllHabits(userId) {
    const habits = await this.db.habit.findMany({ where: { userId } });

    return habits;
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

    const [habits, total] = await this.db.$transaction([
      this.db.habit.findMany({
        where: { userId },
        take: limit,
        skip,
      }),
      this.db.habit.count({ where: { userId } }),
    ]);

    return { habits, total };
  }

  /**
   * Create a habit completion record.
   *
   * @async
   * @param {string} habitId - Habit ID
   * @param {string} userId - User ID
   * @param {Date|string} date - Completion date
   * @returns {Promise<Object>} Created completion document
   */
  async createCompletion(habitId, userId, date) {
    const newHabitCompletion = await this.db.habitCompletion.create({
      data: { userId, habitId, dateOfCompletion: new Date(date) },
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
   * @returns {Promise<Array>} Array of completion objects
   */
  async getCompletedHabitsByDateRange(userId, startDate, endDate) {
    const completions = await this.db.habitCompletion.findMany({
      where: {
        AND: [
          { userId },
          { dateOfCompletion: { gte: startDate, lte: endDate } },
        ],
      },
    });

    return completions;
  }
}

module.exports = PrismaHabitRepository;
