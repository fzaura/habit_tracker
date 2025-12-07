const mongoose = require("mongoose");
const dotenv = require("dotenv");

dotenv.config();

// Use a separate DB for testing
const TEST_DB_NAME = process.env.DB_NAME + "_test";

beforeAll(async () => {
  // Connect to the test database
  await mongoose.connect(process.env.DATABASE_URL, { dbName: TEST_DB_NAME });
});

afterAll(async () => {
  // Clean up: Drop the DB and close connection
  await mongoose.connection.dropDatabase();
  await mongoose.connection.close();
});
