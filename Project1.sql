CREATE DATABASE mycollege;

USE mycollege;

CREATE TABLE
    student (
        student_id INT PRIMARY KEY,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(30),
        DOB DATE,
        city VARCHAR(50)
    );

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

SELECT
    *
FROM
    student;

CREATE TABLE
    course (
        course_id INT PRIMARY KEY,
        course_name VARCHAR(50),
        credits INT
    );

INSERT INTO
    course (course_id, course_name, credits)
VALUES
    (201, 'Data Structures', 4),
    (202, 'Database Systems', 3),
    (203, 'Operating Systems', 4),
    (204, 'Web Development', 2),
    (205, 'Mathematics', 3);

SELECT
    *
FROM
    course;

CREATE TABLE
    instructor (
        instructor_id INT PRIMARY KEY,
        name VARCHAR(50),
        dept VARCHAR(50)
    );

INSERT INTO
    instructor (instructor_id, name, dept)
VALUES
    (301, 'Dr. Neha Jain', 'Computer Science'),
    (302, 'Prof. Rakesh Rao', 'Mathematics'),
    (303, 'Dr. Kavita Nair', 'Information Technology'),
    (304, 'Prof. Aamir Khan', 'Computer Science');

SELECT
    *
FROM
    instructor;

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

SELECT
    *
FROM
    enrollment;