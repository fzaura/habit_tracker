const AppError = require("../utils/AppError");

const validateResource = (schema) => {
  return async (req, res, next) => {
    const { body, query, params } = req;

    try {
      const parsed = await schema.parseAsync({ body, query, params });

      body = parsed.body;
      query = parsed.query;
      params = parsed.params;

      next();
    } catch (e) {
      if (e.name === "ZodError") {
        const message = e.errors ? e.errors[0].message : "Invalid input data.";

        next(new AppError(message, 400));
      }

      next(e);
    }
  };
};

module.exports = validateResource;
