const express = require("express");
const router = express.Router();

const habitController = require("../controllers/habit.controller");
const { authenticateJWT } = require("../middleware/auth.middleware");
const {
  addHabitValidator,
  markCompleteValidator,
  updateHabitValidator,
  validateIdParam,
} = require("../validators/habit.validator");

router.use(authenticateJWT);

router
  .route("/")
  .post(addHabitValidator, habitController.createHabit)
  .get(habitController.getHabits);

router
  .route("/:id")
  .delete(validateIdParam, habitController.deleteHabit)
  .put(validateIdParam, updateHabitValidator, habitController.updateHabit);

router.get("/today", habitController.getTodaysHabits);

router.get("/weekly", habitController.getWeeklyHabits);

router.post(
  "/:id/completions",
  validateIdParam,
  markCompleteValidator,
  habitController.markAsCompleted
);

module.exports = router;
