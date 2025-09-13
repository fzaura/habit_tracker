const mongoose = require("mongoose");
const Schema = mongoose.Schema;

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

    completionStatus: {
      type: Boolean,
      required: true,
    },

    frequency: {
      type: {
        type: String,
        enum: ["daily", "weekly", "specific_days"],
        required: true,
      },
      times: {
        type: Number,
      },
      days: {
        type: Number,
      },
    },

    endDate: {
      type: Date,
    },

    userId: {
      type: mongoose.Schema.Types.ObjectId,
      required: true,
    },
  },
  {
    timestamps: true,
  }
);

module.exports = mongoose.model(habitSchema);
