-- create database name xyz
CREATE DATABASE xyz;

-- use xyz
USE xyz;

-- create table named employee
CREATE TABLE
    employee (id INT PRIMARY KEY, name VARCHAR(50), salary INT);

-- insert data into table
INSERT INTO
    employee (id, name, salary)
VALUES
    (1, "Adam", 25000),
    (2, "Bob", 30000),
    (3, "Casey", 40000);

-- print table
SELECT
    *
FROM
    employee;