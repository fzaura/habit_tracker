/**
 * @fileoverview Main server application file for the Habit Tracker API.
 * Sets up Express server, database connection, middleware, and routes.
 *
 * @module server
 * @requires express
 * @requires mongoose
 * @requires helmet
 * @requires dotenv
 *
 * Environment Variables Required:
 * - DATABASE_URL: MongoDB connection string
 * - DB_NAME: Database name
 * - PORT: Server port (optional, defaults to 3000)
 * - JWT_SECRET: Secret for signing access tokens
 * - JWT_REFRESH_SECRET: Secret for signing refresh tokens
 * - SALT_ROUNDS: Number of rounds for bcrypt hashing
 */
const express = require("express");
const mongoose = require("mongoose");
const helmet = require("helmet");

const MongooseTokenRepo = require("./repositories/MongooseTokenRepository");
const MongooseUserRepo = require("./repositories/MongooseUserRepository");
const AuthService = require("./services/AuthService");
const createAuthController = require("./controllers/auth.controller");
const createAuthRouter = require("./routes/auth.routes");

const MongooseHabitRepo = require("./repositories/MongooseHabitRepository");
const HabitService = require("./services/HabitService");
const createHabitController = require("./controllers/habit.controller");
const createHabitRouter = require("./routes/habit.routes");

const UserService = require("./services/UserService");
const createUserController = require("./controllers/user.controller");
const createUserRouter = require("./routes/user.routes");

require("dotenv").config();

const habitRepo = new MongooseHabitRepo();
const habitService = new HabitService(habitRepo);
const habitController = createHabitController(habitService);
const habitRouter = createHabitRouter(habitController);

const userRepo = new MongooseUserRepo();
const tokenRepo = new MongooseTokenRepo();
const authService = new AuthService(userRepo, tokenRepo);
const authController = createAuthController(authService);
const authRouter = createAuthRouter(authController);

const userService = new UserService(userRepo);
const userController = createUserController(userService);
const userRouter = createUserRouter(userController);

const app = express();
const PORT = process.env.PORT || 3000;
const DATABASE_URL = process.env.DATABASE_URL;
const DB_NAME = process.env.DB_NAME;

app.use(helmet());
app.use(express.json());

app.use("/api/auth", authRouter);
app.use("/api/habits", habitRouter);
app.use("/api/users", userRouter);

/**
 * Global error handler middleware.
 * Catches and handles all unhandled errors in the application.
 *
 * @param {Error} err - Error object
 * @param {Object} req - Express request object
 * @param {Object} res - Express response object
 * @param {Function} next - Express next function
 */
app.use((err, req, res, next) => {
  console.error(err.stack);
  const status = err.status || 500;
  res
    .status(status)
    .json({ message: err.message || "An internal server error has occurred." });
});

module.exports = app;
if (require.main === module) {
  mongoose
    .connect(DATABASE_URL, { dbName: DB_NAME })
    .then(() => {
      console.log("Successfully connected to the database.");
      app.listen(PORT, () => {
        console.log(`Server is running on http://localhost:${PORT}`);
      });
    })
    .catch((err) => {
      console.error("Database connection error: ", err);
      process.exit(1);
    });
}
