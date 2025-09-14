const jwt = require("jsonwebtoken");

const generateTokens = (user) => {
  try {
    const payload = { userId: user._id, username: user.username };

    const accessToken = jwt.sign(payload, process.env.JWT_SECRET, {
      expiresIn: "15m",
    });

    const refreshToken = jwt.sign(payload, process.env.JWT_REFRESH_SECRET, {
      expiresIn: "7d",
    });

    return { refreshToken, accessToken };
  } catch (error) {
    console.log("Error generating tokens.");
    throw new Error("Could not generate tokens.");
  }
};
