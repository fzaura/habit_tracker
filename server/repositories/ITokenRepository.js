/**
 * @fileoverview Token repository interface definition.
 * Defines the contract for refresh token data access operations.
 *
 * @module repositories/ITokenRepository
 */

/**
 * Interface for token repository operations.
 * All methods must be implemented by concrete repository classes.
 *
 * @interface ITokenRepository
 */
class ITokenRepository {
  /**
   * Create and store a new refresh token.
   *
   * @abstract
   * @param {string} userId - User ID associated with token
   * @param {string} tokenValue - JWT refresh token value
   * @returns {Promise<Object>} Created token object
   * @throws {Error} Method not implemented
   */
  createToken(userId, tokenValue) {
    throw new Error("Method not implemented.");
  }

  /**
   * Find a token by its value.
   *
   * @abstract
   * @param {string} tokenValue - Token value to search for
   * @returns {Promise<Object|null>} Token object or null if not found
   * @throws {Error} Method not implemented
   */
  findTokenByValue(tokenValue) {
    throw new Error("Method not implemented.");
  }

  /**
   * Delete a token by its ID.
   *
   * @abstract
   * @param {string} tokenId - Token ID to delete
   * @returns {Promise<Object>} Deletion result
   * @throws {Error} Method not implemented
   */
  deleteTokenById(tokenId) {
    throw new Error("Method not implemented.");
  }

  /**
   * Delete all tokens associated with a user.
   *
   * @abstract
   * @param {string} userId - User ID whose tokens to delete
   * @returns {Promise<Object>} Deletion result with count
   * @throws {Error} Method not implemented
   */
  deleteTokensByUserId(userId) {
    throw new Error("Method not implemented.");
  }
}

module.exports = ITokenRepository;
