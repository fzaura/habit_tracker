class IHabitRepository {
  createHabit(habitData, userId) {
    throw new Error("Method not implemented.");
  }
  deleteHabit(habitId, userId) {
    throw new Error("Method not implemented.");
  }
  updateHabit(habitId, habitData, userId) {
    throw new Error("Method not implemented.");
  }
  getHabits(page, limit, userId) {
    throw new Error("Method not implemented.");
  }
  createCompletion(habitId, userId, date) {
    throw new Error("Method not implemented.");
  }
  getCompletedHabitsByDateRange(userId, startDate, endDate) {
    throw new Error("Method not implemented.");
  }
}

module.exports = IHabitRepository;
