-- Create Database

Create database elearning;
use elearning;

-- Create Table learners,courses,purchases.

create table learners(
learner_id int primary key auto_increment,
full_name varchar(100),
Country varchar(100)
);

create table courses(
course_id  int primary key,
course_name varchar(100),
category varchar(100),
unit_price decimal(10,2)
);

create table purchases(
purchase_id  int primary key,
learner_id int,
course_id int,
Quantity int,
purchase_date date,
foreign key (learner_id) references learners(learner_id),
foreign key (course_id) references courses(course_id)
);

-- Insert into Table learners,courses,purchases.

Insert into learners (full_name, country ) values
("Pavithra" , "India"),
("Ramya" , "India"),
("Anna" , "USA"),
("Andrew" , "Germany"),
("Christy" , "Australia");

Insert into courses (course_id, course_name, category, unit_price) values
(101, 'SQL Basics', 'Data', 50.00),
(102, 'Python for Data Science', 'Data', 80.00),
(103, 'UI/UX Design', 'Design', 60.00),
(104, 'Digital Marketing', 'Marketing', 40.00),
(105, 'Machine Learning Intro', 'AI', 100.00);

insert into purchases (purchase_id, learner_id, course_id, quantity, purchase_date) values
(1, 1, 101, 2, '2025-01-10'),
(2, 2, 102, 1, '2025-01-12'),
(3, 3, 103, 3, '2025-01-15'),
(4, 1, 104, 1, '2025-01-18'),
(5, 4, 101, 2, '2025-01-20'),
(6, 5, 105, 1, '2025-01-22'),
(7, 2, 103, 2, '2025-01-25'),
(8, 3, 102, 1, '2025-01-28');

INSERT INTO learners (full_name, country) VALUES
("John", "USA"),
("Maria", "Canada"),
("Arun", "India"),
("Sara", "UK"),
("Liam", "Australia"),
("Chen", "China"),
("Fatima", "UAE"),
("Carlos", "Brazil");

INSERT INTO courses (course_id, course_name, category, unit_price) VALUES
(106, 'Advanced SQL', 'Data', 70.00),
(107, 'Tableau Basics', 'Data', 65.00),
(108, 'Graphic Design Mastery', 'Design', 75.00),
(109, 'SEO Fundamentals', 'Marketing', 45.00);

INSERT INTO purchases (purchase_id, learner_id, course_id, quantity, purchase_date) VALUES
(9, 6, 101, 1, '2025-02-01'),
(10, 7, 102, 2, '2025-02-02'),
(11, 8, 103, 1, '2025-02-03'),
(12, 9, 104, 3, '2025-02-04'),
(13, 10, 105, 1, '2025-02-05'),
(14, 11, 106, 2, '2025-02-06'),
(15, 12, 107, 1, '2025-02-07'),
(16, 13, 108, 2, '2025-02-08'),
(17, 6, 109, 1, '2025-02-09'),
(18, 7, 101, 3, '2025-02-10'),
(19, 8, 102, 2, '2025-02-11'),
(20, 9, 103, 1, '2025-02-12'),
(21, 10, 104, 2, '2025-02-13'),
(22, 11, 105, 1, '2025-02-14'),
(23, 12, 106, 3, '2025-02-15'),
(24, 13, 107, 2, '2025-02-16'),
(25, 6, 108, 1, '2025-02-17'),
(26, 7, 109, 2, '2025-02-18'),
(27, 8, 101, 1, '2025-02-19'),
(28, 9, 102, 2, '2025-02-20');

select * from learners;
select * from courses;
select * from purchases;

-- CORE ANALYSIS

-- Total revenue
select sum(c.unit_price * p.quantity) as Total_revenue
from courses c
join purchases p on c.course_id = p.course_id;

-- Revenue by course
select c.course_id, c.course_name, sum(c.unit_price * p.quantity) as Total_revenue
from courses c
join purchases p on c.course_id = p.course_id
group by c.course_name,c.course_id
order by Total_revenue desc;

-- Top leaners by revenue
select l.full_name, sum(c.unit_price * p.quantity) as Total_revenue 
from courses c
join purchases p on c.course_id = p.course_id
join learners l on l.learner_id = p.learner_id
group by l.full_name
order by Total_revenue desc;

-- Country-wise revenue
select l.country, sum(c.unit_price * p.quantity) as Total_revenue 
from courses c
join purchases p on c.course_id = p.course_id
join learners l on l.learner_id = p.learner_id
group by l.country
order by Total_revenue desc;

-- Most Popular course ( By quantity )
select c.course_name, sum(p.quantity) as Total_quantity
from courses c
join purchases p on c.course_id = p.course_id
group by c.course_name
order by Total_quantity desc; 

-- Repeated Buyers
select l.full_name , count(p.learner_id) as Total_purchase
from purchases p
join learners l on l.learner_id = p.learner_id 
group by l.full_name
having count(p.learner_id) > 1;

-- Joins
SELECT 
l.full_name AS learner_name,
l.country,
c.course_name,
c.category,
p.quantity,
FORMAT(p.quantity * c.unit_price, 2) AS total_amount,
p.purchase_date
FROM purchases p
INNER JOIN learners l ON p.learner_id = l.learner_id
INNER JOIN courses c ON p.course_id = c.course_id
ORDER BY total_amount DESC;

-- All leaners even if there is no purchase ( using left join)
SELECT 
l.full_name,
p.purchase_id,
c.course_name
FROM learners l
LEFT JOIN purchases p ON l.learner_id = p.learner_id
LEFT JOIN courses c ON p.course_id = c.course_id;

-- All courses even if there is no purchase ( using right join)
SELECT 
c.course_name,
p.purchase_id,
l.full_name
FROM purchases p
RIGHT JOIN courses c ON p.course_id = c.course_id
LEFT JOIN learners l ON p.learner_id = l.learner_id;

-- Creating VIEW for purchase summary
Create view purchase_summary AS
SELECT 
l.full_name AS learner_name,
l.country,
c.course_name,
c.category,
p.quantity,
round(sum(p.quantity * c.unit_price), 2) AS total_amount,
p.purchase_date
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id;

select * from purchase_summary;

-- Q1. Display each learner’s total spending (quantity × unit_price) along with their country.
select l.full_name, l.country, round(sum(p.quantity * c.unit_price),2) as total_spending
from purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
group by l.full_name, l.country
order by total_spending ;

-- Q2. Find the top 3 most purchased courses based on total quantity sold.
select c.course_name, sum(p.Quantity) as total_quantity_sold
from purchases p
join courses c ON p.course_id = c.course_id
group by c.course_name
order by total_quantity_sold desc
limit 3;

-- Q3. Show each course category’s total revenue and the number of unique learners who purchased from that category.
SELECT c.category,
ROUND(SUM(p.quantity * c.unit_price), 2) AS total_revenue,
COUNT(DISTINCT p.learner_id) AS unique_learners
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.category;

-- Q4. List all learners who have purchased courses from more than one category
SELECT 
l.full_name,
COUNT(DISTINCT c.category) AS category_count
FROM purchases p
JOIN learners l ON p.learner_id = l.learner_id
JOIN courses c ON p.course_id = c.course_id
GROUP BY l.full_name
HAVING category_count > 1;

-- Q5. Identify courses that have not been purchased at all.

select c.course_name
from courses c
left join purchases p on p.course_id = c.course_id
where p.purchase_id is NULL;

-- Procedure to call course name using course ID

DELIMITER //

CREATE PROCEDURE get_course(IN cid INT)
BEGIN
    SELECT * 
    FROM courses
    WHERE course_id = cid;
END //

DELIMITER ;
CALL get_course(101);
