-- create database
CREATE DATABASE mycollege;

-- use database
USE mycollege;

-- create table student
CREATE TABLE
    student (
        student_id INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(30),
        DOB DATE,
        city VARCHAR(50)
    );

-- insert data into student table
INSERT INTO
    student (
        student_id,
        first_name,
        last_name,
        email,
        DOB,
        city
    )
VALUES
    (
        101,
        'Anil',
        'Sharma',
        'anil.sharma@email.com',
        '2002-05-15',
        'Pune'
    ),
    (
        102,
        'Bhumika',
        'Verma',
        'bhumika.verma@email.com',
        '2001-09-20',
        'Mumbai'
    ),
    (
        103,
        'Chetan',
        'Mehta',
        'chetan.mehta@email.com',
        '2003-01-10',
        'Delhi'
    ),
    (
        104,
        'Dhruv',
        'Singh',
        'dhruv.singh@email.com',
        '2002-12-05',
        'Delhi'
    ),
    (
        105,
        'Emanuel',
        'Das',
        'emanuel.das@email.com',
        '2004-03-22',
        'Chennai'
    );

-- create table course
CREATE TABLE
    course (
        course_id INT PRIMARY KEY,
        course_name VARCHAR(50),
        credits INT,
        instructor_id INT,
        FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id)
    );

-- insert data into course table
INSERT INTO
    course (course_id, course_name, credits, instructor_id)
VALUES
    (201, 'Data Structures', 4, 301),
    (202, 'Database Systems', 3, 301),
    (203, 'Operating Systems', 4, 303),
    (204, 'Web Development', 2, 304),
    (205, 'Mathematics', 3, 302);

-- create table instructor
CREATE TABLE
    instructor (
        instructor_id INT PRIMARY KEY,
        name VARCHAR(50),
        dept VARCHAR(50)
    );

-- insert data into instructor table
INSERT INTO
    instructor (instructor_id, name, dept)
VALUES
    (301, 'Dr. Neha Jain', 'Computer Science'),
    (302, 'Prof. Rakesh Rao', 'Mathematics'),
    (303, 'Dr. Kavita Nair', 'Information Technology'),
    (304, 'Prof. Aamir Khan', 'Computer Science');

-- create table enrollment
CREATE TABLE
    enrollment (
        enroll_id INT PRIMARY KEY,
        student_id INT,
        FOREIGN KEY (student_id) REFERENCES student (student_id),
        course_id INT,
        FOREIGN KEY (course_id) REFERENCES course (course_id),
        semester INT,
        grade VARCHAR(2)
    );

-- insert data into enrollment table
INSERT INTO
    enrollment (enroll_id, student_id, course_id, semester, grade)
VALUES
    (401, 101, 201, 1, 'B'),
    (402, 101, 202, 1, 'A'),
    (403, 102, 201, 1, 'A'),
    (404, 102, 203, 1, 'B'),
    (405, 103, 204, 1, 'C'),
    (406, 104, 202, 1, 'A'),
    (407, 105, 205, 1, 'D'),
    (408, 105, 203, 1, 'B');

-- Queries
-- query 1 : to sort students based on thier city
SELECT
    student_id,
    first_name,
    city
FROM
    student
ORDER BY
    city ASC;

-- query 2 : to find how many students are from each city
SELECT
    city,
    COUNT(first_name) AS Number_of_students
FROM
    student
GROUP BY
    city;

-- query 3 : to find toppers with grade A
SELECT
    a.student_id,
    a.first_name,
    b.grade
FROM
    student AS a
    INNER JOIN enrollment AS b ON a.student_id = b.student_id
WHERE
    b.grade = "A";

-- query 4 : to order students based on the course_id
SELECT
    a.student_id,
    a.first_name,
    b.course_id
FROM
    student AS a
    INNER JOIN enrollment AS b ON a.student_id = b.student_id
ORDER BY
    course_id;

-- query 5 : List students who are enrolled in more than one course
SELECT
    student_id,
    COUNT(course_id) AS course_count
FROM
    enrollment
GROUP BY
    student_id
HAVING
    COUNT(course_id) > 1;

-- query 6 : Find students who have not received grade 'A'
SELECT DISTINCT
    a.student_id,
    a.first_name
FROM
    student AS a
    JOIN enrollment AS b ON a.student_id = b.student_id
WHERE
    b.grade != 'A';

-- query 7 : Get the full student profile along with enrolled course names and grades
SELECT
    s.student_id,
    s.first_name,
    s.last_name,
    c.course_name,
    e.grade
FROM
    student s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN course c ON e.course_id = c.course_id;

-- query 8 : List average grade per course (Assuming grade mapping A=4, B=3, C=2, D=1)
SELECT
    c.course_name,
    AVG(
        CASE grade
            WHEN 'A' THEN 4
            WHEN 'B' THEN 3
            WHEN 'C' THEN 2
            WHEN 'D' THEN 1
        END
    ) AS average_score
FROM
    enrollment e
    JOIN course c ON e.course_id = c.course_id
GROUP BY
    c.course_name;

-- query 9 : Find how many students are enrolled in each course
SELECT
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM
    course c
    LEFT JOIN enrollment e ON c.course_id = e.course_id
GROUP BY
    c.course_name;

-- query 10 : List students who scored the lowest grade ('D') in any course
SELECT
    s.student_id,
    s.first_name,
    c.course_name,
    e.grade
FROM
    student s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN course c ON e.course_id = c.course_id
WHERE
    e.grade = 'D';

-- query 11 : List students with their age (based on DOB)
SELECT
    student_id,
    first_name,
    last_name,
    FLOOR(DATEDIFF (CURDATE (), DOB) / 365) AS age
FROM
    student;

-- query 12 : Find students born after the year 2002
SELECT
    *
FROM
    student
WHERE
    YEAR (DOB) > 2002;

-- query 13 : List students who are not enrolled in any course
SELECT
    *
FROM
    student
WHERE
    student_id NOT IN (
        SELECT
            student_id
        FROM
            enrollment
    );

-- query 14 : List courses with no enrollments
SELECT
    *
FROM
    course
WHERE
    course_id NOT IN (
        SELECT
            course_id
        FROM
            enrollment
    );

-- query 15 : Find all courses taught by each instructor
SELECT
    i.name AS instructor,
    c.course_name
FROM
    instructor i
    JOIN course c ON i.instructor_id = c.instructor_id;

-- query 16 : List student names, course names, and corresponding instructor names
SELECT
    s.first_name AS student,
    c.course_name,
    i.name AS instructor
FROM
    student s
    JOIN enrollment e ON s.student_id = e.student_id
    JOIN course c ON e.course_id = c.course_id
    LEFT JOIN instructor i ON c.instructor_id = i.instructor_id;