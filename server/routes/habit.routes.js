const express = require("express");
const router = express.Router();

const habitController = require("../controllers/habit.controller");
const { authenticateJWT } = require("../middleware/auth.middleware");
const {
  addHabitValidator,
  markCompleteValidator,
  updateHabitValidator,
} = require("../validators/habit.validator");

router.use(authenticateJWT);

router.post("/habits", addHabitValidator, habitController.createHabit);

router.delete("/habits/:id", habitController.deleteHabit);

router.put("/habits/:id", updateHabitValidator, habitController.updateHabit);

router.get("/habits", habitController.getHabits);

router.get("/todays-habits", habitController.getTodaysHabits);

router.get("/weekly-habits", habitController.getWeeklyHabits);

router.post(
  "/habits/:id/completions",
  markCompleteValidator,
  habitController.markAsCompleted
);

module.exports = router;
