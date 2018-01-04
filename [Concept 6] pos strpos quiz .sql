/* Q2 Now see if you can do the same thing for every rep name in the sales_rep table. Again provide first and last name columns.*/

select LEFT(name,strpos(name,' ')-1) first_name,
RIGHT(name,length(name)-strpos(name,' ')) last_name from sales_reps


/* Q1 Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.  */
select LEFT(primary_poc,strpos(primary_poc,' ')-1) first_name,
RIGHT(primary_poc,length(primary_poc)-strpos(primary_poc,' ')) last_name
from accounts
