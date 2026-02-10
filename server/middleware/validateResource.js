const { z } = require("zod");

// ✅ 1. Universal Import Fix
// This works whether AppError is 'module.exports' or 'export default'
const AppErrorImport = require("../utils/AppError");
const AppError = AppErrorImport.default || AppErrorImport;

const validateResource = (schema) => async (req, res, next) => {
  // 2. Use safeParseAsync
  const result = await schema.safeParseAsync({
    body: req.body,
    query: req.query,
    params: req.params,
  });

  // 3. Handle Success
  if (result.success) {
    req.body = result.data.body;
    req.query = result.data.query;
    req.params = result.data.params;
    return next();
  }

  // 4. Handle Failure (CRASH PROOF LOGIC)
  const zodError = result.error;

  // 🔍 Try to find the array of errors in likely places
  // Some Zod versions use .issues, some use .errors
  const issues = zodError.errors || zodError.issues || [];

  // 🔍 Get the first issue safely using optional chaining (?.)
  const firstIssue = issues[0];

  // 🔍 Extract message or use fallback
  const errorMessage = firstIssue?.message || "Invalid input data";

  return next(new AppError(errorMessage, 400));
};

module.exports = validateResource;
