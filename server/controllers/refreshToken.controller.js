const jwt = require("jsonwebtoken");
const RefreshToken = require("../models/refreshToken.model");

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
exports.getNewAccessToken = async (req, res, next) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    return res.status(401).json({ message: "Refresh token is required." });
  }

  try {
    const storedToken = await RefreshToken.findOne({ value: refreshToken });

    if (!storedToken) {
      return res
        .status(403)
        .json({ message: "Refresh token is invalid or has been revoked." });
    }

    const decoded = jwt.verify(refreshToken, process.env.JWT_REFRESH_SECRET);

    await RefreshToken.findByIdAndDelete(storedToken._id);

    const payload = { userId: decoded.userId, username: decoded.username };

    const newAccessToken = jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: "15m",
    });
    const newRefreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET, {
      expiresIn: "7d",
    });

    await new RefreshToken({
      userId: decoded.userId,
      value: newRefreshToken,
    }).save();

    return res
      .status(200)
      .json({ accessToken: newAccessToken, refreshToken: newRefreshToken });
  } catch (error) {
    if (
      error.name === "TokenExpiredError" ||
      error.name === "JsonWebTokenError"
    ) {
      return res
        .status(403)
        .json({ message: "Refresh token is expired or invalid." });
    }

    next(error);
  }
};
