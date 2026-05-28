/*
JOINS
*/

-- INNER Join
-- customers with account details
Select c.first_name,
       a.account_type,
	   a.current_balance
from customers c inner join accounts a on c.customer_id = a.customer_id;

-- customers with loans
select c.first_name,
       l.principal_amount,
	   l.loan_type
from customers c inner join loans l
on c.customer_id=l.customer_id;

/*
13.LEFT OUTER JOIN
*/

-- Show all customers even without accounts
Select c.first_name,
       a.account_type,
	   a.current_balance
from customers c left join accounts a
on c.customer_id = a.customer_id;

/*
14. RIGHT OUTER JOIN 
*/

Select c.first_name,
       a.account_type
from customers c right join accounts a
on c.customer_id = a.customer_id;

/*
15.FULL OUTER JOIN
*/

Select c.first_name,
       a.account_type
from customers c full outer join accounts a
on c.customer_id = a.customer_id;

/*
16.JOIN with Filtering
*/

-- High balance customer only and Join with ORDER BY
Select c.first_name,
       a.current_balance
from customers c join accounts a
on c.customer_id = a.customer_id where a.current_balance <= 80000
order by a.current_balance desc;

-- Customers from New York with loans And join with order by 
Select c.first_name,
       l.principal_amount,
	   l.loan_type
from customers c join loans l
on c.customer_id = l.customer_id
where c.city = 'New York'
order by l.principal_amount desc;

/*
17.Cross Join
*/
Select c.first_name,
       b.branch_name
from customers c cross join branches b;

/*
18.Self Join 
*/

Select e.first_name as employee,
       m.first_name as manager
from employees e join employees m
on e.branch_id= m.employee_id;


/*
Join 3 Tables

Customer + Account + Transactions
*/

Select c.first_name,
       a.account_type,
	   t.amount
from customers c
join accounts a
on c.customer_id = a.customer_id
join transactions t
on a.account_id = t.account_id;

/*
JOIN with BETWEEN 
*/

Select c.first_name,
       l.principal_amount
from customers c
join loans l
on c.customer_id = l.customer_id
where l.principal_amount BETWEEN 100000 AND 500000;

/*
Join with Like
*/

Select c.first_name,
       a.current_balance
from customers c
join accounts a
on c.customer_id = a.customer_id
where c.first_name like 'S%'
order by a.current_balance desc;

/*
join with AND
*/
Select c.first_name,
       a.current_balance
from customers c
join accounts a
on c.customer_id = a.customer_id
where a.current_balance >50000
And a.account_type = 'SAVINGS';

/*
JOIN with OR
*/

Select c.first_name,
       c.city,
	   c.state,
       a.current_balance
from customers c
join accounts a
on c.customer_id = a.customer_id
where c.city = 'New York'
or c.city = 'Columbus';

/*
--------------------------------------------------
|        JOIN         |       Returns            |
--------------------------------------------------
   INNER JOIN         |   Matching rows only     |

   LEFT JOIN          |   All left rows          |

   RIGHT JOIN         |   All right rows         |

   Full OUTER JOIN    |   All rows from both     |

   CROSS JOIN         |   Every combination      |

   SELF JOIN          | Same table joined itself |
--------------------------------------------------
*/









