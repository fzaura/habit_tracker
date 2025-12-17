require("dotenv").config();

const requiredEnvs = [
  "PORT",
  "PSQL_URL",
  "DATABASE_URL",
  "DB_NAME",
  "JWT_ACCESS_SECRET",
  "JWT_REFRESH_SECRET",
  "SALT_ROUNDS",
  "NODE_ENV",
];

requiredEnvs.forEach((key) => {
  if (!process.env[key]) {
    throw new Error(
      `FATAL ERROR: Missing required environment variable: ${key}`
    );
  }
});

module.exports = {
  env: process.env.NODE_ENV,
  port: parseInt(process.env.PORT, 10) || 3000,

  psqlUrl: process.env.PSQL_URL,
  mongoUrl: process.env.DATABASE_URL,
  dbName: process.env.DB_NAME,

  jwtAccessSecret: process.env.JWT_ACCESS_SECRET,
  jwtRefreshSecret: process.env.JWT_REFRESH_SECRET,
  saltRounds: parseInt(process.env.SALT_ROUNDS, 10) || 10,
};
