const bcrypt = require("bcrypt");
const { generateTokens } = require("../utils/token");
const jwt = require("jsonwebtoken");

class AuthService {
  constructor(userRepository, tokenRepository) {
    this.userRepo = userRepository;
    this.tokenRepo = tokenRepository;
  }

  async registerUser(username, email, password) {
    if (!username) {
      throw new Error("Username is required");
    }
    if (!email) {
      throw new Error("Email is required");
    }
    if (!password) {
      throw new Error("Password is required");
    }

    const userExists = await this.userRepo.findUserByUsernameOrEmail(
      username,
      email
    );

    if (userExists) {
      if (userExists.email === email) {
        throw new Error("Email already in use.");
      } else {
        throw new Error("Username already in use.");
      }
    }

    const hashedPassword = await bcrypt.hash(
      password,
      parseInt(process.env.SALT_ROUNDS)
    );

    const userData = { username, email, password: hashedPassword };
    const newUser = await this.userRepo.createUser(userData);

    const { refreshToken, accessToken } = generateTokens(newUser);

    const newRefreshToken = await this.tokenRepo.createToken(
      newUser.id,
      refreshToken
    );

    return { newUser, accessToken, refreshToken };
  }

  async loginUser(email, password) {
    if (!email) {
      throw new Error("Email is required.");
    }
    if (!password) {
      throw new Error("Password is required.");
    }

    const user = await this.userRepo.findUserByEmail(email);
    if (!user) {
      throw new Error("Invalid credentials.");
    }

    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      throw new Error("Invalid credentials.");
    }

    const { refreshToken, accessToken } = generateTokens(user);

    const newRefreshToken = await this.tokenRepo.createToken(
      user.id,
      refreshToken
    );

    return { user, accessToken, refreshToken };
  }

  async refreshUserSession(oldRefreshToken) {
    if (!oldRefreshToken) {
      throw new Error("Refresh token is required.");
    }

    const storedToken = await this.tokenRepo.findTokenByValue(oldRefreshToken);
    if (!storedToken) {
      throw new Error("Token has been revoked or previously used.");
    }
    try {
      const decoded = jwt.verify(
        oldRefreshToken,
        process.env.JWT_REFRESH_SECRET
      );

      await this.tokenRepo.deleteTokenById(storedToken.id);

      const user = { id: decoded.userId, username: decoded.username };

      const { refreshToken, accessToken } = generateTokens(user);

      const newRefreshToken = await this.tokenRepo.createToken(
        user.id,
        refreshToken
      );

      return { accessToken, refreshToken };
    } catch (error) {
      if (
        error.name === "TokenExpiredError" ||
        error.name === "JsonWebTokenError"
      ) {
        await this.tokenRepo.deleteTokenById(storedToken.id);
        throw new Error("Token has been revoked or expired.");
      }
    }
  }
}

module.exports = AuthService;
