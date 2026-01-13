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
  private config: AuthConfig;

  constructor({ userRepo, tokenRepo, tokenService, config }: IAuthServiceDeps) {
    this.userRepo = userRepo;
    this.tokenRepo = tokenRepo;
    this.tokenService = tokenService;
    this.config = config;
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
      throw new AppError("Username is required", 400);
    }
    if (!email) {
      throw new AppError("Email is required", 400);
    }
    if (!password) {
      throw new AppError("Password is required", 400);
    }

    const userExists: User | null =
      await this.userRepo.findUserByUsernameOrEmail(username, email);

    if (userExists) {
      if (userExists.email === email) {
        throw new AppError("Email already in use.", 400);
      } else {
        throw new AppError("Username already in use.", 400);
      }
    }

    const hashedPassword = await bcrypt.hash(password, this.config.saltRounds);

    const userData = { username, email, password: hashedPassword };
    const newUser = await this.userRepo.createUser(userData);

    const authResponse = await this.generateAuthResponse(newUser);

    return authResponse;
  }
  async loginUser(data: LoginRequest): Promise<AuthResponse> {
    const { email, password } = data;
    if (!email) {
      throw new AppError("Email is required.", 400);
    }
    if (!password) {
      throw new AppError("Password is required.", 400);
    }

    const user = await this.userRepo.findUserByEmail(email);
    if (!user) {
      throw new AppError("Invalid credentials.", 401);
    }

    const passwordMatch = await bcrypt.compare(password, user.password);
    if (!passwordMatch) {
      throw new AppError("Invalid credentials.", 401);
    }

    const authResponse = await this.generateAuthResponse(user);

    return authResponse;
  }
  async refreshUserSession(
    oldRefreshToken: RefreshTokenRequest
  ): Promise<AuthResponse> {
    if (!oldRefreshToken) {
      throw new AppError("Refresh token is required.", 400);
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
    await this.tokenRepo.deleteTokenById(storedToken.id);
    try {
      const decoded = this.tokenService.verifyRefreshToken(
        oldRefreshToken.refreshToken
      ) as TokenPayload;

      const user = await this.userRepo.findUserById(decoded.userId);

      if (user) {
        const authResponse = await this.generateAuthResponse(user);

        return authResponse;
      } else {
        throw new AppError("User is restricted", 401);
      }
    } catch (error) {
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
