/**
 * @fileoverview Refresh token model schema definition.
 * Stores valid refresh tokens for user session management.
 *
 * @module models/refreshToken
 * @requires mongoose
 */
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

/**
 * Refresh token schema definition.
 *
 * @typedef {Object} RefreshToken
 * @property {string} value - JWT refresh token value (unique, required)
 * @property {ObjectId} userId - Reference to User who owns token
 */
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

/**
 * RefreshToken model for MongoDB operations.
 *
 * @type {mongoose.Model}
 */
module.exports = mongoose.model("RefreshToken", refreshTokenSchema);
