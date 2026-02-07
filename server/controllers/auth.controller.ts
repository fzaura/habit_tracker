import { Request, Response, NextFunction } from "express";
import {
  AuthResponse,
  LoginRequest,
  RefreshUserSessionRequest,
  RegisterUserRequest,
} from "../dtos/auth.dto";
import { IAuthController, IAuthControllerDeps } from "./IAuthController";
import { IAuthService } from "../services/IAuthService";

export default class AuthController implements IAuthController {
  private authService: IAuthService;

  constructor({ authService }: IAuthControllerDeps) {
    this.authService = authService;
  }
  async registerUser(
    req: Request<{}, AuthResponse, RegisterUserRequest>,
    res: Response<AuthResponse>,
    next: NextFunction,
  ): Promise<void | Response> {
    const { username, email, password } = req.body;

    try {
      const { user, accessToken, refreshToken } =
        await this.authService.registerUser({ username, email, password });

      return res.status(201).json({
        user,
        accessToken,
        refreshToken,
      });
    } catch (error) {
      next(error);
    }
  }

  async loginUser(
    req: Request<{}, AuthResponse, LoginRequest>,
    res: Response<AuthResponse>,
    next: NextFunction,
  ): Promise<void | Response> {
    const { email, password } = req.body;

    try {
      const { user, accessToken, refreshToken } =
        await this.authService.loginUser({ email, password });

      return res.status(200).json({
        user,
        accessToken,
        refreshToken,
      });
    } catch (error) {
      next(error);
    }
  }

  async refreshUserSession(
    req: Request<{}, AuthResponse, RefreshUserSessionRequest>,
    res: Response<AuthResponse>,
    next: NextFunction,
  ): Promise<void | Response> {
    try {
      const { user, refreshToken, accessToken } =
        await this.authService.refreshUserSession(req.body);

      return res.status(200).json({
        user,
        refreshToken,
        accessToken,
      });
    } catch (error) {
      next(error);
    }
  }
}
