const { validationResult } = require("express-validator");

const createUserController = (userService) => {
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
