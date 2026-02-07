import { Request, Response, NextFunction, RequestHandler } from "express";
import { plainToInstance } from "class-transformer";
import { validate, ValidationError } from "class-validator";
import AppError from "../utils/AppError";

/**
 * Validates the request body against a DTO Class.
 * @param type - The Class Constructor (e.g. RegisterUserRequest)
 * @param skipMissingProperties - (Optional) If true, ignores missing fields (useful for PATCH)
 */
export function validationMiddleware<T extends object>(
  type: new () => T,
  skipMissingProperties = false,
): RequestHandler {
  return async (req: Request, res: Response, next: NextFunction) => {
    const dtoObject = plainToInstance(type, req.body);

    const errors: ValidationError[] = await validate(dtoObject, {
      skipMissingProperties,
      whitelist: true,
      forbidNonWhitelisted: true,
    });

    // 3. Error Handling
    if (errors.length > 0) {
      // Create a readable error message from the validation array
      const message = errors
        .map((error: ValidationError) => {
          // Object.values gets the error strings from the constraints object
          return Object.values(error.constraints ?? {}).join(", ");
        })
        .join("; ");

      // Pass the error to your global error handler (400 Bad Request)
      next(new AppError(message, 400));
    } else {
      // 4. Success: Replace req.body with the sanitized, typed Class Instance
      req.body = dtoObject;
      next();
    }
  };
}
