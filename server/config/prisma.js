/**
 * @fileoverview Prisma client configuration with PostgreSQL adapter.
 * Implements singleton pattern to prevent multiple database connections
 * during development hot-reloading.
 *
 * @module config/prisma
 * @requires @prisma/client
 * @requires @prisma/adapter-pg
 * @requires pg
 *
 * Environment Variables Required:
 * - PSQL_URL: PostgreSQL connection string
 * - NODE_ENV: Environment mode (development/production)
 */
const { PrismaClient } = require("@prisma/client");
const { PrismaPg } = require("@prisma/adapter-pg");
const { Pool } = require("pg");

/**
 * Singleton function to create Prisma client with PostgreSQL adapter.
 * Ensures single database connection instance during hot-reloading.
 *
 * @function prismaClientSingleton
 * @returns {PrismaClient} Configured Prisma client instance
 */
const prismaClientSingleton = () => {
  const pool = new Pool({
    connectionString: process.env.PSQL_URL,
  });

  const adapter = new PrismaPg(pool);

  return new PrismaClient({
    adapter: adapter,
  });
};

/**
 * Prisma client instance (singleton).
 * Reuses existing global instance in development to prevent
 * multiple connections during hot-reload.
 *
 * @type {PrismaClient}
 */
const prisma = global.prismaGlobal || prismaClientSingleton();

module.exports = prisma;

// Store instance globally in development to survive hot-reloads
if (process.env.NODE_ENV !== "production") {
  global.prismaGlobal = prisma;
}
