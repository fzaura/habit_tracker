//
// class PrismaUserRepository extends IUserRepo {
//   constructor({ db }) {
//     super();
//     this.db = db;
//   }

//   async createUser(userData) {
//     const newUser = await this.db.user.create({
//       data: {
//         username: userData.username,
//         email: userData.email,
//         password: userData.password,
//       },
//     });

//     return newUser;
//   }

//   async findUserById(userId) {
//     const user = await this.db.user.findUnique({ where: { id: userId } });

//     return user;
//   }

//   async findUserByEmail(email) {
//     const user = await this.db.user.findUnique({ where: { email } });
//     return user;
//   }

//   async findUserByUsernameOrEmail(username, email) {
//     const user = await this.db.user.findFirst({
//       where: { OR: [{ username }, { email }] },
//     });

//     return user;
//   }

//   async findUserConflicts(userId, username, email) {
//     const conflict = await this.db.user.findFirst({
//       where: {
//         AND: [{ OR: [{ username }, { email }] }, { NOT: { id: userId } }],
//       },
//     });
//     return conflict;
//   }

//   async updateUser(userId, updateData) {
//     const updatedUser = await this.db.user.update({
//       where: { id: userId },
//       data: {
//         email: updateData.email || undefined,
//         username: updateData.username || undefined,
//         password: updateData.password || undefined,
//       },
//     });

//     return updatedUser;
//   }
// }

import { PrismaClient } from "@prisma/client";
import { IUserRepository } from "./IUserRepository";
import { User } from "../models/user.models";
import { CreateUserRequest } from "../dtos/user.dto";

type PrismaRepoDeps = {
  db: PrismaClient;
};

export default class PrismaUserRepository implements IUserRepository {
  private db: PrismaClient;

  constructor({ db }: PrismaRepoDeps) {
    this.db = db;
  }

  async createUser(data: CreateUserRequest): Promise<User> {
    return await this.db.user.create({ data });
  }

  async findUserById(userId: string): Promise<User | null> {
    return await this.db.user.findUnique({ where: { id: userId } });
  }

  async findUserByEmail(email: string): Promise<User | null> {
    return await this.db.user.findUnique({ where: { email } });
  }

  async findUserByUsernameOrEmail(
    username: string,
    email: string
  ): Promise<User | null> {
    return await this.db.user.findFirst({
      where: { OR: [{ username }, { email }] },
    });
  }

  async findUserConflicts(
    userId: string,
    username: string,
    email: string
  ): Promise<User | null> {
    return await this.db.user.findFirst({
      where: {
        AND: [{ OR: [{ username }, { email }] }, { NOT: { id: userId } }],
      },
    });
  }

  async updateUser(
    userId: string,
    data: Partial<CreateUserRequest>
  ): Promise<User | null> {
    return this.db.user.update({
      where: { id: userId },
      data,
    });
  }
}
