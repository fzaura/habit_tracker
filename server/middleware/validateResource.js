const validateResource = (schema) => {
  return async (req, res, next) => {
    const { body, query, params } = req;

    try {
      await schema.parseAsync({ body, query, params });
      next();
    } catch (e) {
      return res.status(400).json({ errors: e.errors });
    }
  };
};

module.exports = validateResource;
