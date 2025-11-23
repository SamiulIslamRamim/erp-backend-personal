// schema.ts
import { z } from "zod";

/**
 * Enums
 */
export const GenderSchema = z.enum(["Male", "Female", "Other"]);
export type Gender = z.infer<typeof GenderSchema>;

export const MaritalStatusSchema = z.enum([
  "Single",
  "Married",
  "Divorced",
  "Widowed",
  "Separated",
]);
export type MaritalStatus = z.infer<typeof MaritalStatusSchema>;

/**
 * Helpers
 */
const uuid = z.string().uuid();
const optionalStringWithNA = z.string().optional(); // some prisma defaults are "n/a" -> allow string or missing
const dateLike = z.preprocess((arg) => {
  if (typeof arg === "string" || arg instanceof Date) return new Date(arg as any);
  return arg;
}, z.date());

/**
 * presentAddress model
 */
export const PresentAddressSchema = z.object({
  id: uuid,
  division: z.string(),
  district: z.string(),
  upazilaOrThana: z.string(),
  postOffice: z.string(),
  postCode: z.string(),
  block: z.string(),
  houseNoOrVillage: z.string(),
  roadNo: z.string().optional().nullable(), // prisma has default "n/a"
  createdAt: dateLike.optional(),
  // relation kept as optional id reference (foreign key present in Employee model)
});
export type PresentAddress = z.infer<typeof PresentAddressSchema>;

/**
 * permanentAddress model
 */
export const PermanentAddressSchema = z.object({
  id: uuid,
  division: z.string(),
  district: z.string(),
  upazilaOrThana: z.string(),
  postOffice: z.string(),
  postCode: z.string(),
  block: z.string(),
  houseNoOrVillage: z.string(),
  roadNo: z.string().optional().nullable(),
  createdAt: dateLike.optional(),
});
export type PermanentAddress = z.infer<typeof PermanentAddressSchema>;

/**
 * ContactInformation model
 */
export const ContactInformationSchema = z.object({
  id: uuid,
  fullName: z.string().optional(),
  dateOfBirth: dateLike.optional(),
  gender: z.string().optional(), // in your model it's String with default "n/a"
  occupation: z.string().optional(),
  nid: z.string().optional(),
  mobileNumber: z.string().optional(),
  email: z.string().optional(),
  createdAt: dateLike.optional(),
  // back relations (employeeSpouseInformation / employeeEmergencyContact) omitted here
});
export type ContactInformation = z.infer<typeof ContactInformationSchema>;

/**
 * AdditionalInformation model
 */
export const AdditionalInformationSchema = z.object({
  id: uuid,
  fatherName: z.string().optional().nullable(),
  motherName: z.string().optional().nullable(),
  nationalId: z.string().optional().nullable(),
  placeOfBirth: z.string().optional().nullable(),
  maritalStatus: MaritalStatusSchema.optional(),
  eTIN: z.string().optional().nullable(),
  program: z.string().optional().nullable(),
  unit: z.string().optional().nullable(),
  prlDate: dateLike.optional().nullable(),
  dateofRegularity: dateLike.optional().nullable(),
  createdAt: dateLike.optional(),
  // employee relation omitted to avoid circular types
});
export type AdditionalInformation = z.infer<typeof AdditionalInformationSchema>;

/**
 * Employee model
 *
 * NOTE: relations are represented by their foreign-key IDs to keep schemas non-recursive.
 * If you want nested creation objects (create with nested relations) you'll need a different schema structure.
 */
export const EmployeeSchema = z.object({
  id: uuid,
  fullName: z.string(),
  imageUrl: z.string(),
  officeEmail: z.string().email(),
  personalEmail: z.string().email(),
  personalNumber: z.string(),
  officeNumber: z.string(),
  employeeType: z.string(),
  employeeStatus: z.string(),
  nationality: z.string(),
  disability: z.boolean(),
  gender: GenderSchema,
  religion: z.string(),
  joiningDesignation: z.string(),
  currentDesignation: z.string(),
  dateOfBirth: dateLike.optional(),
  dateOfConfirmation: dateLike.optional(),
  bankName: z.string(),
  branchName: z.string(),
  accountNumber: z.string(),
  walletType: z.string(),
  walletNumber: z.string(),
  createdAt: dateLike.optional(),
  updatedAt: dateLike.optional(),
  // Relation fields as IDs:
  addtionalInformationId: uuid,
  presentAddressId: uuid,
  permanentAddressId: uuid,
  spouseInformationId: z.string().uuid().optional().nullable(),
  emergencyContactId: uuid,
});
export type Employee = z.infer<typeof EmployeeSchema>;

/**
 * Convenience: Create input schemas (allow omitting id and createdAt/updatedAt where Prisma defaults apply)
 *
 * These are useful for validating incoming create/update payloads.
 */
export const PresentAddressCreateSchema = PresentAddressSchema.omit({ id: true, createdAt: true }).partial({
  division: false, // keep required where appropriate—adjust as you want
  district: false,
  upazilaOrThana: false,
  postOffice: false,
  postCode: false,
  block: false,
  houseNoOrVillage: false,
});

export const AdditionalInformationCreateSchema = AdditionalInformationSchema.omit({
  id: true,
  createdAt: true,
}).partial();

export const ContactInformationCreateSchema = ContactInformationSchema.omit({
  id: true,
  createdAt: true,
}).partial();

export const EmployeeCreateSchema = EmployeeSchema.omit({
  id: true,
  createdAt: true,
  updatedAt: true,
}).partial({
  fullName: false,
  officeEmail: false,
  personalEmail: false,
  personalNumber: false,
  officeNumber: false,
  employeeType: false,
  employeeStatus: false,
  nationality: false,
  disability: false,
  gender: false,
  religion: false,
  joiningDesignation: false,
  currentDesignation: false,
  bankName: false,
  branchName: false,
  accountNumber: false,
  walletType: false,
  walletNumber: false,
  addtionalInformationId: false,
  presentAddressId: false,
  permanentAddressId: false,
  emergencyContactId: false,
});

export type EmployeeCreateInput = z.infer<typeof EmployeeCreateSchema>;
export type AdditionalInformationCreateInput = z.infer<typeof AdditionalInformationCreateSchema>;
export type PresentAddressCreateInput = z.infer<typeof PresentAddressCreateSchema>;
export type ContactInformationCreateInput = z.infer<typeof ContactInformationCreateSchema>;
