# Habit Tracker Server

A secure RESTful API backend for the Habit Tracker app, built with Node.js, Express.js, and MongoDB.

## Features

- User registration and login with JWT authentication
- Habit CRUD operations
- Password hashing with bcrypt
- Input validation and error handling
- Modular architecture (controllers, routes, models, middleware)
- Environment variable support via dotenv

## Setup

1. Install dependencies: `npm install`
2. Configure `.env` with MongoDB URI and JWT secret
3. Start the server: `npm start`

## API Endpoints

- `/auth/register` — Register user
- `/auth/login` — Login and receive JWT
- `/habits` — Manage habits (CRUD, requires authentication)

## Technologies

- Node.js
- Express.js
- MongoDB & Mongoose
- JWT, bcrypt, helmet

## License

MIT
