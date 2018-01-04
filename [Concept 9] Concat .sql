/* Q3 We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces. */
select lower(LEFT(LEFT(primary_poc,strpos(primary_poc,' ')-1),1)) || lower(RIGHT(LEFT(primary_poc,strpos(primary_poc,' ')-1),1))  ||
lower(LEFT(RIGHT(primary_poc,length(primary_poc)-strpos(primary_poc,' ')),1)) ||lower(right(RIGHT(primary_poc,length(primary_poc)-strpos(primary_poc,' ')),1)) || length(LEFT(primary_poc,strpos(primary_poc,' ')-1)) || length(RIGHT(primary_poc,length(primary_poc)-strpos(primary_poc,' '))) || UPPER(replace(name,' ','') )
from accounts
/* Q2 You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1. Some helpful documentation is here.
*/
select LEFT(primary_poc,strpos(primary_poc,' ')-1) || '.' ||
RIGHT(primary_poc,length(primary_poc)-strpos(primary_poc,' ')) || '@' || replace(name,' ','') || '.com'
from accounts
/* Q1 Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
*/
select LEFT(primary_poc,strpos(primary_poc,' ')-1) || '.' ||
RIGHT(primary_poc,length(primary_poc)-strpos(primary_poc,' ')) || '@' || name|| '.com'
from accounts
