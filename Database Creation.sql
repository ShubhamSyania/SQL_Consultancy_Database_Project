DROP DATABASE IF EXISTS we_consultancy;
CREATE DATABASE IF NOT EXISTS We_Consultancy;
USE We_Consultancy;

-- Clients table
CREATE TABLE Clients (
    ClientID INT PRIMARY KEY AUTO_INCREMENT,
    ClientName VARCHAR(255) NOT NULL UNIQUE,
    Industry VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(255) NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Active', 'Inactive'))
);

-- Consultants table
CREATE TABLE Consultants (
    ConsultantID INT PRIMARY KEY AUTO_INCREMENT,
    ConsultantName VARCHAR(255) NOT NULL UNIQUE,
    Specialty VARCHAR(100) NOT NULL,
    HireDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Available', 'Unavailable'))
);

-- Services table
CREATE TABLE Services (
    ServiceID INT PRIMARY KEY AUTO_INCREMENT,
    ServiceType VARCHAR(255) NOT NULL UNIQUE,
    Description TEXT,
    FeeRate DECIMAL(10, 2) NOT NULL CHECK (FeeRate >= 0)
);

-- Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(255) NOT NULL,
    ClientID INT NOT NULL,
    ServiceID INT,
    StartDate DATE NOT NULL,
    EndDate DATE,
    Fee DECIMAL(10, 2) NOT NULL CHECK (Fee >= 0),
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID) ON DELETE CASCADE,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE SET NULL
);

-- Project_Assignments table
CREATE TABLE Project_Assignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectID INT NOT NULL,
    ConsultantID INT,
    Role VARCHAR(100) NOT NULL,
    HoursWorked DECIMAL(5, 2) NOT NULL CHECK (HoursWorked >= 0),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE,
    FOREIGN KEY (ConsultantID) REFERENCES Consultants(ConsultantID) ON DELETE SET NULL
);

-- Invoices table
CREATE TABLE Invoices (
    InvoiceID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectID INT NOT NULL,
    ServiceID INT,
    InvoiceDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount >= 0),
    DueDate DATE NOT NULL,
    Status VARCHAR(50) NOT NULL CHECK (Status IN ('Paid', 'Unpaid', 'Overdue')),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE,
    FOREIGN KEY (ServiceID) REFERENCES Services(ServiceID) ON DELETE SET NULL
);

-- Payments table
CREATE TABLE Payments (
    PaymentID INT PRIMARY KEY AUTO_INCREMENT,
    InvoiceID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10, 2) NOT NULL CHECK (Amount > 0),
    PaymentMethod VARCHAR(50) NOT NULL CHECK (PaymentMethod IN ('Credit Card', 'Bank Transfer', 'Cash', 'Check')),
    FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID) ON DELETE CASCADE
);

-- Feedback table
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectID INT NOT NULL,
    ClientID INT NOT NULL,
    FeedbackDate DATE NOT NULL,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comments TEXT,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE,
    FOREIGN KEY (ClientID) REFERENCES Clients(ClientID) ON DELETE CASCADE
);
