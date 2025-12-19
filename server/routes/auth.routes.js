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

module.exports = ({ authController }) => {
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
