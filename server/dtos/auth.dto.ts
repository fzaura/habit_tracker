import { UserResponse } from "./user.dto";
import {
  IsEmail,
  IsString,
  Length,
  IsNotEmpty,
  MinLength,
  Matches,
} from "class-validator";
import { Match } from "../match.decorator";
import { Transform } from "class-transformer";

export class RegisterUserRequest {
  @IsNotEmpty()
  @IsString({ message: "Username must be a string." })
  @Transform(({ value }) => value?.trim())
  @Length(3, 10, { message: "Username must be between 3 and 10 characters." })
  username!: string;

  @IsEmail({}, { message: "Invalid email address format." })
  @Transform(({ value }) => value?.trim())
  email!: string;

  @IsString()
  @MinLength(8, { message: "Password must be at least 8 characters long." })
  @Matches(/\d/, { message: "Password must contain at least one number." })
  @Matches(/[!@#$%^&*(),.?":{}|<>]/, {
    message: "Password must contain at least one special character.",
  })
  password!: string;

  @IsString()
  @IsNotEmpty({ message: "Confirm password is required." })
  @Match("password", { message: "Passwords do not match" })
  confirmPassword!: string;
}

export class LoginRequest {
  @IsEmail({}, { message: "Please provide a valid email." })
  @Transform(({ value }) => value?.trim())
  email!: string;

  @IsString()
  @IsNotEmpty({ message: "Password is required." })
  password!: string;
}

export class RefreshUserSessionRequest {
  @IsString()
  @IsNotEmpty({ message: "Refresh token is required." })
  refreshToken!: string;
}

export interface AuthResponse {
  user: UserResponse;
  accessToken: string;
  refreshToken: string;
}
