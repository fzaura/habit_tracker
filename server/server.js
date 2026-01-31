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

const { sendErrorEmail } = require("./utils/emailService");
process.on("uncaughtException", async (err) => {
  console.log("Uncaught exception, shutting down.");
  console.log(err.name, err.message);

  await sendErrorEmail(err);
  process.exit(1);
});

const express = require("express");
const prisma = require("./config/prisma");
const helmet = require("helmet");
const swaggerUi = require("swagger-ui-express");
const YAML = require("yamljs");
const { scopePerRequest } = require("awilix-express");
const container = require("./container");

const app = express();
const PORT = process.env.PORT || 3000;

app.use(helmet());
app.use(express.json());
app.use(scopePerRequest(container));

const swaggerDocument = YAML.load("./swagger.yaml");
app.use("/api-docs", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const habitRoutes = container.resolve("habitRoutes");
const userRoutes = container.resolve("userRoutes");
const authRoutes = container.resolve("authRoutes");
app.use("/api/auth", authRoutes);
app.use("/api/habits", habitRoutes);
app.use("/api/users", userRoutes);

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
  console.error(err);
  const statusCode = err.statusCode || 500;
  const status = err.status || "error";
  const isOperational = err.isOperational || false;

  if (!isOperational) {
    sendErrorEmail(err);

    return res
      .status(500)
      .json({ status: "error", message: "something went wrong." });
  }
  return res.status(statusCode).json({ message: err.message });
});

module.exports = app;

let server;

if (require.main === module) {
  prisma
    .$connect()
    .then(() => {
      console.log("Successfully connected to the database via prisma.");
      server = app.listen(PORT, () => {
        console.log(
          `Server is running on https://habit-tracker-19q1.onrender.com/`,
        );
      });
    })
    .catch((err) => {
      console.error("Database connection error: ", err);
      process.exit(1);
    });
}

process.on("unhandledRejection", async (err) => {
  console.log("Unhandled rejection, shutting down.");
  console.log(err.name, err.message);

  await sendErrorEmail(err);
  if (server) {
    server.close(() => {
      process.exit(1);
    });
  } else {
    process.exit(1);
  }
});
