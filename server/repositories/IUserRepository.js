/**
 * @fileoverview User repository interface definition.
 * Defines the contract for user data access operations.
 *
 * @module repositories/IUserRepository
 */

/**
 * Interface for user repository operations.
 * All methods must be implemented by concrete repository classes.
 *
 * @interface IUserRepository
 */
class IUserRepository {
  /**
   * Create a new user in the database.
   *
   * @abstract
   * @param {Object} userData - User data object
   * @param {string} userData.username - Username
   * @param {string} userData.email - Email address
   * @param {string} userData.password - Hashed password
   * @returns {Promise<Object>} Created user object
   * @throws {Error} Method not implemented
   */
  createUser(userData) {
    throw new Error("Method not implemented.");
  }

  /**
   * Find a user by their ID.
   *
   * @abstract
   * @param {string} userId - User ID to search for
   * @returns {Promise<Object|null>} User object or null if not found
   * @throws {Error} Method not implemented
   */
  findUserById(userId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Find a user by their email address.
   *
   * @abstract
   * @param {string} email - Email address to search for
   * @returns {Promise<Object|null>} User object or null if not found
   * @throws {Error} Method not implemented
   */
  findUserByEmail(email) {
    throw new Error("Method not implemented");
  }

  /**
   * Find a user by username or email.
   *
   * @abstract
   * @param {string} username - Username to search for
   * @param {string} email - Email to search for
   * @returns {Promise<Object|null>} User object or null if not found
   * @throws {Error} Method not implemented
   */
  findUserByUsernameOrEmail(username, email) {
    throw new Error("Method not implemented");
  }

  /**
   * Check for username/email conflicts excluding specific user.
   *
   * @abstract
   * @param {string} userId - User ID to exclude from search
   * @param {string} username - Username to check
   * @param {string} email - Email to check
   * @returns {Promise<Object|null>} Conflicting user or null
   * @throws {Error} Method not implemented
   */
  findUserConflicts(userId, username, email) {
    throw new Error("Method not implemented");
  }

  /**
   * Update user data.
   *
   * @abstract
   * @param {string} userId - User ID to update
   * @param {Object} updateData - Data to update
   * @returns {Promise<Object>} Updated user object
   * @throws {Error} Method not implemented
   */
  updateUser(userId, updateData) {
    throw new Error("Method not implemented.");
  }
}

module.exports = IUserRepository;
