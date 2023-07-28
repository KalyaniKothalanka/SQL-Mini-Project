select extract(year from occurred_at) as year,accounts.name, sum(total_amt_usd),
SUM(o.total_amt_usd) / SUM(SUM(o.total_amt_usd)) OVER (PARTITION BY EXTRACT(YEAR FROM o.occurred_at)) AS Revenue_share,
RANK() OVER (PARTITION BY EXTRACT(YEAR FROM o.occurred_at) ORDER BY SUM(o.total_amt_usd) DESC)as Revenue_rank
from orders o
join accounts on o.account_id =accounts.id
group by year,accounts.name
order by year,Revenue_rank;

