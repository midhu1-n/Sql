-- Create a database named `education_db` and create the following two tables:
create database education_db;
use education_db;

-- *Course

--  `course_id` – Primary Key, Auto Increment
--  `course_name` – NOT NULL, UNIQUE
--  `duration`
--  `fee`
create table Course(
                    course_id int auto_increment primary key,
                    course_name varchar(50) NOT NULL unique,
                    duration varchar(50),
                    fee int);
-- Student

--  `student_id` – Primary Key, Auto Increment
--  `student_name` – NOT NULL
--  `email` – UNIQUE
--  `age`
--  `gender`
--  `mark`
--  `courseid` – Foreign Key referencing `Course(courseid)`
-- Insert records

create table Student(
					 student_id int auto_increment primary key,
                     student_name varchar(50) not null,
                     email varchar(50) not null,
                     age int,
                     gender enum("Male","Female") default "Male",
                     mark int,
                     courseid int,
                     foreign key(courseid) references Course(course_id));
                     
                     
insert into Course(course_name,duration,fee)
            values('btech','4',75000),
				  ('bca','3',50000),
                  ('bba','3',35000);
                  
INSERT INTO Student(student_name, email, age, gender, mark, courseid)
VALUES
('Midhun', 'mi@gmail.com', 22, 'Male', 85, 1),
('Anjali', 'anjali@gmail.com', 21, 'Female', 92, 1),
('Rahul', 'rahul@gmail.com', 20, 'Male', 78, 2),
('Meera', 'meera@gmail.com', 19, 'Female', 88, 2),
('Arjun', 'arjun@gmail.com', 22, 'Male', 73, 3),
('Neha', 'neha@gmail.com', 20, 'Female', 95, 1),
('Vishnu', 'vishnu@gmail.com', 21, 'Male', 81, 3),
('Athira', 'athira@gmail.com', 19, 'Female', 86, 2),
('Nikhil', 'nikhil@gmail.com', 22, 'Male', 69, 1),
('Diya', 'diya@gmail.com', 20, 'Female', 90, 3);
				   
                  

-- ### Questions

-- 1. Write a query to display all students who scored more than *80 marks, ordered by mark in descending order.
SELECT * FROM Student WHERE mark > 80 ORDER BY mark DESC;

-- 2. Write a query to find the highest mark, lowest mark, and average mark of all students.
SELECT  MAX(mark) AS highest_mark,MIN(mark) AS lowest_mark,AVG(mark) AS average_mark FROM Student;

-- 3. Write a query to display the top 5 students based on their marks.
SELECT * FROM Student ORDER BY mark DESC LIMIT 5;

-- 4. Write a query to display the names and marks of students whose age is between 18 and 25, ordered by age.

SELECT student_name, mark, age FROM Student WHERE age BETWEEN 18 AND 25 ORDER BY age;

-- 5. Write a query to find the number of students in each course.

SELECT courseid, COUNT(*) AS student_count FROM Student GROUP BY courseid;
-- 6. Write a query to display the courses that have more than 2 students.
select c.course_name,count(*) from Course as c inner join Student as s on c.course_id=s.courseid  group by c.course_name having count(*)>2;

-- 7. Write a query to display the student name, mark, and course name using an `INNER JOIN`.
select s.student_name,s.mark,c.course_name from Course as c inner join Student as s on c.course_id=s.courseid;

-- 8. Write a query to display all courses and their students, including courses that have no students, using a `LEFT JOIN`.
select c.course_name,s.student_name,s.mark from Course as c left join Student as s on c.course_id = s.courseid;
-- 9. Write a query to display students whose marks are greater than the overall average mark using a subquery.
select student_name,mark from Student where mark>(select avg(mark) from Student);
-- 10. Write a query to find the second-highest mark and display the student name, mark, and course name using a subquery and `JOIN`.
select s.student_name,s.mark,c.course_name from Student as s inner join Course as c on c.course_id=s.courseid where s.mark=(select max(mark) from Student where mark<(select max(mark) from Student));
