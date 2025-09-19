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

  if (frequency === "daily") {
    frequency = [0, 1, 2, 3, 4, 5, 6];
  }

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

  const { date: dateString } = req.body;
  if (!dateString) {
    return res
      .status(400)
      .json({ message: "A date string is required in the form YYYY-MM-DD" });
  }

  if (!mongoose.Types.ObjectId.isValid(id)) {
    return res.status(400).json({ message: "Invalid habit ID format" });
  }

  try {
    const habit = await Habit.findOne({ _id: id, userId });
    if (!habit) {
      return res
        .status(404)
        .json({ message: "Habit not found or user is unauthorized." });
    }

    const dateOfCompletion = new Date(dateString);

    const existingCompletion = await HabitCompletion.findOne({
      habitId: id,
      userId,
      dateOfCompletion,
    }).lean();

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

/**
 *
 * @param {import('express').Request} req
 * @param {import('express').Response} res
 * @param {import('express').NextFunction} next
 */
const getTodaysHabits = async (req, res, next) => {
  const userId = req.user.userId;
  const today = new Date().getUTCDay();

  try {
    const activeHabits = await Habit.findOne({
      userId,
      "frequency.daysOfWeek": { $in: [today] },
    }).lean();

    const startOfToday = new Date();
    startOfToday.setUTCHours(0, 0, 0, 0);

    const todaysCompletions = await HabitCompletion.find({
      userId,
      dateOfCompletion: startOfToday,
    });

    const completedHabits = new Set(
      todaysCompletions.map((comp) => comp.habitId.toString())
    );

    const todaysHabits = activeHabits.map((habit) => ({
      ...habit,
      isCompletedToday: completedHabits.has(habit._id.toString()),
    }));

    res.status(200).json({ data: todaysHabits });
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
const getWeeklyHabits = async (req, res, next) => {
  const errors = validationResult(req);

  if (!errors.isEmpty()) {
    return res.status(400).json({ errors: errors.array() });
  }

  try {
    const userId = req.user.userId;

    const { date: dateString } = req.body;

    const today = new Date(dateString);
    const dayOfWeek = today.getDay();
    const offsetToMonday = (dayOfWeek + 6) % 7;

    const startOfWeek = new Date(today);
    startOfWeek.setDate(today.getDate() - offsetToMonday);
    startOfWeek.setUTCHours(0, 0, 0, 0);

    const endOfWeek = new Date(startOfWeek);
    endOfWeek.setDate(today.getDate() + 6);
    endOfWeek.setUTCHours(23, 59, 59, 999);

    const habits = await Habit.find({ userId }).lean();

    const completions = await HabitCompletion.find({
      userId,
      dateOfCompletion: {
        $gte: startOfWeek,
        $lse: endOfWeek,
      },
    }).lean();

    const completionsMap = new Map();
    completions.forEach((comp) => {
      const dateKey = comp.dateOfCompletion.toISOString().split("T")[0];
      if (!completionsMap.has(dateKey)) {
        completionsMap.set(dateKey, new Set());
      }

      completionsMap.get(dateKey).add(comp.habitId.toString());
    });

    const weeklyData = {
      startOfWeek,
      endOfWeek,
      habits: habits.map((habit) => {
        const weeklyCompletions = {};
        for (let i = 0; i < 7; i++) {
          const day = new Date(startOfWeek);
          day.setDate(startOfWeek.getDate() + i);
          const dayKey = day.toISOString().split("T")[0];

          weeklyCompletions[dayKey] =
            completionsMap.has(dayKey) &&
            completionsMap.get(dayKey).has(habit._id.toString());
        }

        return { ...habit, weeklyCompletions };
      }),
    };

    return res.status(200).json({ weeklyData });
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
  getTodaysHabits,
  getWeeklyHabits,
};
