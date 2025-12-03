const IUserRepo = require("./IUserRepository");
const UserModel = require("../models/user.models");

class MongooseUserRepository extends IUserRepo {
  async createUser(userData) {
    const newUser = await UserModel.create(userData);

    return newUser;
  }

  async findUserById(userId) {
    const user = await UserModel.findById(userId);

    return user;
  }

  async findUserByEmail(email) {
    const user = await UserModel.findOne({ email });

    return user;
  }

  async findUserByUsernameOrEmail(username, email) {
    const user = await UserModel.findOne({
      $or: [{ username }, { email }],
    });

    return user;
  }

  async findUserConflicts(userId, username, email) {
    const conflict = await UserModel.findOne({
      $or: [{ username }, { email }],
      _id: { $ne: userId },
    });

    return conflict;
  }

  async updateUser(userId, updateData) {
    const updatedUser = await UserModel.findByIdAndUpdate(
      userId,
      { $set: updateData },
      { new: true, runValidators: true }
    ).select("-password");

    return updatedUser;
  }
}

module.exports = MongooseUserRepository;
