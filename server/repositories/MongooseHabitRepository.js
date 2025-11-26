const IHabitRepo = require("./IHabitRepository");
const Habit = require("../models/habit.model");
const HabitCompletion = require("../models/habitCompletion.model");

class MongooseHabitRepository extends IHabitRepo {
  async createHabit(habitData, userId) {
    const habitToCreate = {
      ...habitData,
      userId,
    };

    const newHabit = await Habit.create(habitToCreate);

    return newHabit;
  }

  async deleteHabit(habitId, userId) {
    const result = Habit.deleteOne({ _id: habitId, userId });

    return result;
  }

  async updateHabit(habitId, habitData, userId) {
    const updatedHabit = await Habit.findOneAndUpdate(
      { _id: habitId, userId },
      habitData,
      { new: true, runValidators: true }
    ).lean();

    return updatedHabit;
  }

  async getAllHabits(userId) {
    return Habit.find({ userId }).lean();
  }

  async getHabits(page, limit, userId) {
    const skip = (page - 1) * limit;

    const [habits, total] = await Promise.all([
      Habit.find({ userId })
        .sort({ createdAt: -1 })
        .limit(limit)
        .skip(skip)
        .lean(),
      Habit.countDocuments({ userId }),
    ]);

    return { habits, total };
  }

  async createCompletion(habitId, userId, date) {
    const newHabitCompletion = HabitCompletion.create({
      habitId: habitId,
      userId,
      date,
    });

    return newHabitCompletion;
  }

  async getCompletedHabitsByDateRange(userId, startDate, endDate) {
    const completions = await HabitCompletion.find({
      userId,
      dateOfCompletion: {
        $gte: startDate,
        $lte: endDate,
      },
    }).lean();

    return completions;
  }
}

module.exports = MongooseHabitRepository;
