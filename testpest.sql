-- Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    Dnumber NUMBER NOT NULL PRIMARY KEY,
    Dname VARCHAR2(50) NOT NULL UNIQUE,
    Mgr_ssn CHAR(9) NOT NULL,
    Mgr_start_date DATE
);

-- Insert data into DEPARTMENT table
INSERT INTO DEPARTMENT (Dname, Dnumber, Mgr_ssn, Mgr_start_date) VALUES
('Research', 5, '333445555', TO_DATE('1988-05-22', 'YYYY-MM-DD')),
('Administration', 4, '987654321', TO_DATE('1995-01-01', 'YYYY-MM-DD')),
('Headquarters', 1, '888665555', TO_DATE('1981-06-19', 'YYYY-MM-DD'));

-- Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    Ssn CHAR(9) NOT NULL PRIMARY KEY,
    Fname VARCHAR2(50) NOT NULL,
    Lname VARCHAR2(50) NOT NULL,
    Address VARCHAR2(100),
    Salary NUMBER(10,2),
    Sex CHAR(1),
    Bdate DATE,
    Super_ssn CHAR(9),
    Dno NUMBER NOT NULL,
    FOREIGN KEY (Super_ssn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Dno) REFERENCES DEPARTMENT(Dnumber)
);

-- Insert data into EMPLOYEE table
INSERT INTO EMPLOYEE (Ssn, Fname, Lname, Address, Salary, Sex, Bdate, Super_ssn, Dno) VALUES
('333445555', 'Franklin', 'Wong', '638 Voss, Houston TX', 40000, 'M', TO_DATE('1965-12-08', 'YYYY-MM-DD'), NULL, 5),
('987654321', 'Jennifer', 'Wallace', '291 Berry, Bellaire TX', 43000, 'F', TO_DATE('1941-06-20', 'YYYY-MM-DD'), NULL, 4),
('888665555', 'James', 'Borg', '450 Stone, Houston TX', 55000, NULL, TO_DATE('1937-11-10', 'YYYY-MM-DD'), NULL, 1),
('123456789', 'John', 'Smith', '731 Fondren, Houston TX', 30000, 'M', TO_DATE('1965-01-09', 'YYYY-MM-DD'), '333445555', 5),
('999887777', 'Alicia', 'Zelaya', '3321 Castle, Spring TX', 25000, 'F', TO_DATE('1968-01-19', 'YYYY-MM-DD'), '987654321', 4),
('666884444', 'Ramesh', 'Narayan', '975 Fire Oak, Humble TX', 38000, 'M', TO_DATE('1962-09-15', 'YYYY-MM-DD'), '333445555', 5),
('453453453', 'Joyce', 'English', '5631 Rice, Houston TX', 25000, 'F', TO_DATE('1972-07-31', 'YYYY-MM-DD'), '333445555', 5),
('987987987', 'Ahmad', 'Jabbar', '980 Dallas, Houston TX', 25000, 'M', TO_DATE('1969-03-29', 'YYYY-MM-DD'), '987654321', 4);

-- Add foreign key constraint to DEPARTMENT
ALTER TABLE DEPARTMENT
ADD CONSTRAINT fk_mgr_ssn
FOREIGN KEY (Mgr_ssn) REFERENCES EMPLOYEE(Ssn);

-- Create PROJECT table
CREATE TABLE PROJECT (
    Pnumber NUMBER NOT NULL PRIMARY KEY,
    Pname VARCHAR2(50) NOT NULL UNIQUE,
    Plocation VARCHAR2(50),
    Dnum NUMBER NOT NULL,
    FOREIGN KEY (Dnum) REFERENCES DEPARTMENT(Dnumber)
);

-- Insert data into PROJECT table
INSERT INTO PROJECT (Pname, Pnumber, Plocation, Dnum) VALUES
('ProductX', 1, 'Bellaire', 5),
('ProductY', 2, 'Sugarland', 5),
('ProductZ', 3, 'Houston', 5),
('Computerization', 10, 'Stafford', 4),
('Reorganization', 20, 'Houston', 1),
('Newbenefits', 30, 'Stafford', 4);

-- Create DEPT_LOCATIONS table
CREATE TABLE DEPT_LOCATIONS (
    Dnumber NUMBER NOT NULL,
    Dlocation VARCHAR2(50) NOT NULL,
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES DEPARTMENT(Dnumber)
);

-- Insert data into DEPT_LOCATIONS table
INSERT INTO DEPT_LOCATIONS (Dnumber, Dlocation) VALUES
(1, 'Houston'),
(4, 'Stafford'),
(5, 'Bellaire'),
(5, 'Houston'),
(5, 'Sugarland');

-- Create WORKS_ON table
CREATE TABLE WORKS_ON (
    Essn CHAR(9) NOT NULL,
    Pno NUMBER NOT NULL,
    Hours NUMBER(3,1) NOT NULL,
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn),
    FOREIGN KEY (Pno) REFERENCES PROJECT(Pnumber)
);

-- Insert data into WORKS_ON table
INSERT INTO WORKS_ON (Essn, Pno, Hours) VALUES
('123456789', 1, 32.5),
('123456789', 2, 7.5),
('666884444', 3, 40.0),
('453453453', 1, 20.0),
('453453453', 2, 20.0),
('333445555', 2, 10.0),
('333445555', 3, 10.0),
('333445555', 10, 10.0),
('333445555', 20, 10.0),
('999887777', 30, 30.0),
('999887777', 10, 10.0),
('987987987', 10, 35.0),
('987987987', 30, 5.0),
('987654321', 30, 20.0),
('987654321', 20, 15.0),
('888665555', 20, 15.0);

-- Create DEPENDENT table
CREATE TABLE DEPENDENT (
    Essn CHAR(9) NOT NULL,
    Dependent_name VARCHAR2(255) NOT NULL,
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR2(50),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES EMPLOYEE(Ssn)
);

-- Insert data into DEPENDENT table
INSERT INTO DEPENDENT (Essn, Dependent_name, Sex, Bdate, Relationship) VALUES
('333445555', 'Alice', 'F', TO_DATE('1986-04-04', 'YYYY-MM-DD'), 'Daughter'),
('333445555', 'Theodore', 'M', TO_DATE('1983-10-25', 'YYYY-MM-DD'), 'Son'),
('333445555', 'Joy', 'F', TO_DATE('1958-05-03', 'YYYY-MM-DD'), 'Spouse'),
('987654321', 'Abner', 'M', TO_DATE('1942-02-28', 'YYYY-MM-DD'), 'Spouse'),
('123456789', 'Michael', 'M', TO_DATE('1988-01-04', 'YYYY-MM-DD'), 'Son'),
('123456789', 'Alice', 'F', TO_DATE('1988-12-30', 'YYYY-MM-DD'), 'Daughter'),
('123456789', 'Elizabeth', 'F', TO_DATE('1967-05-05', 'YYYY-MM-DD'), 'Spouse');
