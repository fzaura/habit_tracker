const request = require("supertest");
const app = require("../server");

describe("User API", () => {
  let token;

  // Before running tests, create a user and get a token
  beforeAll(async () => {
    const registerRes = await request(app).post("/api/auth/register").send({
      username: "Updater",
      email: "update@test.com",
      password: "Password123!",
      confirmPassword: "Password123!",
    });
    token = registerRes.body.accessToken;
  });

  it("should update the username successfully", async () => {
    const res = await request(app)
      .patch("/api/users/me")
      .set("Authorization", `Bearer ${token}`) // <--- Header Injection
      .send({
        username: "NewName",
      });

    expect(res.statusCode).toEqual(200);
    expect(res.body.user).toHaveProperty("username", "NewName");
  });

  it("should fail to update with invalid email", async () => {
    const res = await request(app)
      .patch("/api/users/me")
      .set("Authorization", `Bearer ${token}`)
      .send({
        email: "not-an-email",
      });

    expect(res.statusCode).toEqual(400); // Validation error
  });

  it("should block update without token", async () => {
    const res = await request(app).patch("/api/users/me").send({
      username: "Hacker",
    });

    expect(res.statusCode).toEqual(401); // Unauthorized
  });
});
