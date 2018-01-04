/* Q6 What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all accounts. */

WITH sub AS (select account_id,AVG(total_amt_usd) total
from orders
GROUP BY 1
having AVG(total_amt_usd) > (select avg(o.total_amt_usd) total
from accounts a
join orders o
on a.id=o.account_id) )

select avg(sub.total)
from sub



/* Q5 What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts? */
WITH sub AS (select a.name,sum(o.total_amt_usd) top_10
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10)

select AVG(top_10)
from sub
/* Q4 For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?*/
WITH t1 AS (select a.name acc_name,sum(o.total_amt_usd)
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1 ),
t2 AS (select a.name acc_name, w.channel channel ,count(*) count
from accounts a
join web_events w
on a.id=w.account_id
GROUP BY 1,2
ORDER BY 2 DESC
)


select t1.acc_name, t2.channel, t2.count
from  t1
join
t2
on t1.acc_name=t2.acc_name
ORDER BY 3 DESC

/* Q3 For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases?  */
WITH t1 AS (select a.name acc_name, sum(o.standard_amt_usd) standard, sum(o.total) total
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1),
t2 AS (select a.name acc_name, sum(o.total) total
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC )


select count(*)
from  t1

JOIN
t2
on t2.total > t1.total


/* Q2 For the region with the largest sales total_amt_usd, how many total orders were placed? */

WITH t2 AS (SELECT r.name region, sum(o.total) total
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on a.sales_rep_id = s.id
join  orders o
on o.account_id=a.id
GROUP BY 1) ,
t1 AS (SELECT r.name region, sum(total_amt_usd) total
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on a.sales_rep_id = s.id
join  orders o
on o.account_id=a.id
GROUP BY 1
ORDER BY 2 DESC
limit 1
)

SELECT t1.region, t2.total
from t2
JOIN
t1
on t1.region =t2.region


/* Q1 Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales. */
select  t3.region,t3.rep,t3.total
from t2
join t3

on t3.total=t2.total and t3.region=t2.region


WITH t3 AS (SELECT r.name region,s.name rep, sum(total_amt_usd) total
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on a.sales_rep_id = s.id
join  orders o
on o.account_id=a.id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 1
),
sub AS (SELECT r.name region, s.name rep,sum(o.total_amt_usd) total
from region r
join sales_reps s on r.id=s.region_id
join accounts a
on a.sales_rep_id = s.id
join  orders o
on o.account_id=a.id
GROUP BY 1,2),
t2 AS (SELECT region, MAX(total) total
from sub
GROUP BY 1
)
