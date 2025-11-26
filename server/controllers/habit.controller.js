const { validationResult } = require("express-validator");

const createHabitController = (habitService) => {
  const createHabit = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { name, goal, frequency, endDate } = req.body;

    try {
      const newHabit = await habitService.createHabit(
        { name, goal, frequency, endDate },
        req.user.userId
      );

      return res
        .status(201)
        .json({ message: "New habit successfully added.", habit: newHabit });
    } catch (error) {
      next(error);
    }
  };

  const deleteHabit = async (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id: habitId } = req.params;
    const userId = req.user.userId;

    try {
      const result = await habitService.deleteHabit(habitId, userId);

      return res.status(200).json({ message: "Task deleted successfully." });
    } catch (error) {
      next(error);
    }
  };

  const updateHabit = async (req, res, next) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { name, goal, frequency, endDate } = req.body;

    const { id: habitId } = req.params;
    const userId = req.user.userId;

    try {
      const updateHabit = await habitService.updateHabit(
        habitId,
        { name, goal, frequency, endDate },
        userId
      );

      return res
        .status(200)
        .json({ message: "Habit updated successfully.", habit: updateHabit });
    } catch (error) {
      next(error);
    }
  };

  const getHabits = async (req, res, next) => {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const userId = req.user.userId;

    try {
      const info = await habitService.getHabits(page, limit, userId);

      return res.status(200).json({ info });
    } catch (error) {
      next(error);
    }
  };

  const markAsCompleted = async (req, res, next) => {
    const errors = validationResult(req);

    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id: habitId } = req.params;
    const userId = req.user.userId;
    const { dateString } = req.body;

    try {
      const habit = await habitService.markAsCompleted(
        habitId,
        userId,
        dateString
      );

      return res
        .status(200)
        .json({ message: "Habit marked as completed successfully." });
    } catch (error) {
      next(error);
    }
  };

  return {
    createHabit,
    deleteHabit,
    updateHabit,
    getHabits,
    markAsCompleted,
  };
};

module.exports = createHabitController;
