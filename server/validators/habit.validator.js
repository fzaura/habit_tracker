const { z } = require("zod");

const nameRule = z
  .string()
  .trim()
  .min(1, "Name is required.")
  .max(100, "Name cannot exceed 100 characters.");

const goalRule = z
  .string()
  .trim()
  .min(1, "Goal is required.")
  .max(100, "Goal cannot exceed 100 characters.");

const frequencySchema = z.discriminatedUnion("type", [
  z.object({ type: z.literal("daily") }),
  z.object({
    type: z.literal("weekly"),
    daysOfWeek: z
      .array(
        z
          .number()
          .int()
          .min(0, "Invalid day selected.")
          .max(6, "Invalid day selected."),
      )
      .nonempty("Weekly habits must have at least one selected day."),
  }),
  z.object({
    type: z.literal("custom"),
    interval: z.number().int().min(1, "Interval must be one day at least."),
  }),
]);

const optionalDateRule = z
  .string()
  .regex(/^\d{4}-\d{2}-\d{2}$/, "Date must be in YYYY-MM-DD format.")
  .nullable()
  .optional();

const strictDateRule = z
  .string()
  .regex(/^\d{4}-\d{2}-\d{2}$/, "Date must be in YYYY-MM-DD format.");

const idRule = z.uuid("Invalid ID.");

module.exports = {
  createHabitSchema: z.object({
    body: z.object({
      name: nameRule,
      goal: goalRule,
      frequency: frequencySchema,
      endDate: optionalDateRule,
    }),
  }),

  updateHabitSchema: z.object({
    body: z
      .object({
        name: nameRule,
        goal: goalRule,
        frequency: frequencySchema,
        endDate: optionalDateRule,
      })
      .partial(),

    params: z.object({
      id: idRule,
    }),
  }),

  markCompleteSchema: z.object({
    body: z.object({
      date: strictDateRule,
    }),
    params: z.object({
      id: idRule,
    }),
  }),

  validateIdParamSchema: z.object({
    params: z.object({
      id: idRule,
    }),
  }),
};
