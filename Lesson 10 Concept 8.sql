/*Q6 What is the lifetime average amount spent in terms of total_amt_usd for only the companies that spent more than the average of all orders.		  */
select avg(sub.total)
from
(select account_id,AVG(total_amt_usd) total
from orders
GROUP BY 1
having AVG(total_amt_usd) > (select avg(o.total_amt_usd) total
from accounts a
join orders o
on a.id=o.account_id) )sub



/*Q 5 What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?		  */
select AVG(top_10)
from
(select a.name,sum(o.total_amt_usd) top_10
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10) sub


/*Q4 For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?		  */
select t1.acc_name, t2.channel, t2.count
from (select a.name acc_name,sum(o.total_amt_usd)
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1 ) t1
join
(select a.name acc_name, w.channel channel ,count(*) count
from accounts a
join web_events w
on a.id=w.account_id
GROUP BY 1,2
ORDER BY 2 DESC
) t2
on t1.acc_name=t2.acc_name
ORDER BY 3 DESC




 /*Q 3
For the name of the account that purchased the most (in total over their lifetime as a customer) standard_qty paper, how many accounts still had more in total purchases? */
select count(*)
from
 			(select a.name acc_name
			 from accounts a
			 join orders o
			 on a.id=o.account_id
			 GROUP BY 1
			 HAVING sum(o.total) >
			 	(
						select t1.total
						from (
									select a.name, sum(o.standard_amt_usd) standard, sum(o.total) total
 									from accounts a
			 						join orders o
			 						on a.id=o.account_id
			 						GROUP BY 1
			 						ORDER BY 2 DESC
									LIMIT 1
									) t1
				)
			 ) t3


/***********************/
select count(*)
from (select a.name acc_name, sum(o.standard_amt_usd) standard, sum(o.total) total
from accounts a
join orders o
on a.id=o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1) t1

JOIN
 (select a.name acc_name, sum(o.total) total
 from accounts a
 join orders o
 on a.id=o.account_id
 GROUP BY 1
 ORDER BY 2 DESC ) t2
 on t2.total > t1.total


/*Q2 For the region with the largest sales total_amt_usd, how many total orders were placed?   	*/


SELECT t1.region, t2.total
from (SELECT r.name region, sum(o.total) total
from region r
join sales_reps s
on r.id=s.region_id
join accounts a
on a.sales_rep_id = s.id
join  orders o
on o.account_id=a.id
GROUP BY 1) t2

JOIN

(SELECT r.name region, sum(total_amt_usd) total
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
) t1 on t1.region =t2.region


/*Q1 Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales. */

select  t3.region,t3.rep,t3.total
from (SELECT region, MAX(total) total
from (SELECT r.name region, s.name rep,sum(o.total_amt_usd) total
from region r
join sales_reps s on r.id=s.region_id
join accounts a
on a.sales_rep_id = s.id
join  orders o
on o.account_id=a.id
GROUP BY 1,2)sub
GROUP BY 1
) t2
join(SELECT r.name region,s.name rep, sum(total_amt_usd) total
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
) t3

on t3.total=t2.total and t3.region=t2.region
