/**
 * @module types/common
 * @description Common type definitions used across the application.
 */

/**
 * Standard API response structure
 * @typedef {Object} ApiResponse
 * @property {string} message - Response message
 * @property {*} [data] - Optional response data
 * @property {Array} [errors] - Array of validation errors
 */

/**
 * JWT token pair
 * @typedef {Object} TokenPair
 * @property {string} accessToken - JWT access token (15 minutes)
 * @property {string} refreshToken - JWT refresh token (7 days)
 */

/**
 * User registration request payload
 * @typedef {Object} RegisterRequest
 * @property {string} username - Username (5-12 characters)
 * @property {string} email - Valid email address
 * @property {string} password - Password (min 10 chars, must contain number and special char)
 * @property {string} confirmPassword - Password confirmation
 */

/**
 * User login request payload
 * @typedef {Object} LoginRequest
 * @property {string} email - User email
 * @property {string} password - User password
 */

/**
 * User update request payload
 * @typedef {Object} UpdateUserRequest
 * @property {string} [username] - New username
 * @property {string} [email] - New email
 * @property {string} [password] - New password
 * @property {string} [confirmPassword] - Password confirmation
 */

/**
 * Token refresh request payload
 * @typedef {Object} RefreshTokenRequest
 * @property {string} refreshToken - Valid refresh token
 */

/**
 * Habit frequency configuration
 * @typedef {Object} HabitFrequency
 * @property {string} type - Frequency type: 'daily' or 'weekly'
 * @property {number[]} [daysOfWeek] - Array of day indices (0-6) for weekly habits
 */

/**
 * Habit creation request payload
 * @typedef {Object} CreateHabitRequest
 * @property {string} name - Habit name (max 100 characters)
 * @property {string} goal - Habit description/goal (max 500 characters)
 * @property {HabitFrequency} frequency - Frequency configuration
 * @property {string} [endDate] - Optional end date (ISO format)
 */

/**
 * Habit update request payload
 * @typedef {Object} UpdateHabitRequest
 * @property {string} [name] - Updated habit name
 * @property {string} [goal] - Updated habit goal
 * @property {HabitFrequency} [frequency] - Updated frequency configuration
 * @property {string} [endDate] - Updated end date
 */

/**
 * Habit completion request payload
 * @typedef {Object} MarkCompletedRequest
 * @property {string} date - Completion date in YYYY-MM-DD format
 */

/**
 * Pagination query parameters
 * @typedef {Object} PaginationQuery
 * @property {number} [page=1] - Page number
 * @property {number} [limit=10] - Items per page
 */

/**
 * Pagination metadata
 * @typedef {Object} PaginationMeta
 * @property {number} totalItems - Total number of items
 * @property {number} totalPages - Total number of pages
 * @property {number} currentPage - Current page number
 */

/**
 * Paginated response structure
 * @typedef {Object} PaginatedResponse
 * @property {Array} data - Array of items for current page
 * @property {PaginationMeta} pagination - Pagination metadata
 */

/**
 * User data (without sensitive fields)
 * @typedef {Object} UserData
 * @property {string} id - User ID
 * @property {string} username - Username
 * @property {string} email - Email address
 */

/**
 * Authentication response
 * @typedef {Object} AuthResponse
 * @property {string} message - Success message
 * @property {string} accessToken - JWT access token
 * @property {string} refreshToken - JWT refresh token
 * @property {UserData} user - User data
 */

/**
 * Habit completion data
 * @typedef {Object} HabitCompletion
 * @property {string} habitId - Associated habit ID
 * @property {string} userId - User ID
 * @property {Date} dateOfCompletion - Completion date
 * @property {Date} createdAt - Creation timestamp
 * @property {Date} updatedAt - Update timestamp
 */

/**
 * Weekly habit overview
 * @typedef {Object} WeeklyHabitData
 * @property {Date} startOfWeek - Start of week date
 * @property {Date} endOfWeek - End of week date
 * @property {Array} habits - Array of habits with weekly completion status
 */

module.exports = {};
