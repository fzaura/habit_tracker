const { PrismaClient } = require("@prisma/client");
let prisma;

if (process.env.NODE_ENV === "production") {
  prisma = new PrismaClient();
} else {
  if (!global.prisma) {
    global.prisma = new PrismaClient();
  }

  prisma = global.prisma;
}

/**
 * @type {import('@prisma/client').PrismaClient}
 */
module.exports = prisma;
