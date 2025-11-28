class HabitService {
  constructor(habitRepository) {
    this.habitRepository = habitRepository;
  }

  async createHabit(habitData, userId) {
    if (!habitData.name) {
      throw new Error("Habit name is required");
    }
    if (!habitData.goal) {
      throw new Error("Habit goal is required");
    }
    if (!habitData.frequency) {
      throw new Error("Habit frequency is required");
    }
    if (!habitData.endDate) {
      throw new Error("Habit end date is required");
    }

    if (habitData.frequency === "daily") {
      habitData.frequency = {
        type: "daily",
        daysOfWeek: [0, 1, 2, 3, 4, 5, 6],
      };
    }

    const newHabit = await this.habitRepository.createHabit(habitData, userId);
    return newHabit;
  }

  async deleteHabit(habitId, userId) {
    const result = await this.habitRepository.deleteHabit(habitId, userId);

    if (!result || result.deletedCount === 0) {
      throw new Error("Habit not found or user unauthorized.");
    }

    return result;
  }

  async updateHabit(habitId, habitData, userId) {
    if (!habitId) {
      throw new Error("Habit ID is required.");
    }
    if (!habitData) {
      throw new Error("Habit data is required.");
    }
    if (!userId) {
      throw new Error("User ID is required.");
    }

    if (habitData.frequency === "daily") {
      habitData.frequency = {
        type: "daily",
        daysOfWeek: [0, 1, 2, 3, 4, 5, 6],
      };
    }
    const updatedHabit = await this.habitRepository.updateHabit(
      habitId,
      habitData,
      userId
    );

    if (!updatedHabit) {
      throw new Error("Habit not found or user unauthorized.");
    }

    return updatedHabit;
  }

  async getHabits(page, limit, userId) {
    const { habits, total } = await this.habitRepository.getHabits(
      page,
      limit,
      userId
    );

    const totalPages = Math.ceil(total / limit);

    const info = {
      data: habits,
      pagination: {
        totalItems: total,
        totalPages: totalPages,
        currentPage: page,
      },
    };

    return info;
  }

  async markAsCompleted(habitId, userId, dateString) {
    if (!userId) {
      throw new Error("User ID is required.");
    }
    if (!habitId) {
      throw new Error("Habit ID is required.");
    }
    if (!dateString) {
      throw new Error("Date string is required.");
    }

    const date = new Date(dateString);
    if (isNaN(date.getTime())) {
      throw new Error("Invalid date string.");
    }

    const startOfDay = new Date(dateString);
    startOfDay.setUTCHours(0, 0, 0, 0);
    const endOfDay = new Date(dateString);
    endOfDay.setUTCHours(23, 59, 59, 999);

    const completionsToday =
      await this.habitRepository.getCompletedHabitsByDateRange(
        userId,
        startOfDay,
        endOfDay
      );

    const isCompleted = completionsToday.some(
      (c) => c.habitId.toString() === habitId
    );
    if (isCompleted) {
      throw new Error("Habit is already completed.");
    }

    return await this.habitRepository.createCompletion(habitId, userId, date);
  }
}

module.exports = HabitService;
