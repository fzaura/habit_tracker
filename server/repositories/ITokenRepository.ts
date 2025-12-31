import { RefreshToken } from "../models/RefreshToken";

export interface ITokenRepository {
  createToken(
    userId: string,
    token: string,
    expiresAt: Date
  ): Promise<RefreshToken>;
  findTokenByValue(token: string): Promise<RefreshToken | null>;
  deleteTokenByValue(token: string): Promise<RefreshToken>;
  deleteTokensByUserId(userId: string): Promise<number>;
}
