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

    frequency: {
      type: {
        type: String,
        enum: ["daily", "weekly"],
        required: true,
      },
      timesPerDay: {
        type: Number,
        default: 1,
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

habitSchema.virtual("status").get(function () {
  if (this.endDate()) {
    return "active;";
  }

  return new Date() > this.endDate ? "completed" : "active";
});

module.exports = mongoose.model("Habit", habitSchema);
