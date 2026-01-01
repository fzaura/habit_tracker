export default class AppError extends Error {
  public readonly statusCode: number;
  public readonly status: string;
  public readonly isOperational: boolean;

  constructor(message: string, statusCode: number) {
    super(message);

    this.statusCode = statusCode;
    this.isOperational = true;
    this.status = statusCode >= 400 && statusCode < 500 ? "fail" : "error";

    Error.captureStackTrace(this, this.constructor);
  }
}
