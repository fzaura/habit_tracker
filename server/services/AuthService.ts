// /**
//  * @fileoverview Authentication service handling user registration, login, and session refresh.
//  * Manages password hashing, token generation, and user authentication.
//  *
//  * @module services/AuthService
//  * @requires bcrypt
//  * @requires jsonwebtoken
//  * @requires ../utils/token
//  * @requires ../repositories/IUserRepository
//  * @requires ../repositories/ITokenRepository
//  */
// const bcrypt = require("bcrypt");

// /**
//  * Service class for authentication operations.
//  * Handles user registration, login, and token refresh logic.
//  *
//  * @class AuthService
//  */
// class AuthService {
//   /**
//    * Create an AuthService instance.
//    *
//    * @constructor
//    * @param {Object} userRepository - Repository for user data operations
//    * @param {Object} tokenRepository - Repository for token data operations
//    */
//   constructor({ userRepo, tokenRepo, tokenService, config }) {
//     this.userRepo = userRepo;
//     this.tokenRepo = tokenRepo;
//     this.tokenService = tokenService;

//     this.saltRounds = config.saltRounds;
//   }

//   /**
//    * Register a new user with hashed password and generate tokens.
//    * Checks for existing username/email before creating user.
//    *
//    * @async
//    * @function registerUser
//    * @param {string} username - Desired username (5-12 chars)
//    * @param {string} email - User email address
//    * @param {string} password - Plain text password (will be hashed)
//    * @returns {Promise<Object>} Object containing newUser, accessToken, and refreshToken
//    * @throws {Error} If username/email already exists or validation fails
//    */
//   async registerUser(username, email, password) {
// if (!username) {
//   throw new Error("Username is required");
// }
// if (!email) {
//   throw new Error("Email is required");
// }
// if (!password) {
//   throw new Error("Password is required");
// }

// const userExists = await this.userRepo.findUserByUsernameOrEmail(
//   username,
//   email
// );

// if (userExists) {
//   if (userExists.email === email) {
//     const error = new Error("Email already in use.");
//     error.status = 400;
//     throw error;
//   } else {
//     const error = new Error("Username already in use.");
//     error.status = 400;
//     throw error;
//   }
// }

// const hashedPassword = await bcrypt.hash(password, this.saltRounds);

// const userData = { username, email, password: hashedPassword };
// const newUser = await this.userRepo.createUser(userData);

// const accessToken = this.tokenService.generateAccessToken({
//   userId: newUser.id,
//   username: newUser.username,
// });

// const refreshToken = this.tokenService.generateRefreshToken({
//   userId: newUser.id,
//   username: newUser.username,
// });

// const sevenDays = 7 * 24 * 60 * 60 * 1000;
// const expiresAt = Date.now() + sevenDays;

// const newRefreshToken = await this.tokenRepo.createToken(
//   newUser.id,
//   refreshToken,
//   expiresAt
// );

// return { newUser, accessToken, refreshToken };
//   }

//   /**
//    * Authenticate user with email and password, generate new tokens.
//    * Validates credentials and creates new session tokens.
//    *
//    * @async
//    * @function loginUser
//    * @param {string} email - User email address
//    * @param {string} password - Plain text password
//    * @returns {Promise<Object>} Object containing user, accessToken, and refreshToken
//    * @throws {Error} If credentials are invalid
//    */
//   async loginUser(email, password) {
// if (!email) {
//   throw new Error("Email is required.");
// }
// if (!password) {
//   throw new Error("Password is required.");
// }

// const user = await this.userRepo.findUserByEmail(email);
// if (!user) {
//   const error = new Error("Invalid credentials.");
//   error.status = 401;
//   throw error;
// }

// const passwordMatch = await bcrypt.compare(password, user.password);
// if (!passwordMatch) {
//   const error = new Error("Invalid credentials.");
//   error.status = 401;
//   throw error;
// }

// const accessToken = this.tokenService.generateAccessToken({
//   userId: user.id,
//   username: user.username,
// });

// const refreshToken = this.tokenService.generateRefreshToken({
//   userId: user.id,
//   username: user.username,
// });

// const sevenDays = 7 * 24 * 60 * 60 * 1000;
// const expiresAt = Date.now() + sevenDays;

// const newRefreshToken = await this.tokenRepo.createToken(
//   user.id,
//   refreshToken,
//   expiresAt
// );

// return { user, accessToken, refreshToken };
//   }

//   /**
//    * Refresh user session using a valid refresh token.
//    * Verifies old token, revokes it, and generates new token pair.
//    *
//    * @async
//    * @function refreshUserSession
//    * @param {string} oldRefreshToken - Current valid refresh token
//    * @returns {Promise<Object>} Object containing new accessToken and refreshToken
//    * @throws {Error} If token is invalid, expired, or revoked
//    */
//   async refreshUserSession(oldRefreshToken) {
// if (!oldRefreshToken) {
//   throw new Error("Refresh token is required.");
// }

// const storedToken = await this.tokenRepo.findTokenByValue(oldRefreshToken);
// if (!storedToken) {
//   throw new Error("Token has been revoked or previously used.");
// }

// if (new Date() > storedToken.expiresAt) {
//   await this.tokenRepo.deleteTokenById(storedToken.id);
//   throw new Error("Token is expired.");
// }
// try {
//   const decoded = this.tokenService.verifyRefreshToken(oldRefreshToken);

//   await this.tokenRepo.deleteTokenById(storedToken.id);

//   const user = { id: decoded.userId, username: decoded.username };

