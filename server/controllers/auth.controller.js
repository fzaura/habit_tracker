const { validationResult } = require("../validators/auth.validator");

const createAuthController = (authService) => {
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
