-- Create database
CREATE DATABASE college;

-- Delete database
DROP DATABASE college;

-- Use database
USE college;

-- Create table
CREATE TABLE
    student (
        rollno INT PRIMARY KEY,
        name VARCHAR(50),
        marks INT NOT NULL,
        grade VARCHAR(1),
        city VARCHAR(20)
    );

-- Create database with a condition
CREATE DATABASE IF NOT EXISTS college;

-- Delete database with a condition
DROP DATABASE IF EXISTS college;

-- Show database list
SHOW DATABASES;

-- Show table list
SHOW TABLES;

-- Show table
SELECT
    *
FROM
    student;

-- Insert data into table
INSERT INTO
    student (rollno, name, marks, grade, city)
VALUES
    (101, "Anil", 78, "C", "Pune"),
    (102, "bhumika", 93, "A", "Mumbai"),
    (103, "chetan", 85, "B", "Mumbai"),
    (104, "dhruv", 96, "A", "Delhi"),
    (105, "emanuel", 12, "F", "Delhi"),
    (106, "farah", 82, "B", "Delhi");

-- Use of foreign key example
CREATE TABLE
    dept (id INT PRIMARY KEY, name VARCHAR(50));

CREATE TABLE
    teacher (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES dept (id)
    );

-- Default values
salary INT DEFAULT 25000;

-- Constraint
-- Check
CREATE TABLE
    city (
        id INT PRIMARY KEY,
        city VARCHAR(50),
        age INT,
        CONSTRAINT age_check CHECK (
            age >= 18
            AND city = "Delhi"
        )
    );

CREATE TABLE
    newTab (age INT CHECK (age >= 18));

-- Select specific column
SELECT
    age
FROM
    student;

-- Select all
SELECT
    *
FROM
    student;

-- Where Clause
-- marks example
SELECT
    *
FROM
    student
WHERE
    marks > 80;

-- city example
SELECT
    *
FROM
    student
WHERE
    city = "Mumbai";

-- Operators
-- AND
SELECT
    *
FROM
    student
WHERE
    marks > 80
    AND city = "Mumbai";

-- OR
SELECT
    *
FROM
    student
WHERE
    marks > 80
    OR city = "Mumbai";

-- BETWEEN
SELECT
    *
FROM
    student
WHERE
    marks BETWEEN 80 AND 90;

-- IN
SELECT
    *
FROM
    student
WHERE
    city IN ("Delhi", "Mumbai");

-- NOT
SELECT
    *
FROM
    student
WHERE
    city NOT IN ("Delhi", "Mumbai");

-- Limit Clause
SELECT
    *
FROM
    student
LIMIT
    3;

-- Order by clause
-- ascending
SELECT
    *
FROM
    student
ORDER BY
    city ASC;

-- descending
SELECT
    *
FROM
    student
ORDER BY
    city DESC;

-- Aggregate functions
-- Maximum
SELECT
    max(marks)
FROM
    student;

-- Average
SELECT
    avg(marks)
FROM
    student;

-- Order by clause with aggregate functions
SELECT
    city,
    count(name)
FROM
    student
GROUP BY
    city;

-- Having clause
SELECT
    count(name),
    city
FROM
    student
GROUP BY
    city
HAVING
    max(marks) > 90;

-- General order 
SELECT
    column (s)
FROM
    table_name
WHERE
    condition
GROUP BY
    column (s)
HAVING
    condition
ORDER BY
    column (s) ASC / DESC;

-- Update data
UPDATE student
SET
    grade = "O"
WHERE
    grade = "A";

-- Delete data
DELETE FROM student
WHERE
    marks < 33;

-- Cascading
CREATE TABLE
    teacher (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        dept_id INT,
        FOREIGN KEY (dept_id) REFERENCES dept (id) ON DELETE CASCADE ON UPDATE CASCADE
    );

-- Alter
-- ADD
ALTER TABLE student
ADD COLUMN age INT NOT NULL DEFAULT 19;

-- Drop
ALTER TABLE student
DROP COLUMN age;

-- Rename
ALTER TABLE stu
RENAME TO student;

-- Change
ALTER TABLE student CHANGE name full_name VARCHAR(50);

-- Modify
ALTER TABLE student MODIFY COLUMN age VARCHAR(2);

-- Truncate
TRUNCATE TABLE student;

-- Joins
-- Inner join example
CREATE TABLE
    stu (student_id INT PRIMARY KEY, name VARCHAR(50));

INSERT INTO
    stu (student_id, name)
VALUES
    (101, "adam"),
    (102, "bob"),
    (103, "casey");

CREATE TABLE
    course (student_id INT PRIMARY KEY, course VARCHAR(50));

INSERT INTO
    course (student_id, course)
VALUES
    (102, "english"),
    (105, "math"),
    (103, "science"),
    (107, "computer science");

SELECT
    *
FROM
    stu
    INNER JOIN course ON stu.student_id = course.student_id;

-- Alias
SELECT
    *
FROM
    stu AS s;

-- Left join
SELECT
    *
FROM
    stu
    LEFT JOIN course ON stu.student_id = course.student_id;

-- Right join
SELECT
    *
FROM
    stu
    LEFT JOIN course ON stu.student_id = course.student_id;

-- Full join
SELECT
    *
FROM
    stu AS a
    LEFT JOIN course AS b ON a.student_id = b.student_id
UNION
SELECT
    *
FROM
    stu AS a
    RIGHT JOIN course AS b ON a.student_id = b.student_id;

-- Left exclusive join
SELECT
    *
FROM
    stu AS a
    LEFT JOIN course AS b ON a.student_id = b.student_id
WHERE
    b.student_id IS NULL;

-- Right exclusive join
SELECT
    *
FROM
    stu AS a
    RIGHT JOIN course AS b ON a.student_id = b.student_id
WHERE
    a.student_id IS NULL;

-- Self join example
CREATE TABLE
    employee (
        id INT PRIMARY KEY,
        name VARCHAR(50),
        manager_id INT
    );

INSERT INTO
    employee (id, name, manager_id)
VALUES
    (101, "adam", 103),
    (102, "bob", 104),
    (103, "casey", NULL),
    (104, "donald", 103);

SELECT
    a.name AS manager_name,
    b.name
FROM
    employee AS a
    JOIN employee AS b ON a.id = b.manager_id;

-- Union ( no duplicate )
SELECT
    name
FROM
    employee
UNION
SELECT
    name
from
    employee;

-- Union all
SELECT
    name
FROM
    employee
UNION ALL
SELECT
    name
from
    employee;

-- Sub query
-- example 1
SELECT
    name,
    marks
FROM
    student
WHERE
    marks > (
        SELECT
            avg(marks)
        FROM
            student
    );

-- example 2
SELECT
    name,
    rollno
FROM
    student
WHERE
    rollno IN (
        SELECT
            rollno
        FROM
            student
        WHERE
            rollno % 2 = 0
    );

-- example 3 (using FROM)
SELECT
    max(marks)
FROM
    (
        SELECT
            *
        FROM
            student
        WHERE
            city = "Delhi"
    ) AS temp;

-- View
CREATE VIEW
    view1 AS
SELECT
    rollno,
    name
FROM
    student;

SELECT
    *
FROM
    view1;