const {
  createContainer,
  asClass,
  asValue,
  Lifetime,
  asFunction,
} = require("awilix");
const { scopePerRequest } = require("awilix-express");

const PrismaTokenRepo = require("./repositories/PrismaTokenRepository");
const PrismaUserRepo = require("./repositories/PrismaUserRepository");
const PrismaHabitRepo = require("./repositories/PrismaHabitRepository");

const AuthService = require("./services/AuthService");
const HabitService = require("./services/HabitService");

const createAuthController = require("./controllers/auth.controller");
const createHabitController = require("./controllers/habit.controller");

const container = createContainer();
container.register({
  tokenRepo: asClass(PrismaTokenRepo).scoped(),
  userRepo: asClass(PrismaUserRepo).scoped(),
  habitRepo: asClass(PrismaHabitRepo).scoped(),

  authService: asClass(AuthService).scoped(),
  habitService: asClass(HabitService).scoped(),

  createAuthController: asFunction(createAuthController).scoped(),
  createHabitController: asFunction(createHabitController).scoped(),
});

module.exports = container;
