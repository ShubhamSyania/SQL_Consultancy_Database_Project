-- 1. ALTER TABLE Operations

-- Add a new column 'ClientSince' to the 'Clients' table to store the date since the client joined
ALTER TABLE Clients
ADD COLUMN ClientSince DATE;

-- Update the ClientSince column to the first project start date for each client
UPDATE Clients c
JOIN (
    SELECT ClientID, MIN(StartDate) AS FirstProjectDate
    FROM Projects
    GROUP BY ClientID
) p ON c.ClientID = p.ClientID
SET c.ClientSince = p.FirstProjectDate;


-- Modify the 'FeeRate' column data type in the 'Services' table to allow for two decimal places
ALTER TABLE Services
MODIFY COLUMN FeeRate DECIMAL(10, 2);

-- 2. INSERT Operations

-- Insert a new client into the 'Clients' table
INSERT INTO Clients (ClientName, Industry, ContactInfo, Status, ClientSince)
VALUES ('Future Insights', 'Consulting', 'info@futureinsights.com', 'Active', '2024-01-01');

-- Insert a new project into the 'Projects' table for an existing client
INSERT INTO Projects (ProjectName, ClientID, ServiceID, StartDate, EndDate, Fee)
VALUES ('AI Integration', 5, 2, '2024-02-01', '2024-06-01', 25000.00);

-- Insert a new service into the 'Services' table
INSERT INTO Services (ServiceType, Description, FeeRate)
VALUES ('Cybersecurity Audit', 'Security assessment and penetration testing services', 180.00);

-- Insert a new invoice for an ongoing project in the 'Invoices' table
INSERT INTO Invoices (ProjectID, ServiceID, InvoiceDate, Amount, DueDate, Status)
VALUES (3, 9, '2023-09-01', 7500.00, '2023-09-15', 'Unpaid');

-- 3. UPDATE Operations

-- Update the status of all inactive clients in the 'Clients' table who are in the 'Retail' industry
UPDATE Clients
SET Status = 'Active'
WHERE Status = 'Inactive' AND Industry = 'Retail';

-- Update the end date of a specific project
UPDATE Projects
SET EndDate = '2023-12-31'
WHERE ProjectName = 'E-commerce Website Development' AND ClientID = 1;

-- Increase the fee rate by 10% for 'Software Development' services
UPDATE Services
SET FeeRate = FeeRate * 1.10
WHERE ServiceType = 'Software Development';

-- Update consultant availability based on project assignment completion
UPDATE Consultants
SET Status = 'Available'
WHERE ConsultantID IN (
    SELECT ConsultantID
    FROM Project_Assignments
    WHERE HoursWorked >= 100
);

-- Apply a 10% discount on invoices for 'Marketing' services
UPDATE Invoices AS i
JOIN Services AS s ON i.ServiceID = s.ServiceID
SET i.Amount = i.Amount * 0.90
WHERE s.ServiceType = 'Marketing';

-- 4. DELETE Operations

-- Delete a consultant who is no longer available for any projects
-- DELETE FROM Consultants
-- WHERE ConsultantName = 'Linda Scott' AND Status = 'Unavailable';

-- Delete all clients with an 'Inactive' status
-- DELETE FROM Clients
-- WHERE Status = 'Inactive';
