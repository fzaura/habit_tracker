/**
 * @fileoverview Habit completion model schema definition.
 * Tracks individual habit completion events by users.
 *
 * @module models/habitCompletion
 * @requires mongoose
 */
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

/**
 * Habit completion schema definition.
 *
 * @typedef {Object} HabitCompletion
 * @property {ObjectId} habitId - Reference to completed Habit
 * @property {ObjectId} userId - Reference to User who completed habit
 * @property {Date} dateOfCompletion - Date habit was marked complete
 * @property {Date} createdAt - Auto-generated creation timestamp
 * @property {Date} updatedAt - Auto-generated update timestamp
 */
const habitCompletionSchema = new Schema(
  {
    habitId: {
      type: mongoose.Schema.ObjectId,
      ref: "Habit",
      required: true,
    },
    userId: {
      type: mongoose.Schema.ObjectId,
      ref: "User",
      required: true,
    },
    dateOfCompletion: {
      type: Date,
      required: true,
    },
  },
  { timestamps: true }
);

/**
 * HabitCompletion model for MongoDB operations.
 *
 * @type {mongoose.Model}
 */
module.exports = mongoose.model("habitCompletion", habitCompletionSchema);
