DROP DATABASE IF EXISTS company_training;

-- STEP 1: CREATE DATABASE
CREATE DATABASE company_training;
USE company_training;

-- STEP 2: CREATE DEPARTMENTS TABLE
CREATE TABLE departments (
    department_id INT NOT NULL,
    dept_name VARCHAR(80) NOT NULL,
    city VARCHAR(60)
);

-- STEP 3: CREATE EMPLOYEES TABLE
CREATE TABLE employees (
    employee_id INT NOT NULL,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(120),
    department_id INT NOT NULL,
    salary DECIMAL(10,2),
    status VARCHAR(20)
);


-- Add PRIMARY KEY to departments
ALTER TABLE departments
ADD CONSTRAINT pk_departments PRIMARY KEY (department_id);

-- Add PRIMARY KEY to employees
ALTER TABLE employees
ADD CONSTRAINT pk_employees PRIMARY KEY (employee_id);

-- Add location column to departments
ALTER TABLE departments
ADD COLUMN location VARCHAR(100);

-- Rename dept_name to department_name
ALTER TABLE departments
RENAME COLUMN dept_name TO department_name;

-- Modify salary to DECIMAL(12,2) NOT NULL
-- Check NULL values before executing
SELECT * FROM employees WHERE salary IS NULL;

-- After resolving any NULL salary values:
ALTER TABLE employees
MODIFY COLUMN salary DECIMAL(12,2) NOT NULL;

-- Set default value of status to Active
ALTER TABLE employees
ALTER COLUMN status SET DEFAULT 'Active';

-- Add UNIQUE constraint to email
ALTER TABLE employees
ADD CONSTRAINT uq_employees_email UNIQUE (email);

-- Rename employees table to staff
RENAME TABLE employees TO staff;

-- Add FOREIGN KEY to staff table
ALTER TABLE staff
ADD CONSTRAINT fk_staff_department
FOREIGN KEY (department_id)
REFERENCES departments(department_id);

-- Drop UNIQUE constraint from email
ALTER TABLE staff
DROP INDEX uq_employees_email;

-- Drop FOREIGN KEY constraint
ALTER TABLE staff
DROP FOREIGN KEY fk_staff_department;

-- Drop PRIMARY KEY from staff
ALTER TABLE staff
DROP PRIMARY KEY;

-- Add PRIMARY KEY again
ALTER TABLE staff
ADD CONSTRAINT pk_staff PRIMARY KEY (employee_id);


-- Drop location column
ALTER TABLE departments
DROP COLUMN location;

-- Rename database using MySQL-supported operations

CREATE DATABASE company_management;

RENAME TABLE
company_training.departments
TO company_management.departments,
company_training.staff
TO company_management.staff;

DROP DATABASE company_training;

-- FINAL VERIFICATION
USE company_management;

SHOW TABLES;

DESCRIBE departments;

DESCRIBE staff;

SHOW CREATE TABLE departments;

SHOW CREATE TABLE staff;
