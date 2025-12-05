const express = require("express");

const {
  registerValidator,
  loginValidator,
  refreshTokenValidator,
} = require("../validators/auth.validator");

const createAuthRouter = (authController) => {
  const router = express.Router();

  router.post("/register", registerValidator, authController.registerUser);

  router.post("/login", loginValidator, authController.loginUser);

  router.post(
    "/access-token",
    refreshTokenValidator,
    authController.getNewAccessToken
  );

  return router;
};

module.exports = createAuthRouter;
