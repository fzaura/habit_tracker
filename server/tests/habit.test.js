const request = require("supertest");
const app = require("../server");

describe("Habit API", () => {
  let token;
  let habitId;

  beforeAll(async () => {
    // 1. Create a user to own the habits
    const registerRes = await request(app).post("/api/auth/register").send({
      username: "HabitMaster",
      email: "master@test.com",
      password: "Password123!",
      confirmPassword: "Password123!",
    });
    token = registerRes.body.accessToken;
  });

  // Test 1: Create a Habit (Must include endDate as per Service)
  it("should create a new habit", async () => {
    const res = await request(app)
      .post("/api/habits")
      .set("Authorization", `Bearer ${token}`)
      .send({
        name: "Drink Water",
        goal: "Drink 2 liters daily",
        frequency: { type: "daily" },
        endDate: "2025-12-31", // <--- REQUIRED by your Service
      });

    expect(res.statusCode).toEqual(201);

    // Capture the ID for the next tests
    // Check both _id (mongoose) and id (virtual) just in case
    habitId = res.body.habit._id || res.body.habit.id;
  });

  // Test 2: Fetch Habits (Fixed Path)
  it("should fetch all habits for the user", async () => {
    const res = await request(app)
      .get("/api/habits")
      .set("Authorization", `Bearer ${token}`);

    expect(res.statusCode).toEqual(200);

    // FIX: Your Service returns { info: { data: [...], pagination: ... } }
    const habitsList = res.body.info.data;

    expect(Array.isArray(habitsList)).toBeTruthy();
    expect(habitsList.length).toBeGreaterThan(0);
    expect(habitsList[0]).toHaveProperty("name", "Drink Water");
  });

  // Test 3: Update Habit
  // Test 3: Update Habit
  it("should update an existing habit", async () => {
    const res = await request(app)
      .put(`/api/habits/${habitId}`) // <--- Try changing PATCH to PUT
      .set("Authorization", `Bearer ${token}`)
      .send({
        name: "Drink MORE Water",
      });

    // ... rest of test

    expect(res.statusCode).toEqual(200);
    expect(res.body.habit).toHaveProperty("name", "Drink MORE Water");
  });

  // Test 4: Delete Habit
  it("should delete a habit", async () => {
    const res = await request(app)
      .delete(`/api/habits/${habitId}`)
      .set("Authorization", `Bearer ${token}`);

    expect(res.statusCode).toEqual(200);
  });
});
