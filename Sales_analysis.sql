use sales;

select * from sales_pro;
UPDATE sales_pro
SET Revenue = ROUND(Revenue, 2);

UPDATE sales_pro
set Unit_Price = round(Unit_Price,2);
-- Total revenue
select round(sum(Revenue),2) as revenue from sales_pro;
--Average_amount per order
select sum(Revenue)/count (distinct Order_ID)as avg_amount from sales_pro;
--Total quentity product sold
select sum(Quantity) as total_quantity from sales_pro
--Total order
select count(distinct Order_ID)as total_rder  from sales_pro;
--avg quantity sold per order
select sum(Quantity)/count (distinct Order_ID)as avg_quantity from sales_pro;

--Region wise revenue and perscentage 
select Region ,sum(Revenue) as revenue,
round(sum(Revenue)*100/(select sum(Revenue) from sales_pro),2) as PCT
from sales_pro 
group by Region;
--Top 5 sales person
select top 5 Salesperson ,sum (Quantity) as quantity
from sales_pro 
group by Salesperson 
order by quantity desc;
--bottom 5 sales person
select top 5 Salesperson ,sum (Quantity) as quantity
from sales_pro 
group by Salesperson 
order by quantity asc;



--Top 5 product by revenue 
SELECT top 5 Product, SUM(Quantity) as Total_Qty, SUM(Revenue) as Revenue
FROM sales_pro GROUP BY Product
order by Revenue desc;



--Amount Lost in Discount
SELECT SUM([Unit_Price] * Quantity) as MRP_Value, SUM(Revenue) as Final_Revenue,
round(SUM([Unit_Price] * Quantity) - SUM(Revenue) ,2)as Lost_In_Discount
FROM sales_pro;
--Revenue by month to month
SELECT
    YEAR(Date) AS Year,
    FORMAT(Date, 'MMM') AS Month,
    SUM(Revenue) AS Revenue,
   round( SUM(Revenue)*100/(select SUM(Revenue) from sales_pro),2) as pct
FROM sales_pro
GROUP BY YEAR(Date), MONTH(Date), FORMAT(Date, 'MMM')
ORDER BY YEAR(Date), MONTH(Date);