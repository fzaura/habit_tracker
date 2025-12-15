/**
 * @fileoverview Authentication API integration tests.
 * Tests user registration, login, and duplicate email/username scenarios.
 *
 * @module tests/auth
 * @requires supertest
 * @requires ../server
 */
const request = require("supertest");
const app = require("../server");

/**
 * Authentication API test suite.
 * Tests registration, login, and validation.
 *
 * @function describe
 * @name Auth API
 */
describe("Auth API", () => {
  /**
   * Test user data for authentication tests.
   * @constant {Object}
   */
  const testUser = {
    username: "TestHero",
    email: "hero@test.com",
    password: "Password123!",
    confirmPassword: "Password123!",
  };

  it("should register a new user successfully", async () => {
    const res = await request(app).post("/api/auth/register").send(testUser);

    expect(res.statusCode).toEqual(201);
    expect(res.body).toHaveProperty("accessToken");
    expect(res.body.user).toHaveProperty("email", testUser.email.toLowerCase());
  });

  it("should not register a user with duplicate email", async () => {
    // Try registering the same user again
    const res = await request(app).post("/api/auth/register").send(testUser);

    expect(res.statusCode).toEqual(400); // Should fail
  });

  it("should login the user successfully", async () => {
    const res = await request(app).post("/api/auth/login").send({
      email: testUser.email,
      password: testUser.password,
    });

    expect(res.statusCode).toEqual(200);
    expect(res.body).toHaveProperty("accessToken");
  });
});
