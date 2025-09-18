const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const habitCompletionSchema = new Schema(
  {
    habitId: {
      type: mongoose.Schema.ObjectId,
      required: true,
    },
    userId: {
      type: mongoose.Schema.ObjectId,
      required: true,
    },
    dateOfCompletion: {
      type: Date,
      required: true,
    },
  },
  { timestamps: true }
);

module.exports = mongoose.model("habitCompletion", habitCompletionSchema);