//   const accessToken = this.tokenService.generateAccessToken({
//     userId: user.id,
//     username: user.username,
//   });

//   const refreshToken = this.tokenService.generateRefreshToken({
//     userId: user.id,
//     username: user.username,
//   });

//   const sevenDays = 7 * 24 * 60 * 60 * 1000;
//   const expiresAt = Date.now() + sevenDays;

//   const newRefreshToken = await this.tokenRepo.createToken(
//     user.id,
//     refreshToken,
//     expiresAt
//   );

//   return { accessToken, refreshToken };
// } catch (error) {
//   if (
//     error.name === "TokenExpiredError" ||
//     error.name === "JsonWebTokenError"
//   ) {
//     await this.tokenRepo.deleteTokenById(storedToken.id);
//     error.status = 403;
//     error.message = error.message;
//     throw error;
//   }
// }
//   }
// }

// module.exports = AuthService;

import bcrypt from "bcrypt";
import {
  AuthResponse,
  LoginRequest,
  RefreshTokenRequest,
} from "../dtos/auth.dto";
import { IAuthService } from "./IAuthService";
import { IAuthServiceDeps } from "./IAuthService";
import { CreateUserRequest } from "../dtos/user.dto";
import { IUserRepository } from "../repositories/IUserRepository";
import { ITokenRepository } from "../repositories/ITokenRepository";
import TokenService from "./TokenService";
import { AuthConfig } from "../types/Config";
import { User } from "../models/User";
import AppError from "../utils/AppError";
import { toUserResponse } from "../dtos/user.dto";

interface TokenPayload {
  userId: string;
  username: string;
}

export default class AuthService implements IAuthService {
  private userRepo: IUserRepository;
  private tokenRepo: ITokenRepository;
  private tokenService: TokenService;
  private saltRounds: number;

  constructor({ userRepo, tokenRepo, tokenService, config }: IAuthServiceDeps) {
    this.userRepo = userRepo;
    this.tokenRepo = tokenRepo;
    this.tokenService = tokenService;
    this.saltRounds = config.saltRounds;
  }

  private async generateAuthResponse(user: User): Promise<AuthResponse> {
    const accessToken = this.tokenService.generateAccessToken({
      userId: user.id,
      username: user.username,
    });

    const refreshToken = this.tokenService.generateRefreshToken({
      userId: user.id,
      username: user.username,
    });

    const sevenDays = 7 * 24 * 60 * 60 * 1000;
    const expiresAt = new Date(Date.now() + sevenDays);

    const savedRefreshToken = await this.tokenRepo.createToken(
      user.id,
      refreshToken,
      expiresAt
    );

    const safeUser = toUserResponse(user);

    return { user: safeUser, accessToken, refreshToken };
  }

  async registerUser(data: CreateUserRequest): Promise<AuthResponse> {
    const { username, email, password } = data;

    if (!username) {
      throw new Error("Username is required");
    }
    if (!email) {
      throw new Error("Email is required");
    }
    if (!password) {
      throw new Error("Password is required");
    }

    const userExists: User | null =
      await this.userRepo.findUserByUsernameOrEmail(username, email);

    if (userExists) {
      if (userExists.email === email) {
        throw new AppError("Email already in use.", 400);
      } else {
        throw new AppError("username already in use.", 400);
      }
    }

    const hashedPassword = await bcrypt.hash(password, this.saltRounds);

    const userData = { username, email, password: hashedPassword };
    const newUser = await this.userRepo.createUser(userData);

    const authResponse = this.generateAuthResponse(newUser);

    return authResponse;
  }
  async loginUser(data: LoginRequest): Promise<AuthResponse> {
    const { email, password } = data;
    if (!email) {
      throw new Error("Email is required.");
    }
    if (!password) {
      throw new Error("Password is required.");
    }

    const user = await this.userRepo.findUserByEmail(email);
    if (!user) {
      throw new AppError("Invalid credentials.", 401);
    }

    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      throw new AppError("Invalid credentials.", 401);
    }

    const authResponse = this.generateAuthResponse(user);

    return authResponse;
  }
  async refreshUserSession(
    oldRefreshToken: RefreshTokenRequest
  ): Promise<AuthResponse> {
    if (!oldRefreshToken) {
      throw new Error("Refresh token is required.");
    }

    const storedToken = await this.tokenRepo.findTokenByValue(
      oldRefreshToken.refreshToken
    );
    if (!storedToken) {
      throw new AppError("Token has been revoked or previously used.", 403);
    }

    if (new Date() > storedToken.expiresAt) {
      await this.tokenRepo.deleteTokenById(storedToken.id);
      throw new AppError("Token is expired.", 403);
    }
    try {
      const decoded = this.tokenService.verifyRefreshToken(
        oldRefreshToken.refreshToken
      ) as TokenPayload;

      await this.tokenRepo.deleteTokenById(storedToken.id);

      const user = await this.userRepo.findUserById(decoded.userId);

      if (user) {
        const authResponse = this.generateAuthResponse(user);

        return authResponse;
      } else {
        throw new AppError("User is restricted", 401);
      }
    } catch (error) {
      if (storedToken) {
        await this.tokenRepo.deleteTokenById(storedToken.id);
      }
      if (error instanceof Error) {
        if (
          error.name === "TokenExpiredError" ||
          error.name === "JsonWebTokenError"
        ) {
          throw new AppError("Invalid or expired session", 403);
        }
      }

      throw error;
    }
  }
}
