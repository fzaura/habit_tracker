const bcrypt = require("bcrypt");

class UserService {
  constructor(userRepository) {
    this.userRepo = userRepository;
  }

  async updateUser(userId, updateData) {
    const safeUpdates = {};

    if (updateData.username) {
      safeUpdates.username = updateData.username;
    }

    if (updateData.email) {
      safeUpdates.email = updateData.email;
    }

    if (updateData.password) {
      safeUpdates.password = updateData.password;
    }

    if (safeUpdates.email || safeUpdates.username) {
      const userConflicts = await this.userRepo.findUserConflicts(
        userId,
        safeUpdates.username,
        safeUpdates.email
      );

      if (userConflicts) {
        if (userConflicts.email === safeUpdates.email) {
          throw new Error("Email already in use.");
        } else {
          throw new Error("Username already in use.");
        }
      }
    }

    if (updateData.password) {
      const hashedPassword = await bcrypt.hash(
        safeUpdates.password,
        parseInt(process.env.SALT_ROUNDS)
      );
      safeUpdates.password = hashedPassword;
    }

    const updatedUser = await this.userRepo.updateUser(userId, safeUpdates);

    return updatedUser;
  }
}
