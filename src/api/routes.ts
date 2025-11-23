const express = require('express')
const router = express.Router()
const { createEmployee, getAllEmployees, getEmployeeById, updateEmployee, deleteEmployeeById } = require('../controllers/employeeController.js');

router.post("/employees", createEmployee);
router.get("/employees",getAllEmployees);
router.get("/employees/:id", getEmployeeById);
router.put("/employees/:id", updateEmployee);
router.delete("/employess/:id", deleteEmployeeById);


module.exports = router