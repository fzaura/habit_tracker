const express = require("express");
const router = express.Router();

const habitController = require("../controllers/habit.controller");
const { authenticateJWT } = require("../middleware/auth.middleware");
const {
  addHabitValidator,
  markCompleteValidator,
  updateHabitValidator,
} = require("../validators/habit.validator");

router.post(
  "/habits",
  authenticateJWT,
  addHabitValidator,
  habitController.createHabit
);

router.delete("/habits/:id", authenticateJWT, habitController.deleteHabit);

router.put(
  "/habits/:id",
  authenticateJWT,
  updateHabitValidator,
  habitController.updateHabit
);

router.get("/habits", authenticateJWT, habitController.getHabits);

router.get("/todays-habits", authenticateJWT, habitController.getTodaysHabits);

router.get("/weekly-habits", authenticateJWT, habitController.getWeeklyHabits);

router.post(
  "/habits/:id/completions",
  authenticateJWT,
  markCompleteValidator,
  habitController.markAsCompleted
);

module.exports = router;
