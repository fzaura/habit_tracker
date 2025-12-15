/**
 * @fileoverview User profile controller handling user account updates.
 * Processes user profile modification requests.
 *
 * @module controllers/user
 * @requires express-validator
 * @requires ../services/UserService
 */
const { validationResult } = require("express-validator");

/**
 * Factory function to create user controller with injected dependencies.
 *
 * @memberof module:controllers/user
 * @function createUserController
 * @param {Object} userService - Instance of UserService for handling user operations
 * @returns {Object} Object containing controller methods: updateUser
 */
const createUserController = ({ userService }) => {
  /**
   * Update the authenticated user's profile information.
   * Validates input and ensures username/email uniqueness.
   *
   * @async
   * @function updateUser
   * @param {Object} req - Express request object
   * @param {Object} req.user - Authenticated user from JWT
   * @param {string} req.user.userId - User ID
   * @param {Object} req.body - Request body with fields to update
   * @param {string} [req.body.email] - New email address
   * @param {string} [req.body.username] - New username
   * @param {string} [req.body.password] - New password
   * @param {Object} res - Express response object
   * @param {Function} next - Express next middleware function
   * @returns {Promise<void>} JSON response with updated user data
   */
  const updateUser = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const userId = req.user.userId;
    const { email, username, password } = req.body;

    try {
      const user = await userService.updateUser(userId, {
        email,
        username,
        password,
      });

      return res
        .status(200)
        .json({ message: "User updated successfully.", user });
    } catch (error) {
      next(error);
    }
  };

  return { updateUser };
};

module.exports = createUserController;
