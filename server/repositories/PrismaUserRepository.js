/**
 * @fileoverview Prisma implementation of user repository.
 * Provides PostgreSQL-specific user data access operations using Prisma ORM.
 *
 * @module repositories/PrismaUserRepository
 * @requires ./IUserRepository
 * @requires @prisma/client
 */
const IUserRepo = require("./IUserRepository");

/**
 * Prisma implementation of user repository interface.
 * Handles user CRUD operations using Prisma ORM with PostgreSQL.
 *
 * @class PrismaUserRepository
 * @extends IUserRepo
 */
class PrismaUserRepository extends IUserRepo {
  /**
   * Create a PrismaUserRepository instance.
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
   * Create a new user in the database.
   *
   * @async
   * @param {Object} userData - User data object
   * @param {string} userData.username - Username
   * @param {string} userData.email - Email address
   * @param {string} userData.password - Hashed password
   * @returns {Promise<Object>} Created user object
   */
  async createUser(userData) {
    const newUser = await this.db.user.create({
      data: {
        username: userData.username,
        email: userData.email,
        password: userData.password,
      },
    });

    return newUser;
  }

  /**
   * Find a user by their ID.
   *
   * @async
   * @param {string} userId - User ID to search for
   * @returns {Promise<Object|null>} User object or null if not found
   */
  async findUserById(userId) {
    const user = await this.db.user.findUnique({ where: { id: userId } });

    return user;
  }

  /**
   * Find a user by their email address.
   *
   * @async
   * @param {string} email - Email address to search for
   * @returns {Promise<Object|null>} User object or null if not found
   */
  async findUserByEmail(email) {
    const user = await this.db.user.findUnique({ where: { email } });
    return user;
  }

  /**
   * Find a user by username or email.
   *
   * @async
   * @param {string} username - Username to search for
   * @param {string} email - Email to search for
   * @returns {Promise<Object|null>} User object or null if not found
   */
  async findUserByUsernameOrEmail(username, email) {
    const user = await this.db.user.findFirst({
      where: { OR: [{ username }, { email }] },
    });

    return user;
  }

  /**
   * Check for username/email conflicts excluding specific user.
   *
   * @async
   * @param {string} userId - User ID to exclude from search
   * @param {string} username - Username to check
   * @param {string} email - Email to check
   * @returns {Promise<Object|null>} Conflicting user or null
   */
  async findUserConflicts(userId, username, email) {
    const conflict = await this.db.user.findFirst({
      where: {
        AND: [{ OR: [{ username }, { email }] }, { NOT: { id: userId } }],
      },
    });
    return conflict;
  }

  /**
   * Update user data.
   *
   * @async
   * @param {string} userId - User ID to update
   * @param {Object} updateData - Data to update
   * @param {string} [updateData.email] - New email
   * @param {string} [updateData.username] - New username
   * @param {string} [updateData.password] - New hashed password
   * @returns {Promise<Object>} Updated user object
   */
  async updateUser(userId, updateData) {
    const updatedUser = await this.db.user.update({
      where: { id: userId },
      data: {
        email: updateData.email || undefined,
        username: updateData.username || undefined,
        password: updateData.password || undefined,
      },
    });

    return updatedUser;
  }
}

module.exports = PrismaUserRepository;
