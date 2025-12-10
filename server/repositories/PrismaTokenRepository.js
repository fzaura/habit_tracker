/**
 * @type {import('@prisma/client').PrismaClient}
 */
const prisma = require("../config/prisma");
const ITokenRepo = require("./ITokenRepository");

class PrismaTokenRepository extends ITokenRepo {
  async createToken(userId, tokenValue) {
    const token = await prisma.refreshToken.create({
      data: { userId, value: tokenValue },
    });

    return token;
  }

  async findTokenByValue(tokenValue) {
    const token = await prisma.refreshToken.findFirst({
      where: { value: tokenValue },
    });

    return token;
  }

  async deleteTokenById(tokenId) {
    const token = await prisma.refreshToken.deleteMany({
      where: { id: tokenId },
    });

    return token;
  }

  async deleteTokensByUserId(userId) {
    const deletedCount = await prisma.refreshToken.deleteMany({
      where: { userId },
    });

    return deletedCount;
  }
}

module.exports = PrismaTokenRepository;
