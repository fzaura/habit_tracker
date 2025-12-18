const jwt = require("jsonwebtoken");

class TokenService {
  constructor({ config }) {
    this.jwtAccessSecret = config.jwtAccessSecret;
    this.jwtRefreshSecret = config.jwtRefreshSecret;
  }

  generateAccessToken(payload) {
    return jwt.sign(payload, this.jwtAccessSecret, { expiresIn: "15m" });
  }

  generateRefreshToken(payload) {
    return jwt.sign(payload, this.jwtRefreshSecret, { expiresIn: "7d" });
  }

  verifyAccessToken(token) {
    return jwt.verify(token, this.jwtAccessSecret);
  }

  verifyRefreshToken(token) {
    return jwt.verify(token, this.jwtRefreshSecret);
  }
}

module.exports = TokenService;
