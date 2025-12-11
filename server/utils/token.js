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
    const payload = { userId: user.id, username: user.username };

    const accessToken = jwt.sign(payload, process.env.JWT_ACCESS_SECRET, {
      expiresIn: "15m",
    });

    const refreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET, {
      expiresIn: "1s",
    });

    return { refreshToken, accessToken };
  } catch (error) {
    console.log("Error generating tokens.");
    throw new Error("Could not generate tokens.");
  }
};

module.exports = { generateTokens };

//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5ZWI4N2VhNi1iYTA2LTQyYzMtYjg2Mi1hOTA0YzRiNDc1YTUiLCJ1c2VybmFtZSI6InRlc3QxMiIsImlhdCI6MTc2NTQ3MTQ3MSwiZXhwIjoxNzY2MDc2MjcxfQ.vSrFsus_EXBDSmZBctsBtxI-QgYvoBJt0_spcXOMDSY
//eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI5ZWI4N2VhNi1iYTA2LTQyYzMtYjg2Mi1hOTA0YzRiNDc1YTUiLCJ1c2VybmFtZSI6InRlc3QxMiIsImlhdCI6MTc2NTQ3MTQ3MSwiZXhwIjoxNzY1NDcyMzcxfQ.fAgzAdAZY7hM7Ki0tN6gNd0zEPVsV62a0LmL7UHflJM
