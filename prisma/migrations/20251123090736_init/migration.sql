-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('Male', 'Female', 'Other');

-- CreateEnum
CREATE TYPE "MaritalStatus" AS ENUM ('Single', 'Married', 'Divorced', 'Widowed', 'Separated');

-- CreateTable
CREATE TABLE "presentAddress" (
    "id" TEXT NOT NULL,
    "division" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "upazilaOrThana" TEXT NOT NULL,
    "postOffice" TEXT NOT NULL,
    "postCode" TEXT NOT NULL,
    "block" TEXT NOT NULL,
    "houseNoOrVillage" TEXT NOT NULL,
    "roadNo" TEXT DEFAULT 'n/a',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "presentAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permanentAddress" (
    "id" TEXT NOT NULL,
    "division" TEXT NOT NULL,
    "district" TEXT NOT NULL,
    "upazilaOrThana" TEXT NOT NULL,
    "postOffice" TEXT NOT NULL,
    "postCode" TEXT NOT NULL,
    "block" TEXT NOT NULL,
    "houseNoOrVillage" TEXT NOT NULL,
    "roadNo" TEXT DEFAULT 'n/a',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "permanentAddress_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ContactInformation" (
    "id" TEXT NOT NULL,
    "fullName" TEXT NOT NULL DEFAULT 'n/a',
    "dateOfBirth" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "gender" TEXT NOT NULL DEFAULT 'n/a',
    "occupation" TEXT NOT NULL DEFAULT 'n/a',
    "nid" TEXT NOT NULL DEFAULT 'n/a',
    "mobileNumber" TEXT NOT NULL DEFAULT 'n/a',
    "email" TEXT NOT NULL DEFAULT 'n/a',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "ContactInformation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdditionalInformation" (
    "id" TEXT NOT NULL,
    "fatherName" TEXT DEFAULT 'n/a',
    "motherName" TEXT DEFAULT 'n/a',
    "nationalId" TEXT DEFAULT 'n/a',
    "placeOfBirth" TEXT DEFAULT 'n/a',
    "maritalStatus" "MaritalStatus" DEFAULT 'Single',
    "eTIN" TEXT DEFAULT 'n/a',
    "program" TEXT DEFAULT 'n/a',
    "unit" TEXT DEFAULT 'n/a',
    "prlDate" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "dateofRegularity" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AdditionalInformation_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Employee" (
    "id" TEXT NOT NULL,
    "fullName" TEXT NOT NULL,
    "imageUrl" TEXT NOT NULL,
    "officeEmail" TEXT NOT NULL,
    "personalEmail" TEXT NOT NULL,
    "personalNumber" TEXT NOT NULL,
    "officeNumber" TEXT NOT NULL,
    "employeeType" TEXT NOT NULL,
    "employeeStatus" TEXT NOT NULL,
    "nationality" TEXT NOT NULL,
    "disability" BOOLEAN NOT NULL,
    "gender" "Gender" NOT NULL,
    "religion" TEXT NOT NULL,
    "joiningDesignation" TEXT NOT NULL,
    "currentDesignation" TEXT NOT NULL,
    "dateOfBirth" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dateOfConfirmation" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "bankName" TEXT NOT NULL,
    "branchName" TEXT NOT NULL,
    "accountNumber" TEXT NOT NULL,
    "walletType" TEXT NOT NULL,
    "walletNumber" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "addtionalInformationId" TEXT NOT NULL,
    "presentAddressId" TEXT NOT NULL,
    "permanentAddressId" TEXT NOT NULL,
    "spouseInformationId" TEXT,
    "emergencyContactId" TEXT NOT NULL,

    CONSTRAINT "Employee_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Employee_officeEmail_key" ON "Employee"("officeEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_personalEmail_key" ON "Employee"("personalEmail");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_addtionalInformationId_key" ON "Employee"("addtionalInformationId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_presentAddressId_key" ON "Employee"("presentAddressId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_permanentAddressId_key" ON "Employee"("permanentAddressId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_spouseInformationId_key" ON "Employee"("spouseInformationId");

-- CreateIndex
CREATE UNIQUE INDEX "Employee_emergencyContactId_key" ON "Employee"("emergencyContactId");

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_addtionalInformationId_fkey" FOREIGN KEY ("addtionalInformationId") REFERENCES "AdditionalInformation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_presentAddressId_fkey" FOREIGN KEY ("presentAddressId") REFERENCES "presentAddress"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_permanentAddressId_fkey" FOREIGN KEY ("permanentAddressId") REFERENCES "permanentAddress"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_spouseInformationId_fkey" FOREIGN KEY ("spouseInformationId") REFERENCES "ContactInformation"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Employee" ADD CONSTRAINT "Employee_emergencyContactId_fkey" FOREIGN KEY ("emergencyContactId") REFERENCES "ContactInformation"("id") ON DELETE CASCADE ON UPDATE CASCADE;
