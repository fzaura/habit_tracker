/**
 * @type {import('@prisma/client').PrismaClient}
 */
const IUserRepo = require("./IUserRepository");

class PrismaUserRepository extends IUserRepo {
  constructor({ db }) {
    super();
    this.db = db;
  }
  async createUser(userData) {
    const newUser = await this.db.user.create({
      data: {
        username: userData.username,
        email: userData.email,
        password: userData.password,
      },
    });

    return newUser;
  }

  async findUserById(userId) {
    const user = await this.db.user.findUnique({ where: { id: userId } });

    return user;
  }

  async findUserByEmail(email) {
    const user = await this.db.user.findUnique({ where: { email } });
    return user;
  }

  async findUserByUsernameOrEmail(username, email) {
    const user = await this.db.user.findFirst({
      where: { OR: [{ username }, { email }] },
    });

    return user;
  }

  async findUserConflicts(userId, username, email) {
    const conflict = await this.db.user.findFirst({
      where: {
        AND: [{ OR: [{ username }, { email }] }, { NOT: { id: userId } }],
      },
    });
    return conflict;
  }

  async updateUser(userId, updateData) {
    const updatedUser = await this.db.user.update({
      where: { id: userId },
      data: {
        email: updateData.email || undefined,
        username: updateData.username || undefined,
        password: updateData.password || undefined,
      },
    });

    return updatedUser;
  }
}

module.exports = PrismaUserRepository;
