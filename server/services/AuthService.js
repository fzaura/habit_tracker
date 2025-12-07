/**
 * @fileoverview Authentication service handling user registration, login, and session refresh.
 * Manages password hashing, token generation, and user authentication.
 *
 * @module services/AuthService
 * @requires bcrypt
 * @requires jsonwebtoken
 * @requires ../utils/token
 * @requires ../repositories/IUserRepository
 * @requires ../repositories/ITokenRepository
 */
const bcrypt = require("bcrypt");
const { generateTokens } = require("../utils/token");
const jwt = require("jsonwebtoken");

/**
 * Service class for authentication operations.
 * Handles user registration, login, and token refresh logic.
 *
 * @class AuthService
 */
class AuthService {
  /**
   * Create an AuthService instance.
   *
   * @constructor
   * @param {Object} userRepository - Repository for user data operations
   * @param {Object} tokenRepository - Repository for token data operations
   */
  constructor(userRepository, tokenRepository) {
    this.userRepo = userRepository;
    this.tokenRepo = tokenRepository;
  }

  /**
   * Register a new user with hashed password and generate tokens.
   * Checks for existing username/email before creating user.
   *
   * @async
   * @function registerUser
   * @param {string} username - Desired username (5-12 chars)
   * @param {string} email - User email address
   * @param {string} password - Plain text password (will be hashed)
   * @returns {Promise<Object>} Object containing newUser, accessToken, and refreshToken
   * @throws {Error} If username/email already exists or validation fails
   */
  async registerUser(username, email, password) {
    if (!username) {
      throw new Error("Username is required");
    }
    if (!email) {
      throw new Error("Email is required");
    }
    if (!password) {
      throw new Error("Password is required");
    }

    const userExists = await this.userRepo.findUserByUsernameOrEmail(
      username,
      email
    );

    if (userExists) {
      if (userExists.email === email) {
        throw new Error("Email already in use.");
      } else {
        throw new Error("Username already in use.");
      }
    }

    const hashedPassword = await bcrypt.hash(
      password,
      parseInt(process.env.SALT_ROUNDS)
    );

    const userData = { username, email, password: hashedPassword };
    const newUser = await this.userRepo.createUser(userData);

    const { refreshToken, accessToken } = generateTokens(newUser);

    const newRefreshToken = await this.tokenRepo.createToken(
      newUser.id,
      refreshToken
    );

    return { newUser, accessToken, refreshToken };
  }

  /**
   * Authenticate user with email and password, generate new tokens.
   * Validates credentials and creates new session tokens.
   *
   * @async
   * @function loginUser
   * @param {string} email - User email address
   * @param {string} password - Plain text password
   * @returns {Promise<Object>} Object containing user, accessToken, and refreshToken
   * @throws {Error} If credentials are invalid
   */
  async loginUser(email, password) {
    if (!email) {
      throw new Error("Email is required.");
    }
    if (!password) {
      throw new Error("Password is required.");
    }

    const user = await this.userRepo.findUserByEmail(email);
    if (!user) {
      throw new Error("Invalid credentials.");
    }

    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      throw new Error("Invalid credentials.");
    }

    const { refreshToken, accessToken } = generateTokens(user);

    const newRefreshToken = await this.tokenRepo.createToken(
      user.id,
      refreshToken
    );

    return { user, accessToken, refreshToken };
  }

  /**
   * Refresh user session using a valid refresh token.
   * Verifies old token, revokes it, and generates new token pair.
   *
   * @async
   * @function refreshUserSession
   * @param {string} oldRefreshToken - Current valid refresh token
   * @returns {Promise<Object>} Object containing new accessToken and refreshToken
   * @throws {Error} If token is invalid, expired, or revoked
   */
  async refreshUserSession(oldRefreshToken) {
    if (!oldRefreshToken) {
      throw new Error("Refresh token is required.");
    }

    const storedToken = await this.tokenRepo.findTokenByValue(oldRefreshToken);
    if (!storedToken) {
      throw new Error("Token has been revoked or previously used.");
    }
    try {
      const decoded = jwt.verify(
        oldRefreshToken,
        process.env.JWT_REFRESH_SECRET
      );

      await this.tokenRepo.deleteTokenById(storedToken.id);

      const user = { id: decoded.userId, username: decoded.username };

      const { refreshToken, accessToken } = generateTokens(user);

      const newRefreshToken = await this.tokenRepo.createToken(
        user.id,
        refreshToken
      );

      return { accessToken, refreshToken };
    } catch (error) {
      if (
        error.name === "TokenExpiredError" ||
        error.name === "JsonWebTokenError"
      ) {
        await this.tokenRepo.deleteTokenById(storedToken.id);
        throw new Error("Token has been revoked or expired.");
      }
    }
  }
}

module.exports = AuthService;
