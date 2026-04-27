# Project-E-Learning-Sales-Learner-Analysis-SQL-Power-BI

This project analyzes an E-Learning platform database using SQL. It focuses on understanding learner behavior, course performance, and revenue trends.

The database consists of three main tables:

learners → stores user details
courses → contains course information
purchases → tracks transactions


**Database Schema**

**Learners Table**
learner_id (Primary Key)
full_name
country

**Courses Table**
course_id (Primary Key)
course_name
category
unit_price

**Purchases Table**
purchase_id (Primary Key)
learner_id (Foreign Key)
course_id (Foreign Key)
quantity
purchase_date


**Relationships**
One learner can make multiple purchases
One course can be purchased multiple times
Purchases act as a bridge table between learners and courses


**Key SQL Analysis Performed**

**Revenue Analysis**
Total revenue generated
Revenue by course
Revenue by country

**Customer Insights**
Top learners by spending
Repeat buyers identification
Learners purchasing across multiple categories

**Course Performance**
Most popular courses (by quantity)
Category-wise revenue distribution
Courses with zero purchases

**Geographic Insights**
Country-wise revenue contribution
Global learner distribution


**Advanced SQL Concepts Used**
JOINS (INNER, LEFT, RIGHT)
AGGREGATIONS (SUM, COUNT, ROUND)
GROUP BY & HAVING
SUBQUERIES logic
VIEWS (purchase_summary)
STORED PROCEDURES
DATA FORMATTING

**Interective dashboard **
<img width="1295" height="733" alt="image" src="https://github.com/user-attachments/assets/d2e223c8-1111-4117-9df5-4ac810602989" />


**Key Insights**
Data category dominates revenue, driven by courses like Python and SQL
A small number of learners contribute a large share of revenue
Repeat purchases indicate strong user engagement
Revenue is globally distributed, with strong activity in multiple countries
Some courses show zero or low demand, highlighting optimization opportunities
