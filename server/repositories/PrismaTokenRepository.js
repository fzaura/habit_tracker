/**
 * @type {import('@prisma/client').PrismaClient}
 */
const ITokenRepo = require("./ITokenRepository");

class PrismaTokenRepository extends ITokenRepo {
  constructor({ db }) {
    super();
    this.db = db;
  }
  async createToken(userId, tokenValue, expiresAt) {
    const token = await this.db.refreshToken.create({
      data: {
        userId,
        value: tokenValue,
        expiresAt: new Date(expiresAt),
      },
    });

    return token;
  }

  async findTokenByValue(tokenValue) {
    const token = await this.db.refreshToken.findUnique({
      where: { value: tokenValue },
    });

    return token;
  }

  async deleteTokenById(tokenId) {
    const token = await this.db.refreshToken.deleteMany({
      where: { id: tokenId },
    });

    return token;
  }

  async deleteTokensByUserId(userId) {
    const deletedCount = await this.db.refreshToken.deleteMany({
      where: { userId },
    });

    return deletedCount;
  }
}

module.exports = PrismaTokenRepository;
