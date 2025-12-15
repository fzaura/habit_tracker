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

module.exports = container;
