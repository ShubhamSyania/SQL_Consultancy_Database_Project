-- To See Table and Inserted Values
USE We_Consultancy;

-- 1. View all clients in the Clients table
SELECT * 
FROM Clients;

-- 2. View all services in the Services table
SELECT * 
FROM Services;

-- 3. View all consultants in the Consultants table
SELECT * 
FROM Consultants;

-- 4. View all projects in the Projects table
SELECT * 
FROM Projects;

-- 5. View all project assignments in the Project_Assignments table
SELECT * 
FROM Project_Assignments;

-- 6. View all invoices in the Invoices table
SELECT * 
FROM Invoices;

-- 7. View all payments in the Payments table
SELECT * 
FROM Payments;

-- 8. View all feedback in the Feedback table
SELECT * 
FROM Feedback;

-- To See Created View
-- 1. View Consultant Availability
SELECT * FROM ConsultantAvailability;

-- 2. View Project Assignments Details
SELECT * FROM ProjectAssignmentsDetails;

-- 3. View Project Details
SELECT * FROM ProjectDetails;

-- 4. View Consultant Assignments
SELECT * FROM ConsultantAssignments;

-- 5. View Invoice Payment Status
SELECT * FROM InvoicePaymentStatus;

-- 6. View Client Project Feedback
SELECT * FROM ClientProjectFeedback;

-- 7. View Active Clients Projects
SELECT * FROM ActiveClientsProjects;

-- 8. View Service Revenue By Project
SELECT * FROM ServiceRevenueByProject;

-- 9. View Client Since Date
SELECT * FROM ClientSinceDate;
