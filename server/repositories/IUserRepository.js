class IUserRepository {
  createUser(userData) {
    throw new Error("Method not implemented.");
  }

  findUserById(userId) {
    throw new Error("Method not implemented.");
  }

  findUserByEmail(email) {
    throw new Error("Method not implemented");
  }

  findUserByUsernameOrEmail(username, email) {
    throw new Error("Method not implemented");
  }

  findUserConflicts(userId, username, email) {
    throw new Error("Method not implemented");
  }

  updateUser(userId, updateData) {
    throw new Error("Method not implemented.");
  }
}

module.exports = IUserRepository;
