/**
 * @fileoverview User model schema definition.
 * Defines the structure and validation for user documents in MongoDB.
 *
 * @module models/user
 * @requires mongoose
 */
const mongoose = require("mongoose");
const Schema = mongoose.Schema;

/**
 * User schema definition.
 *
 * @typedef {Object} User
 * @property {string} username - Unique username (required, trimmed)
 * @property {string} email - Unique email address (required, trimmed)
 * @property {string} password - Hashed password (required, trimmed)
 */
const userSchema = new Schema({
  username: {
    type: String,
    required: true,
    unique: true,
    trim: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
  },
  password: {
    type: String,
    required: true,
    trim: true,
  },
});

/**
 * User model for MongoDB operations.
 *
 * @type {mongoose.Model}
 */
const userModel = mongoose.model("User", userSchema);
module.exports = userModel;
