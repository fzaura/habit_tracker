/**
 * @module utils/token
 * @description Utility functions for JWT token generation.
 */
const jwt = require("jsonwebtoken");

/**
 * Generate access and refresh tokens for a user.
 * Creates JWT tokens with appropriate expiration times.
 *
 * @memberof module:utils/token
 * @function generateTokens
 * @param {Object} user - User object from database
 * @param {string} user._id - User's MongoDB ObjectId
 * @param {string} user.username - User's username
 * @returns {Object} Object containing accessToken (15m) and refreshToken (7d)
 * @throws {Error} Throws error if token generation fails
 */
const generateTokens = (user) => {
  try {
    const payload = { userId: user._id, username: user.username };

    const accessToken = jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: "15m",
    });

    const refreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET, {
      expiresIn: "7d",
    });

    return { refreshToken, accessToken };
  } catch (error) {
    console.log("Error generating tokens.");
    throw new Error("Could not generate tokens.");
  }
};
