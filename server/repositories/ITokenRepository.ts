import { RefreshToken } from "@prisma/client";

export interface ITokenRepository {
  createToken(
    userId: string,
    token: string,
    expiresAt: Date,
  ): Promise<RefreshToken>;
  findTokenByValue(token: string): Promise<RefreshToken | null>;
  deleteTokenById(tokenId: string): Promise<RefreshToken>;
  deleteTokenByValue(token: string): Promise<RefreshToken>;
  deleteTokensByUserId(userId: string): Promise<number>;
}
