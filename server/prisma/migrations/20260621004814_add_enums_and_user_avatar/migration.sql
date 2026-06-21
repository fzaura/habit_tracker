/*
  Warnings:

  - The `status` column on the `goals` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `status` column on the `outbox` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - The `restriction_type` column on the `task_app_locks` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - Changed the type of `action` on the `outbox` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `type` on the `tasks` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `frequency` on the `tasks` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `device_os` on the `user_devices` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "DeviceOs" AS ENUM ('ANDROID', 'IOS', 'WEB');

-- CreateEnum
CREATE TYPE "GoalStatus" AS ENUM ('UPCOMING', 'IN_PROGRESS', 'PAUSED', 'FINISHED');

-- CreateEnum
CREATE TYPE "TaskType" AS ENUM ('FOCUS', 'REMINDER');

-- CreateEnum
CREATE TYPE "TaskFrequency" AS ENUM ('DAILY', 'WEEKLY', 'CUSTOM');

-- CreateEnum
CREATE TYPE "OutboxAction" AS ENUM ('CREATE', 'UPDATE', 'DELETE');

-- CreateEnum
CREATE TYPE "SyncStatus" AS ENUM ('PENDING', 'COMPLETED', 'FAILED');

-- CreateEnum
CREATE TYPE "RestrictionType" AS ENUM ('FULL', 'PARTIAL');

-- DropForeignKey
ALTER TABLE "goals" DROP CONSTRAINT "goals_user_id_fkey";

-- DropForeignKey
ALTER TABLE "outbox" DROP CONSTRAINT "outbox_user_id_fkey";

-- DropForeignKey
ALTER TABLE "task_app_locks" DROP CONSTRAINT "task_app_locks_task_id_fkey";

-- DropForeignKey
ALTER TABLE "task_completion_history" DROP CONSTRAINT "task_completion_history_task_id_fkey";

-- DropForeignKey
ALTER TABLE "task_focus_sessions" DROP CONSTRAINT "task_focus_sessions_task_id_fkey";

-- DropForeignKey
ALTER TABLE "tasks" DROP CONSTRAINT "tasks_goal_id_fkey";

-- DropForeignKey
ALTER TABLE "user_devices" DROP CONSTRAINT "user_devices_user_id_fkey";

-- AlterTable
ALTER TABLE "goals" DROP COLUMN "status",
ADD COLUMN     "status" "GoalStatus" NOT NULL DEFAULT 'UPCOMING';

-- AlterTable
ALTER TABLE "outbox" DROP COLUMN "action",
ADD COLUMN     "action" "OutboxAction" NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" "SyncStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "task_app_locks" DROP COLUMN "restriction_type",
ADD COLUMN     "restriction_type" "RestrictionType" NOT NULL DEFAULT 'FULL';

-- AlterTable
ALTER TABLE "tasks" DROP COLUMN "type",
ADD COLUMN     "type" "TaskType" NOT NULL,
DROP COLUMN "frequency",
ADD COLUMN     "frequency" "TaskFrequency" NOT NULL;

-- AlterTable
ALTER TABLE "user_devices" DROP COLUMN "device_os",
ADD COLUMN     "device_os" "DeviceOs" NOT NULL;

-- CreateTable
CREATE TABLE "user_avatars" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "storage_key" VARCHAR NOT NULL,
    "mime_type" VARCHAR NOT NULL,
    "file_size" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ NOT NULL,
    "deleted_at" TIMESTAMPTZ,

    CONSTRAINT "user_avatars_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_avatars_user_id_key" ON "user_avatars"("user_id");

-- CreateIndex
CREATE INDEX "outbox_status_idx" ON "outbox"("status");

-- AddForeignKey
ALTER TABLE "user_avatars" ADD CONSTRAINT "user_avatars_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "user_devices" ADD CONSTRAINT "user_devices_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "goals" ADD CONSTRAINT "goals_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_goal_id_fkey" FOREIGN KEY ("goal_id") REFERENCES "goals"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "task_app_locks" ADD CONSTRAINT "task_app_locks_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "task_completion_history" ADD CONSTRAINT "task_completion_history_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "task_focus_sessions" ADD CONSTRAINT "task_focus_sessions_task_id_fkey" FOREIGN KEY ("task_id") REFERENCES "tasks"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "outbox" ADD CONSTRAINT "outbox_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
