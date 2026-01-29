/**
 * @fileoverview Dependency injection container configuration using Awilix.
 * Configures and registers all application dependencies including repositories,
 * services, controllers, and database connections.
 */
const { createContainer, asClass, asValue, asFunction } = require("awilix");
const config = require("./config/env");
const prisma = require("./config/prisma");

// ESM Imports (Need .default)
import PrismaTokenRepository from "./repositories/PrismaTokenRepository.ts";
import PrismaUserRepository from "./repositories/PrismaUserRepository.ts";
import AuthService from "./services/AuthService.ts";
import AuthController from "./controllers/auth.controller.ts";

// CommonJS Requires
const PrismaHabitRepo = require("./repositories/PrismaHabitRepository");
const HabitService = require("./services/HabitService");
const UserService = require("./services/UserService");
const TokenService = require("./services/TokenService");
const createHabitController = require("./controllers/habit.controller");
const createUserController = require("./controllers/user.controller");
const createAuthRoutes = require("./routes/auth.routes");
const createHabitRoutes = require("./routes/habit.routes");
const createUserRoutes = require("./routes/user.routes");
const createValidateResource = require("./middleware/validateResource");
const createAuthMiddleware = require("./middleware/auth.middleware");

const container = createContainer();

/**
 * Helper to safely resolve ESM or CommonJS modules
 */
const extract = (mod) => mod.default || mod;

container.register({
  // Infrastructure
  db: asValue(prisma),
  config: asValue(config),

  // Repositories
  tokenRepo: asClass(extract(PrismaTokenRepository)).singleton(),
  userRepo: asClass(extract(PrismaUserRepository)).singleton(),
  habitRepo: asClass(extract(PrismaHabitRepo)).singleton(),

  // Services
  authService: asClass(extract(AuthService)).singleton(),
  habitService: asClass(extract(HabitService)).singleton(),
  userService: asClass(extract(UserService)).singleton(),
  tokenService: asClass(extract(TokenService)).singleton(),

  // Controllers
  // AuthController is a CLASS (asClass), others are FACTORIES (asFunction)
  authController: asClass(extract(AuthController)).singleton(),
  habitController: asFunction(extract(createHabitController)).singleton(),
  userController: asFunction(extract(createUserController)).singleton(),

  // Middleware
  validateResource: asFunction(extract(createValidateResource)).singleton(),
  authMiddleware: asFunction(extract(createAuthMiddleware)).singleton(),

  // Routes
  authRoutes: asFunction(extract(createAuthRoutes)).singleton(),
  habitRoutes: asFunction(extract(createHabitRoutes)).singleton(),
  userRoutes: asFunction(extract(createUserRoutes)).singleton(),
});

module.exports = container;
