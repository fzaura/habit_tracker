const bcrypt = require("bcrypt");
const User = require("../models/user.models");
const RefreshToken = require("../models/refreshToken.model");

const { validationResult } = require("express-validator");
const {
  registerValidator,
  loginValidator,
} = require("../validators/auth.validator");
const { generateTokens } = require("../utils/token");

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const registerUser = async (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array });
  }

  const { username, email, password } = req.body;

  try {
    const existingUser = await User.findOne({ $or: [{ email }, { username }] });
    if (existingUser) {
      if (existingUser.email === email) {
        return res.status(409).json({ message: "Email already in use." });
      }

      return res.status(409).json({ message: "Username already in use." });
    }

    const hashedPassword = await bcrypt.hash(
      password,
      parseInt(process.env.SALT_ROUNDS)
    );

    const newUser = new User({ username, email, password: hashedPassword });
    await newUser.save();

    const { refreshToken, accessToken } = generateTokens(newUser);

    const newRefreshToken = new RefreshToken({
      value: refreshToken,
      userId: newUser._id,
    });
    await newRefreshToken.save();

    return res.status(201).json({
      message: "User registered successfully.",
      refreshToken,
      accessToken,
      user: { id: newUser._id, username: newUser.username },
    });
  } catch (error) {
    next(error);
  }
};

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const loginUser = async (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return res.status(409).json({ errors: errors.array });
  }

  const { email, password } = req.body;

  try {
    const user = User.findOne({ email });

    if (!user) {
      return res.status(401).json({ message: "Invalid credentials." });
    }

    const isMatched = await bcrypt.compare(password, user.password);
    if (!isMatched) {
      return res.status(401).json({ message: "Invalid credentials." });
    }

    const { refreshToken, accessToken } = generateTokens(user);

    const newRefreshToken = new RefreshToken({
      value: refreshToken,
      userId: user._id,
    });
    await newRefreshToken.save();

    return res.status(200).json({
      message: "User logged in successfully.",
      refreshToken,
      accessToken,
      user: { userId: user._id, username: user.username },
    });
  } catch (error) {
    next(error);
  }
};

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const updateUser = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const userId = req.user.userId;

  const { username, email, password } = req.body;

  try {
    if (username || email) {
      const existingUser = await User.findOne({
        $or: [{ username }, { email }],
        _id: { $ne: userId },
      });

      if (existingUser) {
        if (existingUser.username === username) {
          return res.status(409).json({ message: "Username already in use." });
        }

        return res.status(409).json({ message: "Email already in use." });
      }
    }

    const updateFields = {};
    if (username) updateFields.username = username;
    if (email) updateFields.email = email;

    if (password) {
      const saltRounds = parseInt(process.env.SALT_ROUNDS || 10);
      const hashedPassword = await bcrypt.hash(password, saltRounds);

      updateFields.password = hashedPassword;
    }

    if (Object.keys(updateFields).length === 0) {
      return res
        .status(400)
        .json({ message: "No update information provided." });
    }

    const updateUser = await User.findOneAndUpdate(
      { _id: userId },
      { $set: updateFields },
      { new: true, runValidators: true }
    ).select("-password");

    if (!updateUser) {
      return res.status(404).json({ message: "User not found." });
    }

    return res
      .status(200)
      .json({ message: "User info successfully updated.", user: updateUser });
  } catch (error) {
    next(error);
  }
};

module.exports = { registerUser, loginUser, updateUser };
