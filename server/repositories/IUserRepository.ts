import { User } from "@prisma/client";
import { CreateUserRequest } from "../dtos/user.dto";

export interface IUserRepository {
  createUser(data: CreateUserRequest): Promise<User>;
  findUserById(userId: string): Promise<User | null>;
  findUserByEmail(email: string): Promise<User | null>;
  findUserByUsernameOrEmail(
    username: string,
    email: string,
  ): Promise<User | null>;
  findUserConflicts(
    userId: string,
    username: string,
    email: string,
  ): Promise<User | null>;
  updateUser(
    userId: string,
    data: Partial<CreateUserRequest>,
  ): Promise<User | null>;
}
