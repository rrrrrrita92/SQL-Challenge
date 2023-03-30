/*MEDIUM*/

with cte
as 
(
    select dense_rank() over( order by salary desc ) as salary_rank
            ,salary
    from employee
)

select max(salary) as SecondHighestSalary 
from cte 
where salary_rank =2
;




select max(salary) as SecondHighestSalary
from employee
where salary < (select max(salary) from employee )
;



/* notes
1. IFNULL(val, null) will not return 'null' if the value is empty (IFNULL will assume empty is the value we want). To avoid this problem, use either MAX() or subquery (IFNULL((subquery), null).

2. RANK will then skip the next available ranking value whereas DENSE_RANK would still use the next chronological ranking value
*/


/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key column for this table.
Each row of this table contains information about the salary of an employee.
 

Write an SQL query to report the second highest salary from the Employee table. If there is no second highest salary, the query should report null.

The query result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
*/
