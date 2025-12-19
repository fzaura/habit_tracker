/**
 * @fileoverview User service managing user profile updates.
 * Handles business logic for user account modifications.
 *
 * @module services/UserService
 * @requires bcrypt
 * @requires ../repositories/IUserRepository
 */
const bcrypt = require("bcrypt");

/**
 * Service class for user management operations.
 * Handles user profile updates with validation and security.
 *
 * @class UserService
 */
class UserService {
  /**
   * Create a UserService instance.
   *
   * @constructor
   * @param {Object} userRepository - Repository for user data operations
   */
  constructor({ userRepo, config }) {
    this.userRepo = userRepo;
    this.saltRounds = config.saltRounds;
  }

  /**
   * Update user profile information.
   * Validates uniqueness of username/email and hashes password if provided.
   *
   * @async
   * @function updateUser
   * @param {string} userId - ID of user to update
   * @param {Object} updateData - Data to update
   * @param {string} [updateData.username] - New username
   * @param {string} [updateData.email] - New email
   * @param {string} [updateData.password] - New password (will be hashed)
   * @returns {Promise<Object>} Updated user object (without password)
   * @throws {Error} If username or email already in use
   */
  async updateUser(userId, updateData) {
    const safeUpdates = {};

    if (updateData.username) {
      safeUpdates.username = updateData.username;
    }

    if (updateData.email) {
      safeUpdates.email = updateData.email;
    }

    if (updateData.password) {
      safeUpdates.password = updateData.password;
    }

    if (safeUpdates.email || safeUpdates.username) {
      const userConflicts = await this.userRepo.findUserConflicts(
        userId,
        safeUpdates.username,
        safeUpdates.email
      );

      if (userConflicts) {
        if (userConflicts.email === safeUpdates.email) {
          throw new Error("Email already in use.");
        } else {
          throw new Error("Username already in use.");
        }
      }
    }

    if (updateData.password) {
      const hashedPassword = await bcrypt.hash(
        safeUpdates.password,
        parseInt(this.saltRounds)
      );
      safeUpdates.password = hashedPassword;
    }

    const updatedUser = await this.userRepo.updateUser(userId, safeUpdates);

    return updatedUser;
  }
}

module.exports = UserService;
