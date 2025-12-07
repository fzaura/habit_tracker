/**
 * @fileoverview Mongoose implementation of user repository.
 * Provides MongoDB-specific user data access operations.
 *
 * @module repositories/MongooseUserRepository
 * @requires ./IUserRepository
 * @requires ../models/user.models
 */
const IUserRepo = require("./IUserRepository");
const UserModel = require("../models/user.models");

/**
 * Mongoose implementation of user repository interface.
 * Handles user CRUD operations using MongoDB.
 *
 * @class MongooseUserRepository
 * @extends IUserRepo
 */
class MongooseUserRepository extends IUserRepo {
  /**
   * Create a new user in MongoDB.
   *
   * @async
   * @param {Object} userData - User data to create
   * @returns {Promise<Object>} Created user document
   */
  async createUser(userData) {
    const newUser = await UserModel.create(userData);

    return newUser;
  }

  /**
   * Find a user by their ID.
   *
   * @async
   * @param {string} userId - User ID to search for
   * @returns {Promise<Object|null>} User object (lean) or null
   */
  async findUserById(userId) {
    const user = await UserModel.findById(userId).lean();

    return user;
  }

  /**
   * Find a user by their email address.
   *
   * @async
   * @param {string} email - Email to search for
   * @returns {Promise<Object|null>} User object (lean) or null
   */
  async findUserByEmail(email) {
    const user = await UserModel.findOne({ email }).lean();

    return user;
  }

  /**
   * Find a user by username or email.
   *
   * @async
   * @param {string} username - Username to search for
   * @param {string} email - Email to search for
   * @returns {Promise<Object|null>} User object (lean) or null
   */
  async findUserByUsernameOrEmail(username, email) {
    const user = await UserModel.findOne({
      $or: [{ username }, { email }],
    }).lean();

    return user;
  }

  /**
   * Find conflicting username/email excluding a specific user.
   *
   * @async
   * @param {string} userId - User ID to exclude from search
   * @param {string} username - Username to check
   * @param {string} email - Email to check
   * @returns {Promise<Object|null>} Conflicting user or null
   */
  async findUserConflicts(userId, username, email) {
    const conflict = await UserModel.findOne({
      $or: [{ username }, { email }],
      _id: { $ne: userId },
    }).lean();

    return conflict;
  }

  /**
   * Update user data by ID.
   *
   * @async
   * @param {string} userId - User ID to update
   * @param {Object} updateData - Data to update
   * @returns {Promise<Object>} Updated user (lean, without password)
   */
  async updateUser(userId, updateData) {
    const updatedUser = await UserModel.findByIdAndUpdate(
      userId,
      { $set: updateData },
      { new: true, runValidators: true }
    )
      .select("-password")
      .lean();

    return updatedUser;
  }
}

module.exports = MongooseUserRepository;
