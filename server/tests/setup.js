/**
 * @fileoverview Test environment setup configuration.
 * Configures MongoDB test database connection and cleanup for Jest tests.
 *
 * @module tests/setup
 * @requires mongoose
 * @requires dotenv
 */
const mongoose = require("mongoose");
const dotenv = require("dotenv");

dotenv.config();

/**
 * Test database name (appends _test to main database name).
 * @constant {string}
 */
const TEST_DB_NAME = process.env.DB_NAME + "_test";

/**
 * Jest beforeAll hook.
 * Connects to test database before running test suite.
 *
 * @async
 * @function beforeAll
 */
beforeAll(async () => {
  // Connect to the test database
  await mongoose.connect(process.env.DATABASE_URL, { dbName: TEST_DB_NAME });
});

/**
 * Jest afterAll hook.
 * Drops test database and closes connection after test suite completes.
 *
 * @async
 * @function afterAll
 */
afterAll(async () => {
  // Clean up: Drop the DB and close connection
  await mongoose.connection.dropDatabase();
  await mongoose.connection.close();
});
