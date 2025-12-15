/**
 * @fileoverview Dependency injection container configuration using Awilix.
 * Configures and registers all application dependencies including repositories,
 * services, controllers, and database connections.
 *
 * @module container
 * @requires awilix
 * @requires ./config/prisma
 * @requires ./repositories/PrismaTokenRepository
 * @requires ./repositories/PrismaUserRepository
 * @requires ./repositories/PrismaHabitRepository
 * @requires ./services/AuthService
 * @requires ./services/HabitService
 * @requires ./services/UserService
 * @requires ./controllers/auth.controller
 * @requires ./controllers/habit.controller
 * @requires ./controllers/user.controller
 */
const {
  createContainer,
  asClass,
  asValue,
  Lifetime,
  asFunction,
} = require("awilix");

const prisma = require("./config/prisma");
const mongoose = require("mongoose");

const MongooseTokenRepo = require("./repositories/MongooseTokenRepository");
const MongooseUserRepo = require("./repositories/MongooseUserRepository");
const MongooseHabitRepo = require("./repositories/MongooseHabitRepository");

const PrismaTokenRepo = require("./repositories/PrismaTokenRepository");
const PrismaUserRepo = require("./repositories/PrismaUserRepository");
const PrismaHabitRepo = require("./repositories/PrismaHabitRepository");

const AuthService = require("./services/AuthService");
const HabitService = require("./services/HabitService");
const UserService = require("./services/UserService");

const createAuthController = require("./controllers/auth.controller");
const createHabitController = require("./controllers/habit.controller");
const createUserController = require("./controllers/user.controller");

/**
 * Awilix dependency injection container.
 * Registers all application dependencies with scoped lifetime.
 *
 * Registered dependencies:
 * - db: Prisma database client
 * - tokenRepo: Token repository (Prisma implementation)
 * - userRepo: User repository (Prisma implementation)
 * - habitRepo: Habit repository (Prisma implementation)
 * - authService: Authentication service
 * - habitService: Habit management service
 * - userService: User management service
 * - authController: Authentication controller factory
 * - habitController: Habit controller factory
 * - userController: User controller factory
 *
 * @constant {Object} container - Awilix DI container instance
 */
const container = createContainer();
container.register({
  db: asValue(prisma),

  tokenRepo: asClass(PrismaTokenRepo).scoped(),
  userRepo: asClass(PrismaUserRepo).scoped(),
  habitRepo: asClass(PrismaHabitRepo).scoped(),

  authService: asClass(AuthService).scoped(),
  habitService: asClass(HabitService).scoped(),
  userService: asClass(UserService).scoped(),

  authController: asFunction(createAuthController).scoped(),
  habitController: asFunction(createHabitController).scoped(),
  userController: asFunction(createUserController).scoped(),
});

/**
 * Awilix dependency injection container.
 * Configured with all application dependencies.
 * @constant {Object} container - Awilix DI container instance
 */
module.exports = container;
