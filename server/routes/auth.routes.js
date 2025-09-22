const express = require("express");
const router = express.Router();

const authController = require("../controllers/auth.controller");
const {
  registerValidator,
  loginValidator,
  updateUserValidator,
  refreshTokenValidator,
} = require("../validators/auth.validator");
const { authenticateJWT } = require("../middleware/auth.middleware");

router.post("/register", registerValidator, authController.registerUser);

router.post("/login", loginValidator, authController.loginUser);

router.post(
  "/access-token",
  refreshTokenValidator,
  authController.getNewAccessToken
);

router.put(
  "/update-user",
  authenticateJWT,
  updateUserValidator,
  authController.updateUser
);

module.exports = router;
