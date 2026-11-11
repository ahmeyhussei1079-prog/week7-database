
-- =====================================================
-- WEEK 7 ASSIGNMENT: DATABASE DESIGN AND NORMALIZATION
-- =====================================================

-- Create database separately if needed:
-- CREATE DATABASE week7_normalization;

-- =====================================================
-- QUESTION 1: FIRST NORMAL FORM (1NF)
-- =====================================================

-- Create an unnormalized example table

CREATE TABLE student_courses_unnormalized (
    student_id INT,
    student_name VARCHAR(100),
    courses TEXT
);

INSERT INTO student_courses_unnormalized
VALUES
(1, 'Ahmed', 'Database, Mathematics'),
(2, 'John', 'Programming, Networking');

-- Convert to First Normal Form (1NF)
-- Each column contains only one value.

CREATE TABLE students_1nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

CREATE TABLE student_courses_1nf (
    student_id INT,
    course_name VARCHAR(100),
    PRIMARY KEY (student_id, course_name),
    FOREIGN KEY (student_id)
        REFERENCES students_1nf(student_id)
);

INSERT INTO students_1nf VALUES
(1, 'Ahmed'),
(2, 'John');

INSERT INTO student_courses_1nf VALUES
(1, 'Database'),
(1, 'Mathematics'),
(2, 'Programming'),
(2, 'Networking');

-- Display 1NF results

SELECT
    s.student_id,
    s.student_name,
    c.course_name
FROM students_1nf s
JOIN student_courses_1nf c
ON s.student_id = c.student_id;


-- =====================================================
-- QUESTION 2: SECOND NORMAL FORM (2NF)
-- =====================================================

-- Create a table demonstrating partial dependency

CREATE TABLE enrollment_unnormalized (
    student_id INT,
    course_id INT,
    student_name VARCHAR(100),
    course_name VARCHAR(100),
    grade VARCHAR(5),
    PRIMARY KEY (student_id, course_id)
);

INSERT INTO enrollment_unnormalized VALUES
(1, 101, 'Ahmed', 'Database', 'A'),
(1, 102, 'Ahmed', 'Mathematics', 'B'),
(2, 101, 'John', 'Database', 'A'),
(2, 103, 'John', 'Networking', 'B');

-- Convert into Second Normal Form (2NF)
-- Remove partial dependencies by separating tables.

CREATE TABLE students_2nf (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

CREATE TABLE courses_2nf (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments_2nf (
    student_id INT,
    course_id INT,
    grade VARCHAR(5),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id)
        REFERENCES students_2nf(student_id),
    FOREIGN KEY (course_id)
        REFERENCES courses_2nf(course_id)
);

-- Insert student records

INSERT INTO students_2nf VALUES
(1, 'Ahmed'),
(2, 'John');

-- Insert course records

INSERT INTO courses_2nf VALUES
(101, 'Database'),
(102, 'Mathematics'),
(103, 'Networking');

-- Insert enrollment records

INSERT INTO enrollments_2nf VALUES
(1, 101, 'A'),
(1, 102, 'B'),
(2, 101, 'A'),
(2, 103, 'B');

-- Display normalized results

SELECT
    s.student_id,
    s.student_name,
    c.course_id,
    c.course_name,
    e.grade
FROM enrollments_2nf e
JOIN students_2nf s
ON e.student_id = s.student_id
JOIN courses_2nf c
ON e.course_id = c.course_id;


-- =====================================================
-- QUESTION 3: VERIFY TABLES
-- =====================================================

-- Display all students

SELECT * FROM students_1nf;
SELECT * FROM students_2nf;

-- Display all courses

SELECT * FROM courses_2nf;

-- Display all enrollments

SELECT * FROM enrollments_2nf;

-- =====================================================
-- END OF WEEK 7 ASSIGNMENT
-- =====================================================
