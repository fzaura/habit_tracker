import { IUserRepository } from "../repositories/IUserRepository";
import { ITokenRepository } from "../repositories/ITokenRepository";
import TokenService from "./TokenService";
import { AuthConfig } from "../types/Config";
import { AuthResponse } from "../dtos/auth.dto";

export interface IAuthService {
  registerUser(
    username: string,
    email: string,
    password: string
  ): Promise<AuthResponse>;
  loginUser(email: string, password: string): Promise<AuthResponse>;
  refreshUserSession(oldRefreshToken: string): Promise<AuthResponse>;
}

export type IAuthServiceDeps = {
  userRepo: IUserRepository;
  tokenRepo: ITokenRepository;
  tokenService: TokenService;
  config: AuthConfig;
};
