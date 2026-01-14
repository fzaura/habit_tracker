import { IUserRepository } from "../repositories/IUserRepository";
import { ITokenRepository } from "../repositories/ITokenRepository";
import TokenService from "./TokenService";
import { AuthConfig } from "../types/Config";
import { AuthResponse } from "../dtos/auth.dto";
import { CreateUserRequest } from "../dtos/user.dto";
import { LoginRequest } from "../dtos/auth.dto";
import { RefreshUserSessionRequest } from "../dtos/auth.dto";

export interface IAuthService {
  registerUser(data: CreateUserRequest): Promise<AuthResponse>;
  loginUser(data: LoginRequest): Promise<AuthResponse>;
  refreshUserSession(
    tokenPayload: RefreshUserSessionRequest
  ): Promise<AuthResponse>;
}

export type IAuthServiceDeps = {
  userRepo: IUserRepository;
  tokenRepo: ITokenRepository;
  tokenService: TokenService;
  config: AuthConfig;
};
