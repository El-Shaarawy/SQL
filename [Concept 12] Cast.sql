/*  Write a query to change the date into the correct SQL date format. You will need to use at least*/

SELECT (substr(date,7,4) ||  '/' || LEFT(date,2) ||'/' || substr(date,4,2) )::date as new_Date
from sf_crime_data
