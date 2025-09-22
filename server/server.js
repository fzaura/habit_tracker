const express = require("express");
const mongoose = require("mongoose");
const helmet = require("helmet");
const authRoutes = require("./routes/auth.routes");
const habitRoutes = require("./routes/habit.routes");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;
const DATABASE_URL = process.env.DATABASE_URL;
const DB_NAME = process.env.DB_NAME;

app.use(helmet());
app.use(express.json());

app.use("/api/auth", authRoutes);
app.use("/api/habits", habitRoutes);

app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ message: "An internal server error has occurred." });
});

mongoose
  .connect(DATABASE_URL, { dbName: DB_NAME })
  .then(() => {
    console.log("Successfully connected to the database.");
    app.listen(PORT, () => {
      console.log(`Server is running on http://localhost:${PORT}`);
    });
  })
  .catch((err) => {
    console.error("Database connection error: ", err);
    process.exit(1);
  });
