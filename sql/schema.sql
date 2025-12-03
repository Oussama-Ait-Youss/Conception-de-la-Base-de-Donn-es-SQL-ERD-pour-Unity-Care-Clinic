-- ==========================================
--             Database Creation
-- ==========================================

DROP DATABASE IF EXISTS CareClinic; -- Use IF EXISTS to avoid errors if it's new
CREATE DATABASE CareClinic;

USE CareClinic; -- IMPORTANT: Switch to the new database

-- ==========================================
--             Table Creation
-- ==========================================

-- 1. Patients
CREATE TABLE patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender ENUM('Male', 'Female', 'Other'), 
    date_of_birth DATE,
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE, 
    address VARCHAR(255)
);

-- 2. Departments
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT, 
    department_name VARCHAR(50),
    location VARCHAR(100)
);

-- 3. Admissions
CREATE TABLE admissions ( 
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    admission_date DATE,
    discharge_date DATE,
    patient_id INT,
    room_id INT
); 

-- 4. Rooms
CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10),
    room_type ENUM('General', 'Private', 'ICU'),
    availability TINYINT(1) -- Fixed typo: availability
); 

-- 5. Staff 
CREATE TABLE staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    job_title VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    department_id INT
);

-- 6. Doctors
CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(50),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    department_id INT
);

-- 7. Appointments
CREATE TABLE appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_date DATE,
    appointment_time TIME,
    doctor_id INT,
    patient_id INT,
    reason VARCHAR(255)
);

-- 8. Medications
CREATE TABLE medications (
    medication_id INT PRIMARY KEY AUTO_INCREMENT,
    medication_name VARCHAR(100),
    dosage VARCHAR(50) -- Fixed typo: dosage
);

-- 9. Prescriptions (COMPLETELY FIXED)
CREATE TABLE prescriptions (
    prescription_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    medication_id INT,
    prescription_date DATE,
    dosage_instructions VARCHAR(255)
);


-- ==========================================
--          Adding Foreign Keys
-- ==========================================

-- Link Admissions to Patients and Rooms
ALTER TABLE admissions ADD FOREIGN KEY (patient_id) REFERENCES patients(patient_id);
ALTER TABLE admissions ADD FOREIGN KEY (room_id) REFERENCES rooms(room_id);

-- Link Staff to Departments
ALTER TABLE staff ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- Link Doctors to Departments
ALTER TABLE doctors ADD FOREIGN KEY (department_id) REFERENCES departments(department_id);

-- Link Appointments to Doctors and Patients
ALTER TABLE appointments ADD FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id);
ALTER TABLE appointments ADD FOREIGN KEY (patient_id) REFERENCES patients(patient_id);

-- Link Prescriptions to Patients, Doctors, and Medications
ALTER TABLE prescriptions ADD FOREIGN KEY (patient_id) REFERENCES patients(patient_id);
ALTER TABLE prescriptions ADD FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id);
ALTER TABLE prescriptions ADD FOREIGN KEY (medication_id) REFERENCES medications(medication_id);