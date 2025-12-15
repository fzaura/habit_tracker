/**
 * @fileoverview User profile routes for account management.
 * Defines endpoints for user profile operations. All routes require authentication.
 *
 * @module routes/user
 * @requires express
 * @requires ../validators/user.validator
 * @requires ../middleware/auth.middleware
 * @requires ../controllers/user.controller
 */
const express = require("express");
const { updateUserValidator } = require("../validators/user.validator");
const { authenticateJWT } = require("../middleware/auth.middleware");

const router = express.Router();
router.use(authenticateJWT);

const { makeInvoker } = require("awilix-express");
const api = makeInvoker((container) => {
  return { controller: container.resolve("userController") };
});
/**
 * Factory function to create user router with injected controller.
 *
 * @memberof module:routes/user
 * @function createUserRouter
 * @param {Object} userController - User controller instance
 * @returns {Object} Express router with user routes
 */
/**
 * @name PATCH /me
 * @description Update authenticated user's profile
 * @memberof module:routes/user
 * @param {string} Authorization - Bearer token in header
 * @param {Object} req.body - Updated user data (all optional)
 * @param {string} [req.body.username] - New username (5-12 chars)
 * @param {string} [req.body.email] - New email address
 * @param {string} [req.body.password] - New password (min 10 chars)
 * @param {string} [req.body.confirmPassword] - Password confirmation
 * @returns {Object} 200 - User updated successfully
 * @returns {Object} 400 - Validation errors
 * @returns {Object} 401 - Authentication required
 * @returns {Object} 409 - Username/email already in use
 */
router.patch("/me", updateUserValidator, api("controller", "updateUser"));

module.exports = router;
