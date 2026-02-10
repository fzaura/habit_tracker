const { z } = require("zod");

const AppError = require("../utils/AppError").default;

const validateResource = (schema) => async (req, res, next) => {
  const result = await schema.safeParseAsync({
    body: req.body,
    query: req.query,
    params: req.params,
  });

  if (result.success) {
    req.body = result.data.body;
    req.query = result.data.query;
    req.params = result.data.params;
    return next();
  }

  const errorParams = result.error.errors[0];

  const errorMessage = errorParams?.message || "Invalid input data";

  return next(new AppError(errorMessage, 400));
};

module.exports = validateResource;
