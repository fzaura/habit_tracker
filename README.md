# 📱 Habit Tracker

A production-ready full-stack habit tracking application that empowers users to build and maintain healthy routines through intuitive mobile interfaces and a robust backend infrastructure.

## ✨ Features

### Core Functionality

- 🔐 **Secure Authentication** — User registration and login with JWT-based access & refresh tokens
- ✅ **Habit Management** — Create, update, delete, and track daily/weekly habits
- 📊 **Progress Tracking** — Mark habit completions and view historical data
- 👤 **Profile Management** — Update username, email, and password
- 🔄 **Real-time Sync** — Seamless data synchronization between mobile and backend

### Technical Highlights

- 🛡️ **Enterprise Security** — bcrypt password hashing, helmet middleware, JWT authentication
- 🏗️ **Clean Architecture** — Separation of concerns with controllers, services, and repositories
- 💉 **Dependency Injection** — Awilix container for flexible, testable code
- 🗄️ **Type-safe Database** — Prisma ORM with PostgreSQL for reliable data operations
- ✅ **Input Validation** — Comprehensive request validation with express-validator
- 🧪 **Integration Tests** — Jest test suite for API endpoints
- 📚 **Complete Documentation** — JSDoc documentation for all server modules

## 🛠️ Tech Stack

### Frontend

- **Framework:** Flutter 3.x (Dart)
- **State Management:** Provider / Riverpod
- **Architecture:** Clean Architecture with MVVM pattern
- **HTTP Client:** Dio with interceptors
- **Platforms:** Android, iOS, Web, Windows, macOS, Linux

### Backend

- **Runtime:** Node.js v14+
- **Framework:** Express.js
- **Database:** PostgreSQL v12+ with Prisma ORM
- **Authentication:** JWT (JSON Web Tokens)
- **Security:** bcrypt, helmet, CORS
- **Validation:** express-validator
- **DI Container:** Awilix
- **Testing:** Jest
- **Documentation:** JSDoc 4.0.4

## 📁 Project Structure

```
habit_tracker/
├── mobile_frontend/
│   └── habit_tracker_frontend/    # Flutter mobile application
│       ├── lib/
│       │   ├── app/               # App-level configuration
│       │   ├── core/              # Core utilities and constants
│       │   ├── data/              # Data sources and repositories
│       │   ├── domain/            # Business logic and entities
│       │   └── presentation/      # UI components and screens
│       ├── test/                  # Flutter widget tests
│       └── pubspec.yaml           # Flutter dependencies
│
└── server/                        # Node.js backend API
    ├── config/                    # Configuration files
    ├── container.js               # Awilix DI container
    ├── controllers/               # Request handlers
    ├── services/                  # Business logic layer
    ├── repositories/              # Data access layer
    │   ├── Prisma*.js            # PostgreSQL implementations
    │   └── Mongoose*.js          # MongoDB implementations (legacy)
    ├── models/                    # Mongoose schemas (legacy)
    ├── routes/                    # API route definitions
    ├── middleware/                # Custom middleware
    ├── validators/                # Request validation
    ├── utils/                     # Utility functions
    ├── tests/                     # Jest integration tests
    ├── docs/                      # Generated JSDoc documentation
    └── server.js                  # Application entry point
```

## 🚀 Getting Started

### Prerequisites

**Backend Requirements:**

- Node.js v14 or higher
- PostgreSQL v12 or higher
- npm or yarn package manager
- Prisma CLI (`npm install -g prisma`)

**Frontend Requirements:**

- Flutter SDK 3.x
- Dart SDK 2.19+
- Android Studio / Xcode (for mobile development)
- Visual Studio / Xcode (for desktop development)

### Installation

#### 1. Clone the Repository

```bash
git clone https://github.com/fzaura/habit_tracker.git
cd habit_tracker
```

#### 2. Backend Setup

```bash
# Navigate to server directory
cd server

# Install dependencies
npm install

# Create .env file
cat > .env << EOF
# PostgreSQL Database
PSQL_URL=postgresql://username:password@localhost:5432/habit_tracker

# Server Configuration
PORT=3000
NODE_ENV=development

# JWT Secrets (generate secure random strings)
JWT_SECRET=your-access-token-secret-here
JWT_REFRESH_SECRET=your-refresh-token-secret-here

# Password Hashing
SALT_ROUNDS=10
EOF

# Generate Prisma client
npx prisma generate

# Run database migrations
npx prisma migrate deploy

# (Optional) Seed database with test data
npx prisma db seed

# Start development server with hot-reload
npm run dev

# Or start in production mode
npm start
```

#### 3. Frontend Setup

