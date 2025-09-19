const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const refreshTokenSchema = new Schema({
  value: {
    type: String,
    required: true,
    unique: true,
  },
  userId: {
    type: mongoose.Schema.ObjectId,
    required: true,
  },
});

module.exports = mongoose.model("RefreshToken", refreshTokenSchema);
