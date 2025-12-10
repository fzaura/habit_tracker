const IHabitRepo = require("./IHabitRepository");

/**
 * @type {import('@prisma/client').PrismaClient}
 */
const prisma = require("../config/prisma");

class PrismaHabitRepository extends IHabitRepo {
  async createHabit(habitData, userId) {
    const newHabit = await prisma.habit.create({
      data: {
        name: habitData.name,
        goal: habitData.goal,
        frequency: habitData.frequency,
        endDate: habitData.endDate ? new Date(habitData.endDate) : null,
        userId: userId,
      },
    });

    return newHabit;
  }

  async deleteHabit(habitId, userId) {
    const result = await prisma.habit.deleteMany({
      where: { AND: [{ id: habitId }, { userId: userId }] },
    });

    return result;
  }

  async updateHabit(habitId, habitData, userId) {
    const updatedHabit = await prisma.habit.updateMany({
      where: { AND: [{ id: habitId }, { userId }] },
      data: {
        name: habitData.name || undefined,
        goal: habitData.goal || undefined,
        frequency: habitData.frequency || undefined,
        endDate: habitData.endDate ? new Date(habitData.endDate) : undefined,
      },
    });

    if (updatedHabit.count > 0) {
      const habit = await prisma.habit.findUnique({ where: { id: habitId } });
      return habit;
    }

    return null;
  }

  async getAllHabits(userId) {
    const habits = await prisma.habit.findMany({ where: { userId } });

    return habits;
  }

  async getHabits(page, limit, userId) {
    const skip = (page - 1) * limit;

    const [habits, total] = await prisma.$transaction([
      prisma.habit.findMany({
        where: { userId },
        take: limit,
        skip,
      }),
      prisma.habit.count({ where: { userId } }),
    ]);

    return { habits, total };
  }

  async createCompletion(habitId, userId, date) {
    const newHabitCompletion = await prisma.habitCompletion.create({
      data: { userId, habitId, dateOfCompletion: new Date(date) },
    });

    return newHabitCompletion;
  }

  async getCompletedHabitsByDateRange(userId, startDate, endDate) {
    const completions = await prisma.habitCompletion.findMany({
      where: {
        AND: [
          { userId },
          { dateOfCompletion: { gte: startDate, lte: endDate } },
        ],
      },
    });

    return completions;
  }
}

module.exports = PrismaHabitRepository;
