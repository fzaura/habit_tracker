/**
 * @fileoverview Prisma implementation of token repository.
 * Provides PostgreSQL-specific refresh token data access operations using Prisma ORM.
 *
 * @module repositories/PrismaTokenRepository
 * @requires ./ITokenRepository
 * @requires @prisma/client
 */
const ITokenRepo = require("./ITokenRepository");

/**
 * Prisma implementation of token repository interface.
 * Handles refresh token CRUD operations using Prisma ORM with PostgreSQL.
 *
 * @class PrismaTokenRepository
 * @extends ITokenRepo
 */
class PrismaTokenRepository extends ITokenRepo {
  /**
   * Create a PrismaTokenRepository instance.
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
   * Create and store a new refresh token.
   *
   * @async
   * @param {string} userId - User ID associated with token
   * @param {string} tokenValue - JWT refresh token value
   * @param {Date|string} expiresAt - Token expiration timestamp
   * @returns {Promise<Object>} Created token document
   */
  async createToken(userId, tokenValue, expiresAt) {
    const token = await this.db.refreshToken.create({
      data: {
        userId,
        value: tokenValue,
        expiresAt: new Date(expiresAt),
      },
    });

    return token;
  }

  /**
   * Find a token by its value.
   *
   * @async
   * @param {string} tokenValue - Token value to search for
   * @returns {Promise<Object|null>} Token object or null
   */
  async findTokenByValue(tokenValue) {
    const token = await this.db.refreshToken.findUnique({
      where: { value: tokenValue },
    });

    return token;
  }

  /**
   * Delete a token by its ID.
   *
   * @async
   * @param {string} tokenId - Token ID to delete
   * @returns {Promise<Object>} Deletion result
   */
  async deleteTokenById(tokenId) {
    const token = await this.db.refreshToken.deleteMany({
      where: { id: tokenId },
    });

    return token;
  }

  /**
   * Delete all tokens associated with a user.
   *
   * @async
   * @param {string} userId - User ID whose tokens to delete
   * @returns {Promise<Object>} Deletion result with count
   */
  async deleteTokensByUserId(userId) {
    const deletedCount = await this.db.refreshToken.deleteMany({
      where: { userId },
    });

    return deletedCount;
  }
}

module.exports = PrismaTokenRepository;
