/**
 * @type {import('@prisma/client').PrismaClient}
 */
const prisma = require("../config/prisma");
const IUserRepo = require("./IUserRepository");

class PrismaUserRepository extends IUserRepo {
  async createUser(userData) {
    const newUser = await prisma.user.create({
      data: {
        username: userData.username,
        email: userData.email,
        password: userData.password,
      },
    });

    return newUser;
  }

  async findUserById(userId) {
    const user = await prisma.user.findUnique({ where: { id: userId } });

    return user;
  }

  async findUserByEmail(email) {
    const user = await prisma.user.findUnique({ where: { email } });
    return user;
  }

  async findUserByUsernameOrEmail(username, email) {
    const user = await prisma.user.findFirst({
      where: { OR: [{ username }, { email }] },
    });

    return user;
  }

  async findUserConflicts(userId, username, email) {
    const conflict = await prisma.user.findFirst({
      where: {
        AND: [{ OR: [{ username }, { email }] }, { NOT: { id: userId } }],
      },
    });
    return conflict;
  }

  async updateUser(userId, updateData) {
    const updatedUser = await prisma.user.update({
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
