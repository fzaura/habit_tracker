/**
 * @fileoverview Authentication routes for user registration, login, and token refresh.
 * Defines endpoints for authentication operations.
 *
 * @module routes/auth
 * @requires express
 * @requires ../validators/auth.validator
 * @requires ../controllers/auth.controller
 */
const express = require("express");

const {
  registerValidator,
  loginValidator,
  refreshTokenValidator,
} = require("../validators/auth.validator");

/**
 * @swagger
 * tags:
 * name: Auth
 * description: User registration and login management
 */

/**
 * @swagger
 * /auth/register:
 * post:
 * summary: Register a new user
 * tags: [Auth]
 * security: []
 * requestBody:
 * required: true
 * content:
 * application/json:
 * schema:
 * type: object
 * required:
 * - username
 * - email
 * - password
 * - confirmPassword
 * properties:
 * username:
 * type: string
 * example: HabitHero
 * email:
 * type: string
 * format: email
 * example: hero@test.com
 * password:
 * type: string
 * format: password
 * example: Password123!
 * confirmPassword:
 * type: string
 * format: password
 * example: Password123!
 * responses:
 * 201:
 * description: User registered successfully
 * content:
 * application/json:
 * schema:
 * type: object
 * properties:
 * accessToken:
 * type: string
 * refreshToken:
 * type: string
 * 400:
 * description: Validation error or email already in use
 */

/**
 * @swagger
 * /auth/login:
 * post:
 * summary: Login a user
 * tags: [Auth]
 * security: []
 * requestBody:
 * required: true
 * content:
 * application/json:
 * schema:
 * type: object
 * required:
 * - email
 * - password
 * properties:
 * email:
 * type: string
 * format: email
 * example: hero@test.com
 * password:
 * type: string
 * format: password
 * example: Password123!
 * responses:
 * 200:
 * description: Login successful
 * 401:
 * description: Invalid credentials
 */
/**
 * @swagger
 * /auth/access-token:
 * post:
 * summary: Refresh access token
 * description: Exchange a valid refresh token for a new access token pair.
 * tags: [Auth]
 * security: []
 * requestBody:
 * required: true
 * content:
 * application/json:
 * schema:
 * type: object
 * required:
 * - refreshToken
 * properties:
 * refreshToken:
 * type: string
 * example: eyJhbGciOiJIUzI1Ni...
 * responses:
 * 200:
 * description: Tokens refreshed successfully
 * content:
 * application/json:
 * schema:
 * type: object
 * properties:
 * accessToken:
 * type: string
 * refreshToken:
 * type: string
 * 400:
 * description: Validation error or missing token
 * 401:
 * description: Invalid or expired refresh token
 */

/**
 * Factory function to create authentication router with injected controller.
 *
 * @memberof module:routes/auth
 * @function createAuthRouter
 * @param {Object} authController - Authentication controller instance
 * @returns {Object} Express router with authentication routes
 */
const createAuthRouter = (authController) => {
  const router = express.Router();

  /**
   * @name POST /register
   * @description Register a new user account
   * @memberof module:routes/auth
   * @param {Object} req.body - Registration data
   * @param {string} req.body.username - Username (5-12 chars)
   * @param {string} req.body.email - Valid email address
   * @param {string} req.body.password - Password (min 10 chars)
   * @param {string} req.body.confirmPassword - Password confirmation
   * @returns {Object} 201 - User registered with tokens
   * @returns {Object} 400 - Validation errors
   */
  router.post("/register", registerValidator, authController.registerUser);

  /**
   * @name POST /login
   * @description Authenticate existing user
   * @memberof module:routes/auth
   * @param {Object} req.body - Login credentials
   * @param {string} req.body.email - User email
   * @param {string} req.body.password - User password
   * @returns {Object} 200 - User authenticated with tokens
   * @returns {Object} 400 - Validation errors
   * @returns {Object} 401 - Invalid credentials
   */
  router.post("/login", loginValidator, authController.loginUser);

  /**
   * @name POST /access-token
   * @description Refresh user session with new tokens
   * @memberof module:routes/auth
   * @param {Object} req.body - Token refresh data
   * @param {string} req.body.refreshToken - Valid refresh token
   * @returns {Object} 200 - New token pair generated
   * @returns {Object} 400 - Validation errors
   * @returns {Object} 401 - Invalid or expired token
   */
  router.post(
    "/access-token",
    refreshTokenValidator,
    authController.getNewAccessToken
  );

  return router;
};

module.exports = createAuthRouter;
