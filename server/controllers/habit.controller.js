const { default: mongoose } = require("mongoose");
const { validateJWT } = require("../middleware/auth.middleware");
const Habit = require("../models/habit.model");
const HabitCompletion = require("../models/habitCompletion.model");

const { validationResult } = require("express-validator");
/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const createHabit = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { name, goal, frequency, endDate } = req.body;

  if (frequency === "daily") {
    frequency.daysOfWeek = [0, 1, 2, 3, 4, 5, 6];
  }

  try {
    const newHabit = new Habit({
      name,
      goal,
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

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const deleteHabit = async (req, res, next) => {
  const { id } = req.params;
  const userId = req.user.userId;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ message: "Invalid habit ID format." });
  }

  try {
    const result = await Habit.deleteOne({ _id: id, userId });

    if (result.deletedCount === 0) {
      return res
        .status(404)
        .json({ message: "Task not found or user is unauthorized." });
    }

    return res.status(200).json({ message: "Task deleted successfully." });
  } catch (error) {
    next(error);
  }
};

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const updateHabit = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  const { name, goal, frequency, endDate } = req.body;

  const { id } = req.params;
  const userId = req.user.userId;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ message: "Invalid habit ID format" });
  }

  try {
    const updatedHabit = await Habit.findOneAndUpdate(
      { _id: id, userId },
      { name, goal, frequency, endDate },
      { new: true, runValidators: true }
    );

    if (!updatedHabit) {
      return res
        .status(404)
        .json({ message: "Habit not found or user is unauthorized." });
    }

    return res
      .status(200)
      .json({ message: "Habit updated successfully.", habit: updateHabit });
  } catch (error) {
    next(error);
  }
};

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const getHabits = async (req, res, next) => {
  const page = parseInt(req.query.page) || 1;
  const limit = parseInt(req.query.limit) || 10;
  const skip = (page - 1) * limit;
  const userId = req.user.userId;

  try {
    const [habits, numberOfDocuments] = await Promise.all([
      Habit.find({ userId }).limit(limit).skip(skip),
      Habit.countDocuments({ userId }),
    ]);

    const totalPages = Math.ceil(numberOfDocuments / limit);
    return res.status(200).json({
      data: habits,
      pagination: {
        totalItems: numberOfDocuments,
        totalPages,
        currentPage: page,
      },
    });
  } catch (error) {
    next(error);
  }
};

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const markAsCompleted = async (req, res, next) => {
  const { id } = req.params;
  const userId = req.user.userId;

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ message: "Invalid habit ID format" });
  }

  try {
    const result = await Habit.findOne({ _id: id, userId });
    if (!result) {
      return res
        .status(404)
        .json({ message: "Habit not found or user is unauthorized." });
    }

    const dateOfCompletion = req.body.date
      ? new Date(req.body.date)
      : new Date();

    dateOfCompletion.setUTCHours(0, 0, 0, 0);

    const existingCompletion = await HabitCompletion.findOne({
      habitId: id,
      userId,
      date: dateOfCompletion,
    });

    if (existingCompletion) {
      return res
        .status(409)
        .json({ message: "Habit already marked as complete for the day." });
    }

    const newHabitCompletion = new HabitCompletion({
      habitId: id,
      userId,
      dateOfCompletion,
    });

    await newHabitCompletion.save();

    return res.status(201).json({
      message: "Habit successfully marked as completed.",
      completion: newHabitCompletion,
    });
  } catch (error) {
    next(error);
  }
};

module.exports = {
  createHabit,
  getHabits,
  deleteHabit,
  updateHabit,
  markAsCompleted,
};