```bash
# Navigate to frontend directory
cd mobile_frontend/habit_tracker_frontend

# Install Flutter dependencies
flutter pub get

# Run code generation (if using freezed/json_serializable)
flutter pub run build_runner build --delete-conflicting-outputs

# Run on connected device or emulator
flutter run

# Or build for specific platform
flutter build apk           # Android
flutter build ios           # iOS
flutter build web           # Web
flutter build windows       # Windows
```

## 📖 API Documentation

The backend server includes comprehensive JSDoc documentation for all modules, classes, and functions.

**To view documentation:**

```bash
cd server
npm run docs
open docs/index.html  # macOS
start docs/index.html # Windows
```

### Key Endpoints

**Authentication** (`/api/auth`)

- `POST /api/auth/register` — Register new user
- `POST /api/auth/login` — Authenticate and receive tokens
- `POST /api/auth/access-token` — Refresh access token

**Habits** (`/api/habits`) _Requires Authentication_

- `POST /api/habits` — Create new habit
- `GET /api/habits` — Get paginated habits list
- `PUT /api/habits/:id` — Update habit
- `DELETE /api/habits/:id` — Delete habit
- `POST /api/habits/:id/completions` — Mark habit completed

**Users** (`/api/users`) _Requires Authentication_

- `PATCH /api/users/me` — Update user profile

## 🧪 Testing

### Backend Tests

```bash
cd server

# Run all integration tests
npm test

# Run with coverage report
npm run test:coverage

# Run specific test suite
npm test -- auth.test.js
```

### Frontend Tests

```bash
cd mobile_frontend/habit_tracker_frontend

# Run all widget tests
flutter test

# Run with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

## 🔧 Development

### Backend Development

```bash
cd server

# Development mode with auto-reload
npm run dev

# Generate updated documentation
npm run docs

# Run linter
npm run lint

# Format code
npm run format
```

### Frontend Development

```bash
cd mobile_frontend/habit_tracker_frontend

# Run in debug mode
flutter run

# Run in profile mode
flutter run --profile

# Run in release mode
flutter run --release

# Analyze code
flutter analyze
```

## 🏗️ Architecture

### Backend Architecture

The server follows **Clean Architecture** principles with clear separation of concerns:

1. **Controllers** — Handle HTTP requests/responses, input validation
2. **Services** — Implement business logic and orchestrate operations
3. **Repositories** — Abstract data access with interface-based design
4. **Models** — Define data structures (Mongoose schemas for legacy support)
5. **Middleware** — Handle cross-cutting concerns (authentication, logging)
6. **Validators** — Validate and sanitize user input
7. **Utils** — Reusable utility functions
8. **Container** — Awilix dependency injection for loose coupling
9. **Config** — Centralized configuration (Prisma client, database connections)

### Frontend Architecture

The Flutter app implements **Clean Architecture** with MVVM pattern:

1. **Presentation Layer** — UI widgets, view models, state management
2. **Domain Layer** — Business entities, use cases, repository interfaces
3. **Data Layer** — API clients, repository implementations, DTOs
4. **Core Layer** — Constants, utilities, shared functionality

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Standards

- Backend: Follow JSDoc documentation standards
- Frontend: Follow Flutter/Dart style guide
- Write tests for new features
- Ensure all tests pass before submitting PR

## 📝 Environment Variables

### Backend (.env)

| Variable             | Description                       | Example                                               |
| -------------------- | --------------------------------- | ----------------------------------------------------- |
| `PSQL_URL`           | PostgreSQL connection string      | `postgresql://user:pass@localhost:5432/habit_tracker` |
| `PORT`               | Server port                       | `3000`                                                |
| `NODE_ENV`           | Environment mode                  | `development` or `production`                         |
| `JWT_SECRET`         | Secret for access tokens (15min)  | `your-access-token-secret`                            |
| `JWT_REFRESH_SECRET` | Secret for refresh tokens (7days) | `your-refresh-token-secret`                           |
| `SALT_ROUNDS`        | Bcrypt password hashing rounds    | `10`                                                  |

## 🐛 Known Issues

- Flutter web may have CORS issues in development (use Chrome with --disable-web-security flag)
- Prisma migrations require PostgreSQL superuser privileges for certain operations

## 📋 Roadmap

- [ ] Push notifications for habit reminders
- [ ] Social features (share progress with friends)
- [ ] Analytics dashboard with charts
- [ ] Habit streaks and achievements
- [ ] Dark mode support
- [ ] Multi-language support (i18n)
- [ ] Cloud backup and sync
- [ ] Offline mode with local storage

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**fzaura**

- GitHub: [@fzaura](https://github.com/fzaura)

**AserCodez**

- GitHub: [@AserCodez](https://github.com/AserCodez)

## 🙏 Acknowledgments

- Flutter team for the amazing cross-platform framework
- Prisma team for the excellent ORM
- Express.js community for middleware and best practices
- All open-source contributors

---

**Built with ❤️ using Flutter and Node.js**
