/**
 * @module middleware/auth
 * @description JWT authentication middleware for protecting routes.
 */
const jwt = require("jsonwebtoken");

/**
 * JWT authentication middleware.
 * Verifies Bearer token in Authorization header and attaches user payload to req.user.
 *
 * @memberof module:middleware/auth
 * @function authenticateJWT
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 * @param {Function} next - Express next middleware function
 * @returns {void} Calls next() on success or sends 401/403 response on failure
 */
const authenticateJWT = (req, res, next) => {
  const authHeader = req.headers.authorization;
  const token = authHeader && authHeader.split(" ")[1];

  if (!token) {
    return res
      .status(401)
      .json({ message: "Access token is missing or invalid." });
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_ACCESS_SECRET);

    req.user = payload;

    next();
  } catch (error) {
    return res.status(403).json({ message: "Forbidden: Invalid token." });
  }
};

module.exports = { authenticateJWT };
