--Which sales reps are handling which accounts?

select sales_rep_id,sales_rep."name" , sales_rep.region_id,accounts."name",  
row_number() over(partition by sales_rep."name") as acc_num from accounts
join sales_rep on accounts.sales_rep_id = sales_rep.id 
order by sales_rep.region_id;


--One of the aspects that the business wants to explore is what has been the share of each sales representative's
--year on year sales out of the total yearly sales.

select EXTRACT(YEAR FROM o.occurred_at) AS year, sr.name AS sales_rep_name,
SUM(o.total_amt_usd) / SUM(SUM(o.total_amt_usd)) 
OVER (PARTITION BY EXTRACT(YEAR FROM o.occurred_at)) AS sales_share,
RANK() OVER (PARTITION BY EXTRACT(YEAR FROM o.occurred_at) ORDER BY SUM(o.total_amt_usd) DESC) AS sales_rank
from orders o
join accounts a ON o.account_id = a.id
join sales_rep sr ON a.sales_rep_id = sr.id
GROUP by year, sr.id, sr.name
ORDER by year, sales_rank;


-- Repeat the analysis given above but this time for region. 
--Generate the percentage contribution of each region to total yearly revenue over years.

select EXTRACT(YEAR FROM o.occurred_at) AS year, r."name"  AS region_name,
SUM(o.total_amt_usd) / SUM(SUM(o.total_amt_usd)) OVER (PARTITION BY EXTRACT(YEAR FROM o.occurred_at)) AS region_share,
RANK() OVER (PARTITION BY EXTRACT(YEAR FROM o.occurred_at) ORDER BY SUM(o.total_amt_usd) DESC) AS region_rank
from orders o
join accounts a ON o.account_id = a.id
join sales_rep sr ON a.sales_rep_id = sr.id
join region r ON sr.region_id = r.id
GROUP by year,r."name"
order by year,region_rank;





