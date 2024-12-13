use adidas;
select * from adidasUS;

#Top 3 selling Product
select Product,SUM(Total_Sales) as Sales
from adidasUS 
group by Product
order by Sales Desc
Limit 3;

#Product with Second highest Operating Profits
select Product,MAX(Operating_Profit) AS MAXIMUM_PROFIT from 
adidasUS 
where Operating_profit < (select max(OPERATINg_PROFIT) from adidasUS)
group by product
limit 1;

#Rank Products based on theirSales and Profits
SELECT 
    Product,
    SUM(Total_Sales) AS Total_Sales,
    SUM(Operating_Profit) AS Total_Profit,
    RANK() OVER (ORDER BY SUM(Total_Sales) DESC) AS Sale_Rank,
    RANK() OVER (ORDER BY SUM(Operating_Profit) DESC ) AS Profit_Rank
FROM adidasUS
GROUP BY Product;


#Month wise Sales & Profits
SELECT 
    DATE_FORMAT(STR_TO_DATE(Invoice_Date, '%d-%m-%Y'), '%b') AS month,
    SUM(Total_Sales) AS TOTAL_SALES,
    SUM(Operating_Profit) AS TOTAL_PROFITS
FROM adidasUS
GROUP BY month
ORDER BY STR_TO_DATE(CONCAT('01-', month, '-2020'), '%d-%b-%Y');

# Top 3 state WITH LOWEST profits:
select state,SUM(operating_profit) AS PROFTIS
from adidasUS 
group by state
ORDER BY SUM(OPERATING_PROFIT) ASC
LIMIT 3;

#Which sales method produced highest amount of sales,profits
select sales_method,sum(total_sales) as total_sales,
sum(operating_profit) as profits ,
sum(total_sales) * 100/(select sum(total_sales) from adidasUS) as percentage_of_sales,
sum(operating_profit)*100/(select sum(operating_profit) from adidasUS) as percentage_of_profits
from adidasUS
group by sales_method;

#Percentage sales of each product state wise
select state,product,sum(total_sales)*100/(select sum(total_sales) from adidasUS ) as percentage_of_sales
from adidasUS
group by state,product;

#Year wise sales and profits
SELECT 
    YEAR(STR_TO_DATE(Invoice_Date, '%d-%m-%Y')) AS year,
    sum(total_sales) as Total_Sales,
    sum(operating_Profit) as Total_Profit
FROM adidasUS
group by year;

#Max Sales of product percentage month wise
WITH TotalSalesByProduct AS (
    SELECT 
        Product,
        SUM(Total_Sales) AS Product_Total_Sales,
        SUM(Total_Sales) * 100.0 / (SELECT SUM(Total_Sales) FROM adidasUS) AS Sales_Percentage
    FROM adidasUS
    GROUP BY Product
),
MonthlyData AS (
    SELECT 
        DATE_FORMAT(STR_TO_DATE(Invoice_Date, '%d-%m-%Y'), '%b') AS month,
        DATE_FORMAT(STR_TO_DATE(Invoice_Date, '%d-%m-%Y'), '%m') AS month_order,
        Product,
        SUM(Total_Sales) AS Total_Sales
    FROM adidasUS
    GROUP BY month, month_order, Product
)
SELECT 
    m.month,
    ts.Product,
    MAX(ts.Sales_Percentage) AS Max_Sales_Percentage
FROM MonthlyData m
JOIN TotalSalesByProduct ts
ON m.Product = ts.Product
GROUP BY m.month, m.month_order, ts.Product
ORDER BY CAST(m.month_order AS UNSIGNED);


