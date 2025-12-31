import { PrismaClient } from "@prisma/client";
import { ITokenRepository } from "./ITokenRepository";
import { RefreshToken } from "../models/RefreshToken";

type PrismaRepoDeps = {
  db: PrismaClient;
};

export default class PrismaTokenRepository implements ITokenRepository {
  private db: PrismaClient;

  constructor({ db }: PrismaRepoDeps) {
    this.db = db;
  }

  async createToken(
    userId: string,
    token: string,
    expiresAt: Date
  ): Promise<RefreshToken> {
    return await this.db.refreshToken.create({
      data: { userId, value: token, expiresAt },
    });
  }

  async findTokenByValue(token: string): Promise<RefreshToken | null> {
    return await this.db.refreshToken.findUnique({ where: { value: token } });
  }

  async deleteTokenByValue(token: string): Promise<RefreshToken> {
    return await this.db.refreshToken.delete({ where: { value: token } });
  }

  async deleteTokensByUserId(userId: string): Promise<number> {
    return (await this.db.refreshToken.deleteMany({ where: { userId } })).count;
  }
}
