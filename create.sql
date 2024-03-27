-- create.sql

-- Use dsci551 database
USE dsci551;

-- Delete 'Course' if exist
DROP TABLE IF EXISTS Course;
-- Create 'Course' dataframe
CREATE TABLE Course (
    number VARCHAR(10) PRIMARY KEY,
    title VARCHAR(255),
    semester VARCHAR(20)
);

-- Delete 'Student' if exist
DROP TABLE IF EXISTS Student;
-- Create 'Student' dataframe
CREATE TABLE Student (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255),
    program VARCHAR(255)
);

-- Delete 'Instructor' if exist
DROP TABLE IF EXISTS Instructor;
-- Create 'Instructor' dataframe
CREATE TABLE Instructor (
    id VARCHAR(10) PRIMARY KEY,
    name VARCHAR(255),
    department VARCHAR(255)
);

-- Delete 'Take' if exist
DROP TABLE IF EXISTS Take;
-- Create 'Take' dataframe
CREATE TABLE Take (
    sid VARCHAR(10),
    cno VARCHAR(10),
    semester VARCHAR(20),
    FOREIGN KEY(sid) REFERENCES Student(id),
    FOREIGN KEY(cno) REFERENCES Course(number)
);

-- Delete 'Teach' if exist
DROP TABLE IF EXISTS Teach;
-- Create 'Teach' dataframe
CREATE TABLE Teach (
    rid VARCHAR(10),
    cno VARCHAR(10),
    semester VARCHAR(20),
    FOREIGN KEY(rid) REFERENCES Instructor(id),
    FOREIGN KEY(cno) REFERENCES Course(number)
);

-- Delete 'TA' if exist
DROP TABLE IF EXISTS TA;
-- Create 'TA' dataframe
CREATE TABLE TA (
    sid VARCHAR(10) PRIMARY KEY,
    hours INT,
    FOREIGN KEY(sid) REFERENCES Student(id)
);

-- Delete 'Assist' if exist
DROP TABLE IF EXISTS Assist;
-- Create 'Assist' dataframe
CREATE TABLE Assist (
    sid VARCHAR(10),
    cno VARCHAR(10),
    semester VARCHAR(20),
    FOREIGN KEY(sid) REFERENCES TA(sid),
    FOREIGN KEY(cno) REFERENCES Course(number)
);
