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
require("dotenv").config();
const express = require("express");
const prisma = require("./config/prisma");
const mongoose = require("mongoose");
const helmet = require("helmet");
const swaggerUi = require("swagger-ui-express");
const YAML = require("yamljs");
const { scopePerRequest } = require("awilix-express");
const container = require("./container");

const createAuthRouter = require("./routes/auth.routes");
const createHabitRouter = require("./routes/habit.routes");
const createUserRouter = require("./routes/user.routes");

const habitRouter = createHabitRouter(habitController);

const authRouter = createAuthRouter(authController);

const userRouter = createUserRouter(userController);

const app = express();
const PORT = process.env.PORT || 3000;
const DATABASE_URL = process.env.DATABASE_URL;
const DB_NAME = process.env.DB_NAME;

app.use(helmet());
app.use(express.json());
app.use(scopePerRequest(container));

const swaggerDocument = YAML.load("./swagger.yaml");
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

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

/*
if (require.main === module) {
  mongoose
    .connect(DATABASE_URL, { dbName: DB_NAME })
    .then(() => {
      console.log("Successfully connected to the database via mongoose.");
      app.listen(PORT, () => {
        console.log(
          `Server is running on https://habit-tracker-19q1.onrender.com/`
        );
      });
    })
    .catch((err) => {
      console.error("Database connection error: ", err);
      process.exit(1);
    });
}
    */

if (require.main === module) {
  prisma
    .$connect()
    .then(() => {
      console.log("Successfully connected to the database via prisma.");
      app.listen(PORT, () => {
        console.log(
          `Server is running on https://habit-tracker-19q1.onrender.com/`
        );
      });
    })
    .catch((err) => {
      console.error("Database connection error: ", err);
      process.exit(1);
    });
}
