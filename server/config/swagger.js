const swaggerJsdoc = require("swagger-jsdoc");

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Habit Tracker API",
      version: "1.0.0",
      description:
        "API documentation for the Habit Tracker application using Node.js and MongoDB",
      contact: {
        name: "Developer",
      },
    },
    servers: [
      {
        url: "http://localhost:3000/api",
        description: "Local Development Server",
      },
    ],
    components: {
      securitySchemes: {
        bearerAuth: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT",
        },
      },
    },
    security: [
      {
        bearerAuth: [],
      },
    ],
  },
  // Look for swagger definitions in these files
  apis: ["./routes/*.js"],
};

const specs = swaggerJsdoc(options);
module.exports = specs;
