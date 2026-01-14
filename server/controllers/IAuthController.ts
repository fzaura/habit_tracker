import { IAuthService } from "../services/IAuthService";
import { Request, Response, NextFunction } from "express";
import {
  RegisterRequest,
  LoginRequest,
  RefreshUserSessionRequest,
  AuthResponse,
} from "../dtos/auth.dto";

export interface IAuthController {
  registerUser(
    req: Request<{}, AuthResponse, RegisterRequest>,
    res: Response<AuthResponse>,
    next: NextFunction
  ): Promise<void | Response>;

  loginUser(
    req: Request<{}, AuthResponse, LoginRequest>,
    res: Response<AuthResponse>,
    next: NextFunction
  ): Promise<void | Response>;

  refreshUserSession(
    req: Request<{}, AuthResponse, RefreshUserSessionRequest>,
    res: Response<AuthResponse>,
    next: NextFunction
  ): Promise<void | Response>;
}

export interface IAuthControllerDeps {
  authService: IAuthService;
}
