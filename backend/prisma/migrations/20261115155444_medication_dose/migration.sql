/*
  Warnings:

  - A unique constraint covering the columns `[scheduleId,scheduledAt]` on the table `MedicationDose` will be added. If there are existing duplicate values, this will fail.
  - Added the required column `doseQuantity` to the `MedicationDose` table without a default value. This is not possible if the table is not empty.
  - Added the required column `scheduledAt` to the `MedicationDose` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `MedicationDose` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "MedicationDose" ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "doseQuantity" DECIMAL(10,3) NOT NULL,
ADD COLUMN     "notes" TEXT,
ADD COLUMN     "scheduledAt" TIMESTAMP(3) NOT NULL,
ADD COLUMN     "status" "DoseStatus" NOT NULL DEFAULT 'PENDING',
ADD COLUMN     "takenAt" TIMESTAMP(3),
ADD COLUMN     "updatedAt" TIMESTAMP(3) NOT NULL;

-- CreateIndex
CREATE INDEX "MedicationDose_scheduledAt_status_idx" ON "MedicationDose"("scheduledAt", "status");

-- CreateIndex
CREATE UNIQUE INDEX "MedicationDose_scheduleId_scheduledAt_key" ON "MedicationDose"("scheduleId", "scheduledAt");
