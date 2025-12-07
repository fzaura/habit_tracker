/**
 * @fileoverview Habit model schema definition.
 * Defines the structure and validation for habit documents in MongoDB.
 *
 * @module models/habit
 * @requires mongoose
 */
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

/**
 * Habit schema definition.
 *
 * @typedef {Object} Habit
 * @property {string} name - Habit name (required, trimmed)
 * @property {string} goal - Habit description/goal (required, trimmed)
 * @property {Object} frequency - Frequency configuration
 * @property {string} frequency.type - 'daily' or 'weekly'
 * @property {number[]} frequency.daysOfWeek - Days of week (0-6)
 * @property {Date} endDate - Optional end date for habit
 * @property {ObjectId} userId - Reference to User who owns habit
 * @property {Date} createdAt - Auto-generated creation timestamp
 * @property {Date} updatedAt - Auto-generated update timestamp
 */
const habitSchema = new Schema(
  {
    name: {
      type: String,
      required: true,
      trim: true,
    },

    goal: {
      type: String,
      required: true,
      trim: true,
    },

    frequency: {
      type: {
        type: String,
        enum: ["daily", "weekly"],
        required: true,
      },
      daysOfWeek: {
        type: [Number],
        required: true,
        default: [],
      },
    },

    endDate: {
      type: Date,
    },

    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "User",
      required: true,
    },
  },
  {
    timestamps: true,
    toJSON: true,
    toObject: true,
  }
);

/**
 * Virtual property to compute habit status based on end date.
 *
 * @name status
 * @memberof module:models/habit
 * @returns {string} 'active' or 'completed' based on end date
 */
habitSchema.virtual("status").get(function () {
  if (this.endDate()) {
    return "active;";
  }

  return new Date() > this.endDate ? "completed" : "active";
});

/**
 * Habit model for MongoDB operations.
 *
 * @type {mongoose.Model}
 */
module.exports = mongoose.model("Habit", habitSchema);
