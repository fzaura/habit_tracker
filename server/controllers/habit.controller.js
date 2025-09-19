const { validateJWT } = require("../middleware/auth.middleware");
const Habit = require("../models/habit.model");

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const createHabit = async (req, res, next) => {
  const { name, goal, completionStatus, frequency, endDate } = req.body;

  if ((!name || !goal || !completionStatus || !frequency, !endDate)) {
    return res.status(400).json({ message: "Please provide all fields." });
  }

  try {
    const newHabit = new Habit({
      name,
      goal,
      completionStatus,
      frequency,
      endDate,
      userId: req.user.userId,
    });

    await newHabit.save();

    return res
      .status(201)
      .json({ message: "New habit successfully added.", habit: newHabit });
  } catch (error) {
    next(error);
  }
};

module.exports = { createHabit };
