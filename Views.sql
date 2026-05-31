-- Drop and create views with proper formatting

-- 1. Consultant Availability View
DROP VIEW IF EXISTS ConsultantAvailability;
CREATE VIEW ConsultantAvailability AS
SELECT 
    c.ConsultantID, 
    c.ConsultantName, 
    c.Status AS AvailabilityStatus, 
    SUM(ca.HoursWorked) AS TotalHoursWorked
FROM Consultants c
LEFT JOIN Project_Assignments ca 
    ON c.ConsultantID = ca.ConsultantID
GROUP BY c.ConsultantID, c.ConsultantName, c.Status;

-- 2. Project Assignments Details View
DROP VIEW IF EXISTS ProjectAssignmentsDetails;
CREATE VIEW ProjectAssignmentsDetails AS
SELECT 
    p.ProjectID,
    p.ProjectName,
    p.StartDate,
    p.EndDate,
    c.ConsultantName,
    pa.Role,
    pa.HoursWorked
FROM Projects p
JOIN Project_Assignments pa 
    ON p.ProjectID = pa.ProjectID
JOIN Consultants c 
    ON pa.ConsultantID = c.ConsultantID
ORDER BY p.ProjectID;

-- 3. Project Details View
DROP VIEW IF EXISTS ProjectDetails;
CREATE VIEW ProjectDetails AS
SELECT 
    p.ProjectID, 
    p.ProjectName, 
    c.ClientName, 
    s.ServiceType, 
    p.StartDate, 
    p.EndDate, 
    p.Fee
FROM Projects p
JOIN Clients c 
    ON p.ClientID = c.ClientID
LEFT JOIN Services s 
    ON p.ServiceID = s.ServiceID;

-- 4. Consultant Assignments View
DROP VIEW IF EXISTS ConsultantAssignments;
CREATE VIEW ConsultantAssignments AS
SELECT 
    ca.AssignmentID, 
    c.ConsultantName, 
    p.ProjectName, 
    ca.Role, 
    ca.HoursWorked
FROM Project_Assignments ca
JOIN Consultants c 
    ON ca.ConsultantID = c.ConsultantID
JOIN Projects p 
    ON ca.ProjectID = p.ProjectID;

-- 5. Invoice Payment Status View
DROP VIEW IF EXISTS InvoicePaymentStatus;
CREATE VIEW InvoicePaymentStatus AS
SELECT 
    i.InvoiceID, 
    p.ProjectName, 
    s.ServiceType, 
    i.InvoiceDate, 
    i.Amount, 
    i.DueDate, 
    i.Status AS InvoiceStatus, 
    COALESCE(pay.PaymentDate, 'Not Paid') AS PaymentStatus
FROM Invoices i
JOIN Projects p 
    ON i.ProjectID = p.ProjectID
JOIN Services s 
    ON i.ServiceID = s.ServiceID
LEFT JOIN Payments pay 
    ON i.InvoiceID = pay.InvoiceID;

-- 6. Client Project Feedback View
DROP VIEW IF EXISTS ClientProjectFeedback;
CREATE VIEW ClientProjectFeedback AS
SELECT 
    f.FeedbackID, 
    c.ClientName, 
    p.ProjectName, 
    f.FeedbackDate, 
    f.Rating, 
    f.Comments
FROM Feedback f
JOIN Clients c 
    ON f.ClientID = c.ClientID
JOIN Projects p 
    ON f.ProjectID = p.ProjectID;

-- 7. Active Clients Projects View
DROP VIEW IF EXISTS ActiveClientsProjects;
CREATE VIEW ActiveClientsProjects AS
SELECT 
    c.ClientID, 
    c.ClientName, 
    p.ProjectName, 
    p.StartDate, 
    p.EndDate, 
    p.Fee
FROM Clients c
JOIN Projects p 
    ON c.ClientID = p.ClientID
WHERE c.Status = 'Active' 
    AND (p.EndDate IS NULL OR p.EndDate >= CURDATE());

-- 8. Service Revenue By Project View
DROP VIEW IF EXISTS ServiceRevenueByProject;
CREATE VIEW ServiceRevenueByProject AS
SELECT 
    p.ProjectName, 
    s.ServiceType, 
    SUM(i.Amount) AS TotalRevenue
FROM Invoices i
JOIN Projects p 
    ON i.ProjectID = p.ProjectID
JOIN Services s 
    ON i.ServiceID = s.ServiceID
GROUP BY p.ProjectName, s.ServiceType;

-- 9. Client Since Date View
DROP VIEW IF EXISTS ClientSinceDate;
CREATE VIEW ClientSinceDate AS
SELECT 
    c.ClientID, 
    c.ClientName, 
    MIN(p.StartDate) AS ClientSince
FROM Clients c
JOIN Projects p 
    ON c.ClientID = p.ClientID
GROUP BY c.ClientID, c.ClientName;
