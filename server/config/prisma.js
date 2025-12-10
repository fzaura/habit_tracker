const { PrismaClient } = require("@prisma/client");
const { PrismaPg } = require("@prisma/adapter-pg");
const { Pool } = require("pg");

/**
 * Singleton function to ensure we don't create multiple connections
 * during hot-reloading in development.
 */
const prismaClientSingleton = () => {
  const pool = new Pool({
    connectionString: process.env.DATABASE_URL,
  });

  const adapter = new PrismaPg(pool);

  return new PrismaClient({
    adapter: adapter,
  });
};

// 1. Check if we already have an instance in the global scope
const prisma = global.prismaGlobal || prismaClientSingleton();

module.exports = prisma;

// 2. If we are not in production, save the instance to global
if (process.env.NODE_ENV !== "production") {
  global.prismaGlobal = prisma;
}
