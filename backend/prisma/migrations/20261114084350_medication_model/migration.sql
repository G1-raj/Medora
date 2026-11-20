-- CreateEnum
CREATE TYPE "StrengthUnit" AS ENUM ('MCG', 'µg', 'MG', 'G', 'mL', 'mg/mL', 'mcg/mL', 'mg/5 mL', '%', 'IU', 'mEq', 'mmol', 'Units');

-- CreateEnum
CREATE TYPE "Status" AS ENUM ('ACTIVE', 'INACTIVE');

-- CreateEnum
CREATE TYPE "MedicationForm" AS ENUM ('TABLET', 'CAPSULE', 'LIQUID', 'OTHER');

-- CreateTable
CREATE TABLE "Medication" (
    "id" SERIAL NOT NULL,
    "userId" INTEGER NOT NULL,
    "medicineName" TEXT NOT NULL,
    "medicineComposition" TEXT[],
    "strength" DECIMAL(10,3) NOT NULL,
    "strengthUnit" "StrengthUnit" NOT NULL DEFAULT 'MG',
    "medicineForm" "MedicationForm" NOT NULL DEFAULT 'TABLET',
    "medicineDirection" TEXT NOT NULL,
    "reasonForMedication" TEXT,
    "status" "Status" NOT NULL DEFAULT 'ACTIVE',
    "startDate" DATE NOT NULL,
    "endDate" DATE,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Medication_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "Medication_userId_idx" ON "Medication"("userId");

-- CreateIndex
CREATE INDEX "Medication_userId_status_idx" ON "Medication"("userId", "status");

-- AddForeignKey
ALTER TABLE "Medication" ADD CONSTRAINT "Medication_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;
