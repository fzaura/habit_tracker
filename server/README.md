# Habit Tracker Server

A secure RESTful API backend for the Habit Tracker app, built with Node.js, Express.js, and MongoDB. This server implements a clean architecture with repository pattern, dependency injection, and comprehensive input validation.

## Features

- **Authentication**: User registration and login with JWT-based authentication (access & refresh tokens)
- **Habit Management**: Full CRUD operations for habits with frequency tracking (daily/weekly)
- **Habit Completion Tracking**: Mark habits as completed on specific dates with duplicate prevention
- **User Profile Management**: Update user information (username, email, password)
- **Security**: Password hashing with bcrypt, helmet middleware, JWT authentication
- **Validation**: Comprehensive input validation using express-validator
- **Clean Architecture**: Separation of concerns with controllers, services, repositories, and models
- **Dependency Injection**: Flexible and testable code structure
- **Environment Configuration**: Secure configuration management via dotenv

## Architecture

The application follows a layered architecture:

- **Controllers** (`/controllers`): Handle HTTP requests, validate input, and send responses
- **Services** (`/services`): Contain business logic and orchestrate repository operations
- **Repositories** (`/repositories`): Abstract data access layer (interfaces + MongoDB implementations)
- **Models** (`/models`): Mongoose schemas for MongoDB collections
- **Routes** (`/routes`): Define API endpoints and apply middleware/validators
- **Middleware** (`/middleware`): JWT authentication and error handling
- **Validators** (`/validators`): Express-validator chains for request validation
- **Utils** (`/utils`): Utility functions (token generation)
- **Types** (`/types`): Common type definitions and JSDoc typedefs

## Prerequisites

- Node.js (v14 or higher)
- MongoDB instance (local or cloud)
- npm or yarn package manager

## Setup

1. **Install dependencies**:

   ```bash
   npm install
   ```

2. **Configure environment variables**:
   Create a `.env` file in the server root with the following variables:

   ```env
   DATABASE_URL=mongodb://localhost:27017/your-database
   DB_NAME=habit_tracker
   PORT=3000
   JWT_SECRET=your-access-token-secret
   JWT_REFRESH_SECRET=your-refresh-token-secret
   SALT_ROUNDS=10
   ```

3. **Start the server**:

   ```bash
   # Development mode with auto-reload
   npm run dev

   # Production mode
   npm start
   ```

4. **Generate documentation**:
   ```bash
   npm run docs
   ```
   Documentation will be available at `docs/index.html`

## API Endpoints

### Authentication (`/api/auth`)

- `POST /api/auth/register` — Register a new user account
- `POST /api/auth/login` — Authenticate user and receive tokens
- `POST /api/auth/access-token` — Refresh access token using refresh token

### Habits (`/api/habits`) - Requires Authentication

- `POST /api/habits` — Create a new habit
- `GET /api/habits` — Get paginated list of user's habits
- `PUT /api/habits/:id` — Update a specific habit
- `DELETE /api/habits/:id` — Delete a specific habit
- `POST /api/habits/:id/completions` — Mark habit as completed for a date

### Users (`/api/users`) - Requires Authentication

- `PATCH /api/users/me` — Update authenticated user's profile

## Authentication

All authenticated endpoints require a Bearer token in the Authorization header:

```
Authorization: Bearer <access_token>
```

Access tokens expire after 15 minutes. Use the refresh token endpoint to obtain a new access token.

## Documentation

Comprehensive JSDoc documentation is available for all modules. Generate and view it by:

```bash
npm run docs
```

Then open `docs/index.html` in your browser.

The documentation includes:

- Module descriptions
- Class and interface definitions
- Function signatures with parameters and return types
- Request/response examples
- Type definitions

## Project Structure

```
server/
├── controllers/         # Request handlers
├── services/           # Business logic
├── repositories/       # Data access layer
│   ├── I*Repository.js # Repository interfaces
│   └── Mongoose*.js    # MongoDB implementations
├── models/             # Mongoose schemas
├── routes/             # API route definitions
├── middleware/         # Custom middleware
├── validators/         # Input validation
├── utils/              # Utility functions
├── types/              # Type definitions
├── docs/               # Generated documentation
├── server.js           # Application entry point
├── package.json        # Dependencies and scripts
└── jsdoc.json         # JSDoc configuration
```

## Technologies

- **Runtime**: Node.js
- **Framework**: Express.js
- **Database**: MongoDB with Mongoose ODM
- **Authentication**: JSON Web Tokens (JWT)
- **Security**: bcrypt (password hashing), helmet (HTTP headers)
- **Validation**: express-validator
- **Date Handling**: date-fns
- **Documentation**: JSDoc
- **Development**: nodemon (auto-reload)

## Environment Variables

| Variable             | Description               | Example                      |
| -------------------- | ------------------------- | ---------------------------- |
| `DATABASE_URL`       | MongoDB connection string | `mongodb://localhost:27017/` |
| `DB_NAME`            | Database name             | `habit_tracker`              |
| `PORT`               | Server port               | `3000`                       |
| `JWT_SECRET`         | Secret for access tokens  | `your-secret-key`            |
| `JWT_REFRESH_SECRET` | Secret for refresh tokens | `your-refresh-secret`        |
| `SALT_ROUNDS`        | Bcrypt hashing rounds     | `10`                         |

## License

MIT
