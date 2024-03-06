
--creating a database called "SISDB"
create database SISDB

--creating a table called "Students"
create table Students(
student_id int identity(1,1) primary key,
first_name varchar(50),
last_name varchar(50),
date_of_birth date,
email varchar(50),
phone_number int)

--creating a table called "Teacher"
create table Teacher(
teacher_id int identity(1,1) primary key,
first_name varchar(50),
last_name varchar(50),
email varchar(50))

--creating a table called "Courses"
create table Courses(
course_id int identity(100,1) primary key,
course_name varchar(30),
credits int,
teacher_id int,
foreign key (teacher_id) references Teacher(teacher_id))

create table Enrollments(
enrollment_id int primary key,
student_id int,
foreign key (student_id) references Students(student_id) on delete cascade,
course_id int,
foreign key (course_id) references Courses(course_id) ,
enrollment_date date)

--creating a table called "Payments"
create table Payments(
payment_id int primary key,
student_id int,
foreign key (student_id) references Students(student_id),
amount int,
payment_date date)

--inserting atleast 10 records for each of the following tables
Insert into Students(first_name, last_name,date_of_birth,email,phone_number) 
Values ('anush','c','2003-05-30','anushchinnasamy@gmail.com',1234567890)
select*from Students

--1)Write an SQL query to insert a new student into the "Students" table with the following details: 
--a. First Name: John 
--b. Last Name: Doe 
--c. Date of Birth: 1995-08-15 
--d. Email: john.doe@example.com 
--e. Phone Number: 1234567890 
Insert into Students(first_name,last_name,date_of_birth,email,phone_number)
Values('John','Doe','1995-08-15','doe@example.com',1234567890)
Select * from Students

Insert into Teacher(first_name,last_name,email)
Values('vani','shree','vani@gmail.com')
Select*from Teacher

Insert into Courses(course_name,credits,teacher_id)
Values('dev',10,1)
Select*from Courses

Insert into Enrollments(enrollment_id,student_id,course_id,enrollment_date)
Values(100,1,1,'2024-01-01')
Select*from Enrollments

--Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and  modify their email address. 
Update Teacher
set email ='shree@gmail.com'
where teacher_id=1

Select*from Teacher

--Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course. 
Delete from Enrollments
where student_id=1 and course_id=1

Select*from Enrollments

alter table Teacher
add Teacher_name varchar(50)

Select*from Teacher

--Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables. 
update Courses
set Teacher_id ='3'
where course_id=1

Select*from Courses

alter table Courses
Drop Column Teacher_name

Select*from Courses

Insert into Payments(payment_id,student_id,amount,payment_date)
Values(501,1,50000,'2024-02-10')

Select*from Payments

--Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount
update Payments
set amount=52000
where student_id=2

Select*from Payments

--Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity. 
delete Payments
where student_id=5

delete Students
where student_id=5

Select*from Students

delete Enrollments
where student_id =5
Select*from Enrollments

alter table Enrollments
add student_name varchar(50)

--Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date. 
insert into Enrollments(enrollment_id,student_id,course_id,enrollment_date)
Values(100,1,1,'2024-01-01')

Select* from Enrollments


--TASK 3
--Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.
select student_id, SUM(amount) as TotalPayments
from Payments
where student_id=2
group by student_id

select s.student_id,s.first_name, s.last_name,p.amount,p.payment_id
from Students s
join Payments p 
ON s.student_id=p.student_id

--Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course. Use a JOIN operation between the "Courses" table and the "Enrollments" table. 
select c.course_id,c.course_name , count(e.student_id) as StudentsEnrolled
from Courses c
Left join Enrollments e
on c.course_id=e.course_id
group by c.course_id, c.course_name

--Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments. 
select count(student_id) as Students_Not_Enrolled
from Students
where student_id is Null

Select s.student_id,s.first_name, s.last_name
from Students s
Left join Enrollments e ON s.student_id = e.student_id
where e.student_id IS NULL;

--Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables. 
select s.first_name, s.last_name , c.course_name 
from Students s
Join Enrollments e on s.student_id = e.student_id
Join Courses c on c.course_id= e.course_id

--Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.
select t.first_name, t.last_name, c.course_name
from Teacher t
Join Courses c on t.teacher_id= c.teacher_id


--Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.
select s.first_name, s.last_name , e.enrollment_date, c.course_name
from Students s
Join Enrollments e on e.student_id = s.student_id
Join Courses c on c.course_id = e.course_id

--Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.
select s.student_id,s.first_name, s.last_name 
from Students s
Left Join Payments p on p.student_id = s.student_id
where p.payment_id is null

--Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.

select c.course_name from Courses c
Left Join Enrollments e on c.course_id = e.course_id
where enrollment_date is null

--Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.
Select e1.student_id, s.first_name, s.last_name
from Enrollments e1
join Enrollments e2 ON e1.student_id = e2.student_id and e1.enrollment_id <> e2.enrollment_id
join Students s ON e1.student_id = s.student_id;

--Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments
select t.teacher_id,t.first_name,t.last_name
from Teacher t
left join Courses c
on t.teacher_id = c.teacher_id
where course_id is null


----Task 4 (sub query)
--1. Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.

select AVG(Students_Enrolled) as [Average Students Enrolled]
from  (select course_id, count(student_id) as Students_Enrolled
from Enrollments
Group by course_id ) as Counts


--2.Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount. 
select s.first_name, s.last_name , p.student_id, p.amount from
Students s
join payments p on s.student_id = p.student_id
where p.amount=(
select MAX(amount)
from Payments p)

--3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count. 

select course_id,course_name, max_enrollments
from (select c.course_id, c.course_name, COUNT(student_id) AS max_enrollments
from Enrollments e
join Courses c on e.course_id = c.course_id
group by c.course_id, c.course_name
)as counts
where max_enrollments = (select MAX(num_enrollments)
from (select COUNT(student_id) AS num_enrollments
from Enrollments
group by course_id) as max_enrollments)

--4.Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses. 
select t.teacher_id,t.first_name,t.last_name,
(select  SUM(amount) from Payments p 
join enrollments e on p.student_id = e.student_id
join courses c ON e.course_id = c.course_id
where c.teacher_id = t.teacher_id) as [total payments]
FROM Teacher t;


--5. Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.
select student_id, first_name, last_name
from students
where (select count(distinct course_id) from courses
) = (select count(distinct course_id)
    from enrollments
    where enrollments.student_id = students.student_id
)

--6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments. 
select first_name, last_name
from Teacher
where teacher_id not in (select distinct teacher_id
    from courses
)

--7. Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.
select Avg(age) as [Average age] from(
select datediff(YEAR, date_of_birth, getdate()) as age
from Students) as student_age


--8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records. 
select course_id , course_name
from Courses 
where course_id not in(
select distinct course_id from enrollments)

--9. Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments. 
select  s.student_id,s.first_name,c.course_id,c.course_name,
(select SUM(amount) from Payments p where p.student_id = s.student_id and e.course_id = c.course_id) as [total payments]
from students s
join Enrollments e on s.student_id = e.student_id
join Courses c on e.course_id = c.course_id;


--10. Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one. 
select student_id from(

select student_id,count(amount) as TotalPayments from 
Payments
Group by student_id) as count
where TotalPayments>1

--11. Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments" table and use GROUP BY to calculate the sum of payments for each 
--student. 
select s.student_id,s.first_name, s.last_name,SUM(p.amount) as [Total Payments]
from Students s
left join Payments p on s.student_id = p.student_id
Group by s.student_id, s.first_name,s.last_name

--12. Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments. 
select c.course_name, count(e.student_id) as [Students Enrolled]
from Courses c
left join Enrollments e on c.course_id = e.course_id
group by course_name

--13. Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average. 
select  s.student_id, s.first_name , Avg(p.amount) as [Average amount] from Students s 
left join Payments p on s.student_id = p.student_id
group by s.student_id, s.first_name




