# Habit Tracker Server

A secure RESTful API backend for the Habit Tracker app, built with Node.js, Express.js, and PostgreSQL with Prisma ORM. This server implements a clean architecture with repository pattern, dependency injection via Awilix, and comprehensive input validation.

## Features

- **Authentication**: User registration and login with JWT-based authentication (access & refresh tokens)
- **Habit Management**: Full CRUD operations for habits with frequency tracking (daily/weekly)
- **Habit Completion Tracking**: Mark habits as completed on specific dates with duplicate prevention
- **User Profile Management**: Update user information (username, email, password)
- **Security**: Password hashing with bcrypt, helmet middleware, JWT authentication
- **Validation**: Comprehensive input validation using express-validator
- **Clean Architecture**: Separation of concerns with controllers, services, repositories, and models
- **Dependency Injection**: Awilix container for flexible and testable code structure
- **Environment Configuration**: Secure configuration management via dotenv
- **ORM**: Prisma ORM for type-safe database operations with PostgreSQL
- **Testing**: Jest integration tests for API endpoints

## Architecture

The application follows a layered architecture with dependency injection:

- **Container** (`container.js`): Awilix DI container configuration
- **Controllers** (`/controllers`): Handle HTTP requests, validate input, and send responses
- **Services** (`/services`): Contain business logic and orchestrate repository operations
- **Repositories** (`/repositories`): Abstract data access layer (interfaces + Prisma/MongoDB implementations)
- **Models** (`/models`): Mongoose schemas for MongoDB collections (legacy support)
- **Config** (`/config`): Database configuration (Prisma client singleton)
- **Routes** (`/routes`): Define API endpoints and apply middleware/validators
- **Middleware** (`/middleware`): JWT authentication and error handling
- **Validators** (`/validators`): Express-validator chains for request validation
- **Utils** (`/utils`): Utility functions (token generation)
- **Types** (`/types`): Common type definitions and JSDoc typedefs
- **Tests** (`/tests`): Jest integration tests for API endpoints
- **Prisma** (`/prisma`): Database schema and migrations

## Prerequisites

- Node.js (v14 or higher)
- PostgreSQL database (v12 or higher)
- npm or yarn package manager
- Prisma CLI (installed as dev dependency)

## Setup

1. **Install dependencies**:

   ```bash
   npm install
   ```

2. **Configure environment variables**:
   Create a `.env` file in the server root with the following variables:

   ```env
   # PostgreSQL Database
   PSQL_URL=postgresql://username:password@localhost:5432/habit_tracker

   # Server Configuration
   PORT=3000
   NODE_ENV=development

   # JWT Secrets
   JWT_SECRET=your-access-token-secret
   JWT_REFRESH_SECRET=your-refresh-token-secret

   # Password Hashing
   SALT_ROUNDS=10
   ```

3. **Setup Prisma and database**:

   ```bash
   # Generate Prisma client
   npx prisma generate

   # Run database migrations
   npx prisma migrate deploy

   # (Optional) Seed database
   npx prisma db seed
   ```

4. **Start the server**:

   ```bash
   # Development mode with auto-reload
   npm run dev

   # Production mode
   npm start
   ```

5. **Generate documentation**:
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
├── config/             # Configuration modules
│   └── prisma.js      # Prisma client singleton
├── container.js        # Awilix DI container
├── controllers/        # Request handlers
├── services/          # Business logic
├── repositories/      # Data access layer
│   ├── I*Repository.js        # Repository interfaces
│   ├── Mongoose*.js           # MongoDB implementations (legacy)
│   └── Prisma*.js             # Prisma PostgreSQL implementations
├── models/            # Mongoose schemas (legacy)
├── routes/            # API route definitions
├── middleware/        # Custom middleware
├── validators/        # Input validation
├── utils/             # Utility functions
├── types/             # Type definitions
├── tests/             # Jest integration tests
│   ├── setup.js      # Test environment configuration
│   ├── auth.test.js  # Authentication tests
│   ├── habit.test.js # Habit CRUD tests
│   └── user.test.js  # User profile tests
├── docs/              # Generated JSDoc documentation
├── server.js          # Application entry point
├── package.json       # Dependencies and scripts
└── jsdoc.json        # JSDoc configuration
```

## Technologies

- **Runtime**: Node.js v14+
- **Framework**: Express.js
- **Database**: PostgreSQL v12+ with Prisma ORM
- **Database Adapter**: @prisma/adapter-pg (PostgreSQL connection pooling)
- **Dependency Injection**: Awilix container
- **Authentication**: JSON Web Tokens (JWT) with access & refresh tokens
- **Security**: bcrypt (password hashing), helmet (HTTP headers)
- **Validation**: express-validator
- **Testing**: Jest (integration tests)
- **Documentation**: JSDoc 4.0.4
- **Legacy Support**: MongoDB/Mongoose (optional, co-exists with Prisma)
- **Date Handling**: date-fns
- **Documentation**: JSDoc
- **Development**: nodemon (auto-reload)

## Environment Variables

| Variable             | Description                       | Example                                               |
| -------------------- | --------------------------------- | ----------------------------------------------------- |
| `PSQL_URL`           | PostgreSQL connection string      | `postgresql://user:pass@localhost:5432/habit_tracker` |
| `PORT`               | Server port                       | `3000`                                                |
| `NODE_ENV`           | Environment mode                  | `development` or `production`                         |
| `JWT_SECRET`         | Secret for access tokens (15min)  | `your-access-token-secret`                            |
| `JWT_REFRESH_SECRET` | Secret for refresh tokens (7days) | `your-refresh-token-secret`                           |
| `SALT_ROUNDS`        | Bcrypt password hashing rounds    | `10`                                                  |

## License

MIT
