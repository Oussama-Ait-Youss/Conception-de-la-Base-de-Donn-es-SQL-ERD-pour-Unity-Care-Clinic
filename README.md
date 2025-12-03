## Unity Care Clinic Database System 

##  Project Overview

Unity Care Clinic is a comprehensive hospital management database designed to centralize and securely manage operational data. The goal of this project was to architect a high-performance database capable of handling complex hospital workflows including patient admissions, staff management, room allocation, and medical prescriptions.

This project was developed as part of a 3-day intensive database sprint.

##  Functional Scope

The database supports the following core hospital operations:

    Staff Management: Tracking doctors, administrative staff, and departments.

    Patient Care: Managing patient profiles, medical history, and admissions.

    Facility Management: Monitoring room capacity and assignments.

    Scheduling: Planning and tracking medical appointments.

    Pharmacy: Managing medication inventory and prescriptions.

## Database Schema

The architecture consists of several normalized tables joined by relational keys. (Note: The full Entity-Relationship Diagram (ERD) is available in the docs/ folder).

    patients: Personal and contact info.

    doctors: Medical staff and their specialties.

    departments: Hospital divisions (Cardiology, Oncology, etc.).

    appointments: Scheduling logs linking patients and doctors.

    admissions: Records of hospital stays and discharges.

    rooms: Facility capacity management.

    medications & prescriptions: Tracking treatments.

## SQL Implementation & Challenges

This repository contains SQL scripts covering 25+ distinct scenarios, ranging from basic CRUD operations to complex analytical queries.

1. Fundamental Operations

    CRUD: Creating patients, updating department names, deleting outdated records.

    Filtering & Sorting: Using WHERE, ORDER BY, LIMIT, and DISTINCT to extract specific datasets (e.g., top 3 doctors, patients born after 2000).

2. Advanced Analysis

    Aggregations: Utilizing COUNT, AVG, MAX, and SUM to generate reports (e.g., average patient age, total admissions per room).

    Logic & Conditionals: Implementation of CASE statements to categorize patients (Child/Adult/Senior).

    Grouping: Using GROUP BY and HAVING to analyze department stats and patient demographics.

3. Complex Relationships (Joins)

    Standard Joins: Linking appointments to doctors and patients.

    Advanced Scenarios:

        Tracking patients and their primary care physicians.

        Listing appointments by department.

        Analyzing medication prescriptions per doctor.

        Correlating admissions with specific room allocations.

4. Performance & Integrity

    Views: Created views for "Active Admissions" to simplify access to real-time data.

    Constraints: Applied UNIQUE, CHECK, and Foreign Keys to ensure data quality.

    Optimization: Logic for indexing high-traffic columns (IDs, Dates).


## Repository Structure

```
├── assets/
│   └── erd_diagram.png       # Entity-Relationship Diagram
├── sql/
│   ├── schema.sql            # Table creation
│   ├── data.sql              # Mock data insertion
│   └── queries.sql           # Solutions to the 25 exercises
├── README.md                 # Project documentation
```

## Project Context

    Timeline: December 1, 2025 – December 3, 2025

    Format: Individual Sprint

    Evaluation: Based on ERD clarity, SQL query optimization, and data integrity implementation.


    

- Author: Ait Youss Oussama

- Formation: YouCode
