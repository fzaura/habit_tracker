# Habit Tracker

A full-stack habit tracking application designed to help users build and maintain healthy routines. The project consists of a Flutter mobile frontend and a Node.js/Express/MongoDB backend server.

## Features

- User registration, login, and authentication
- Track daily, weekly, or custom habits
- View progress and habit history
- Secure backend with JWT authentication and password hashing
- RESTful API for habit management
- Modular, scalable codebase

## Tech Stack

- **Frontend:** Flutter (Dart)
- **Backend:** Node.js, Express.js, MongoDB, Mongoose
- **Security:** JWT, bcrypt, helmet
- **Validation:** express-validator

## Structure

- `mobile_frontend/habit_tracker_frontend/` — Flutter mobile app
- `server/` — Node.js backend API

## Getting Started

1. Clone the repository
2. Set up MongoDB and environment variables for the server
3. Install dependencies in both `server` and `mobile_frontend/habit_tracker_frontend`
4. Run the backend: `npm start` in `server`
5. Run the frontend: `flutter run` in `mobile_frontend/habit_tracker_frontend`

## License

MIT
