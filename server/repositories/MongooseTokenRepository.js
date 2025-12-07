/**
 * @fileoverview Mongoose implementation of token repository.
 * Provides MongoDB-specific refresh token data access operations.
 *
 * @module repositories/MongooseTokenRepository
 * @requires ./ITokenRepository
 * @requires ../models/refreshToken.model
 */
const ITokenRepo = require("./ITokenRepository");
const TokenModel = require("../models/refreshToken.model");

/**
 * Mongoose implementation of token repository interface.
 * Handles refresh token CRUD operations using MongoDB.
 *
 * @class MongooseTokenRepository
 * @extends ITokenRepo
 */
class MongooseTokenRepository extends ITokenRepo {
  /**
   * Create and store a new refresh token.
   *
   * @async
   * @param {string} userId - User ID associated with token
   * @param {string} tokenValue - JWT refresh token value
   * @returns {Promise<Object>} Created token document
   */
  async createToken(userId, tokenValue) {
    const refreshToken = await TokenModel.create({ value: tokenValue, userId });

    return refreshToken;
  }

  /**
   * Find a token by its value.
   *
   * @async
   * @param {string} tokenValue - Token value to search for
   * @returns {Promise<Object|null>} Token object or null
   */
  async findTokenByValue(tokenValue) {
    const refreshToken = await TokenModel.findOne({ value: tokenValue });

    return refreshToken;
  }

  /**
   * Delete a token by its ID.
   *
   * @async
   * @param {string} TokenId - Token ID to delete
   * @returns {Promise<Object|null>} Deleted token document or null
   */
  async deleteTokenById(TokenId) {
    const deletedToken = await TokenModel.findByIdAndDelete(TokenId);
    return deletedToken;
  }

  /**
   * Delete all tokens associated with a user.
   *
   * @async
   * @param {string} userId - User ID whose tokens to delete
   * @returns {Promise<Object>} Deletion result with deletedCount
   */
  async deleteTokensByUserId(userId) {
    const deletedTokensCount = await TokenModel.deleteMany({ userId: userId });

    return deletedTokensCount;
  }
}

module.exports = MongooseTokenRepository;
