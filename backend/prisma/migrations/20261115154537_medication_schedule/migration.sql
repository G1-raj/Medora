-- CreateEnum
CREATE TYPE "ScheduleFrequency" AS ENUM ('DAILY', 'WEEKLY', 'INTERVAL', 'AS_NEEDED');

-- CreateEnum
CREATE TYPE "DoseStatus" AS ENUM ('PENDING', 'TAKEN', 'SKIPPED', 'MISSED');

-- CreateTable
CREATE TABLE "MedicationSchedule" (
    "id" SERIAL NOT NULL,
    "medicationId" INTEGER NOT NULL,
    "frequency" "ScheduleFrequency" NOT NULL,
    "times" TEXT[],
    "weekDays" INTEGER[],
    "intervalHours" INTEGER,
    "doseQuantity" DECIMAL(10,3) NOT NULL,
    "startDate" DATE NOT NULL,
    "endDate" DATE,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MedicationSchedule_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MedicationDose" (
    "id" SERIAL NOT NULL,
    "scheduleId" INTEGER NOT NULL,

    CONSTRAINT "MedicationDose_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "MedicationSchedule_medicationId_idx" ON "MedicationSchedule"("medicationId");

-- CreateIndex
CREATE INDEX "MedicationSchedule_medicationId_isActive_idx" ON "MedicationSchedule"("medicationId", "isActive");

-- AddForeignKey
ALTER TABLE "MedicationSchedule" ADD CONSTRAINT "MedicationSchedule_medicationId_fkey" FOREIGN KEY ("medicationId") REFERENCES "Medication"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MedicationDose" ADD CONSTRAINT "MedicationDose_scheduleId_fkey" FOREIGN KEY ("scheduleId") REFERENCES "MedicationSchedule"("id") ON DELETE CASCADE ON UPDATE CASCADE;
