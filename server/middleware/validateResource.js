const AppError = require("../utils/AppError").default;
const { ZodError } = require("zod");

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

      return next();
    } catch (e) {
      if (e instanceof ZodError) {
        const firstError = e.errors[0];
        const message = firstError ? firstError.message : "Invalid input data";

        return next(new AppError(message, 400));
      }

      return next(e);
    }
  };
};

module.exports = validateResource;
