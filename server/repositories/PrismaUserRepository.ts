import { PrismaClient, User } from "@prisma/client";
import { IUserRepository } from "./IUserRepository";
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
    email: string,
  ): Promise<User | null> {
    return await this.db.user.findFirst({
      where: { OR: [{ username }, { email }] },
    });
  }

  async findUserConflicts(
    userId: string,
    username: string,
    email: string,
  ): Promise<User | null> {
    return await this.db.user.findFirst({
      where: {
        AND: [{ OR: [{ username }, { email }] }, { NOT: { id: userId } }],
      },
    });
  }

  async updateUser(
    userId: string,
    data: Partial<CreateUserRequest>,
  ): Promise<User | null> {
    return this.db.user.update({
      where: { id: userId },
      data,
    });
  }
}
