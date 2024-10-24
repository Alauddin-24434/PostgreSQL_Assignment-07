-- Assignment: PostgreSQL Assignment for University Database

-- Database Setup
-- Create the database if not exists
CREATE DATABASE university_db;

-- Connect to the database
\c university_db;

-- Table Creation

-- Create the "students" table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    email VARCHAR(100),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- Create the "courses" table
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Create the "enrollment" table
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

-- Sample Data Insertion

-- Insert sample data into "students" table
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) 
VALUES 
('Sameer', 21, 'sameer@example.com', 48, 60, NULL),
('Zoya', 23, 'zoya@example.com', 52, 58, NULL),
('Nabil', 22, 'nabil@example.com', 37, 46, NULL),
('Rafi', 24, 'rafi@example.com', 41, 40, NULL),
('Sophia', 22, 'sophia@example.com', 50, 52, NULL),
('Hasan', 23, 'hasan@gmail.com', 43, 39, NULL);

-- Insert sample data into "courses" table
INSERT INTO courses (course_name, credits) 
VALUES 
('Next.js', 3),
('React.js', 4),
('Databases', 3),
('Prisma', 3);

-- Insert sample data into "enrollment" table
INSERT INTO enrollment (student_id, course_id) 
VALUES 
(1, 1),
(1, 2),
(2, 1),
(3, 2);

-- Queries

-- Query 1: Insert a new student record
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status) 
VALUES ('Alauddin', 24, 'muhammadalauddin24434@gmail.com', 50, 58, NULL);

-- Query 2: Retrieve students enrolled in 'Next.js'
SELECT student_name 
FROM students 
JOIN enrollment ON students.student_id = enrollment.student_id 
JOIN courses ON enrollment.course_id = courses.course_id 
WHERE courses.course_name = 'Next.js';

-- Query 3: Update status of the student with the highest total marks
UPDATE students 
SET status = 'Awarded' 
WHERE student_id = (
    SELECT student_id 
    FROM students 
    ORDER BY (frontend_mark + backend_mark) DESC 
    LIMIT 1
);

-- Query 4: Delete courses with no students enrolled
DELETE FROM courses 
WHERE course_id NOT IN (SELECT DISTINCT course_id FROM enrollment);

-- Query 5: Retrieve names of students with LIMIT and OFFSET
SELECT student_name 
FROM students 
ORDER BY student_id 
LIMIT 2 OFFSET 2;

-- Query 6: Retrieve course names and number of students enrolled
SELECT courses.course_name, COUNT(enrollment.student_id) AS students_enrolled 
FROM courses 
LEFT JOIN enrollment ON courses.course_id = enrollment.course_id 
GROUP BY courses.course_name;

-- Query 7: Calculate average age of all students
SELECT AVG(age) AS average_age 
FROM students;

-- Query 8: Retrieve students with email containing 'example.com'
SELECT student_name 
FROM students 
WHERE email LIKE '%example.com%';

