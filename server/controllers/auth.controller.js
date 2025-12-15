/**
 * @fileoverview Authentication controller handling user registration, login, and token refresh.
 * Processes requests after validation and interacts with AuthService.
 *
 * @module controllers/auth
 * @requires express-validator
 * @requires ../services/AuthService
 */
const { validationResult } = require("../validators/auth.validator");

/**
 * Factory function to create authentication controller with injected dependencies.
 *
 * @memberof module:controllers/auth
 * @function createAuthController
 * @param {Object} authService - Instance of AuthService for handling auth operations
 * @returns {Object} Object containing controller methods: registerUser, loginUser, getNewAccessToken
 */
const createAuthController = ({ authService }) => {
  /**
   * Register a new user account.
   * Validates input, creates user, generates tokens.
   *
   * @async
   * @function registerUser
   * @param {Object} req - Express request object
   * @param {Object} req.body - Request body
   * @param {string} req.body.username - Username (5-12 chars)
   * @param {string} req.body.email - Email address
   * @param {string} req.body.password - Password (min 10 chars)
   * @param {string} req.body.confirmPassword - Password confirmation
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with user data and tokens
   */
  const registerUser = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { username, email, password } = req.body;

    try {
      const { newUser, accessToken, refreshToken } =
        await authService.registerUser(username, email, password);

      const safeUser = newUser.toObject ? newUser.toObject() : { ...newUser };
      delete safeUser.password;

      return res.status(201).json({
        message: "User registered successfully.",
        accessToken,
        refreshToken,
        user: safeUser,
      });
    } catch (error) {
      next(error);
    }
  };

  /**
   * Authenticate existing user and generate new tokens.
   * Validates credentials and creates new session.
   *
   * @async
   * @function loginUser
   * @param {Object} req - Express request object
   * @param {Object} req.body - Request body
   * @param {string} req.body.email - User email
   * @param {string} req.body.password - User password
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with user data and tokens
   */
  const loginUser = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { email, password } = req.body;

    try {
      const { user, accessToken, refreshToken } = await authService.loginUser(
        email,
        password
      );
      delete user.password;

      return res.status(200).json({
        message: "User logged in successfully.",
        accessToken,
        refreshToken,
        user,
      });
    } catch (error) {
      next(error);
    }
  };

  /**
   * Refresh user session using a valid refresh token.
   * Validates refresh token, revokes old token, generates new token pair.
   *
   * @async
   * @function getNewAccessToken
   * @param {Object} req - Express request object
   * @param {Object} req.body - Request body
   * @param {string} req.body.refreshToken - Valid refresh token
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with new token pair
   */
  const getNewAccessToken = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { refreshToken: oldRefreshToken } = req.body;
    try {
      const { refreshToken, accessToken } =
        await authService.refreshUserSession(oldRefreshToken);

      return res.status(200).json({
        message: "Session refreshed successfully.",
        refreshToken,
        accessToken,
      });
    } catch (error) {
      next(error);
    }
  };

  return { registerUser, loginUser, getNewAccessToken };
};

module.exports = createAuthController;
