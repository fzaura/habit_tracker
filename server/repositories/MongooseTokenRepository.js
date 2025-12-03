const ITokenRepo = require("./ITokenRepository");
const TokenModel = require("../models/refreshToken.model");

class MongooseTokenRepository extends ITokenRepo {
  async createToken(userId, tokenValue) {
    const refreshToken = await TokenModel.create({ value: tokenValue, userId });

    return refreshToken;
  }
  async findTokenByValue(tokenValue) {
    const refreshToken = await TokenModel.findOne({ value: tokenValue });

    return refreshToken;
  }

  async deleteTokenById(TokenId) {
    const deletedToken = await TokenModel.findByIdAndDelete(TokenId);
    return deletedToken;
  }

  async deleteTokensByUserId(userId) {
    const deletedTokensCount = await TokenModel.deleteMany({ userId: userId });

    return deletedTokensCount;
  }
}

module.exports = MongooseTokenRepository;
