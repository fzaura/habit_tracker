const express = require("express");
const { updateUserValidator } = require("../validators/user.validator");
const { authenticateJWT } = require("../middleware/auth.middleware");

const createUserRouter = (userController) => {
  const router = express.Router();
  router.use(authenticateJWT);

  router.patch("/me", updateUserValidator, userController.updateUser);

  return router;
};

module.exports = createUserRouter;
