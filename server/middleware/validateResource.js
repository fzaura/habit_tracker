const AppError = require("../utils/AppError");

const validateResource = (schema) => {
  return async (req, res, next) => {
    try {
      const parsed = await schema.parseAsync({
        body: req.body,
        query: req.query,
        params: req.params,
      });

      req.body = parsed.body;
      req.query = parsed.query;
      req.params = parsed.params;

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
