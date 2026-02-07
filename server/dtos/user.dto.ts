import { User } from "@prisma/client";
import {
  IsEmail,
  IsString,
  Length,
  IsNotEmpty,
  IsOptional,
  MinLength,
  Matches,
  ValidateIf,
} from "class-validator";
import { Match } from "../match.decorator";
import { Transform } from "class-transformer";

export class UpdateUserRequest {
  @IsOptional()
  @IsString({ message: "Username must be a string." })
  @Transform(({ value }) => value?.trim())
  @Length(3, 10, { message: "Username must be between 3 and 10 characters." })
  username?: string;

  @IsOptional()
  @IsEmail({}, { message: "Invalid email address format." })
  @Transform(({ value }) => value?.trim())
  email?: string;

  @IsOptional()
  @IsString()
  @MinLength(8, { message: "Password must be at least 8 characters long." })
  @Matches(/\d/)
  @Matches(/[!@#$%^&*(),.?":{}|<>]/)
  password?: string;

  @ValidateIf((o) => o.password)
  @IsString()
  @IsNotEmpty({ message: "Confirm password is required." })
  @Match("password", { message: "Passwords do not match" })
  confirmPassword!: string;
}

export interface UserResponse {
  id: string;
  username: string;
  email: string;
  createdAt: Date;
  updatedAt: Date;
}

export const toUserResponse = (user: User): UserResponse => {
  return {
    id: user.id,
    username: user.username,
    email: user.email,
    createdAt: user.createdAt,
    updatedAt: user.updatedAt,
  };
};
