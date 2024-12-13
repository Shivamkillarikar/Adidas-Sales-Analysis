# Adidas-Sales-Analysis
Here’s a detailed explanation of your SQL analysis project for your `README.md` file on GitHub:

---

# **Adidas Sales Data Analysis Project**

This project demonstrates the use of SQL for performing an in-depth analysis of a sales dataset for Adidas. The dataset contains sales data across various dimensions like products, regions, dates, and sales methods. The goal was to extract actionable insights from the data and perform key analyses such as identifying top-performing products, analyzing trends, and calculating state-wise and method-wise performance.

---

## **Project Objectives**
1. **Identify Top-Performing Products**:
   - Determine the top 3 best-selling products by total sales.
   - Identify products generating the highest and second-highest operating profits.

2. **Rank Products by Sales and Profits**:
   - Use SQL window functions (`RANK()`) to rank products based on their total sales and operating profits.

3. **Trend Analysis**:
   - Perform month-wise and year-wise analysis of sales and profits to identify seasonal trends.
   - Quantify the percentage contribution of each sales method to overall sales and profits.

4. **State-Wise and Product-Wise Analysis**:
   - Calculate the percentage of total sales contributed by each product in every state.
   - Identify states with the lowest profits and quantify their contribution.

5. **Advanced Queries Using SQL Techniques**:
   - Utilize **Common Table Expressions (CTEs)** to calculate the monthly and overall percentage contributions of products.
   - Apply **window functions** like `LAG`, `LEAD`, and `RANK` for comparative and trend analysis.

---

## **Key SQL Queries**

### 1. **Top 3 Selling Products**
This query identifies the products with the highest total sales:
```sql
SELECT Product, SUM(Total_Sales) AS Sales
FROM adidasUS
GROUP BY Product
ORDER BY Sales DESC
LIMIT 3;
```

### 2. **Second Highest Operating Profit**
Find the product with the second-highest operating profit using a subquery:
```sql
SELECT Product, MAX(Operating_Profit) AS MAXIMUM_PROFIT
FROM adidasUS
WHERE Operating_Profit < (SELECT MAX(Operating_Profit) FROM adidasUS)
GROUP BY Product
LIMIT 1;
```

### 3. **Rank Products by Sales and Profits**
Rank products by their total sales and profits using the `RANK()` window function:
```sql
SELECT 
    Product,
    SUM(Total_Sales) AS Total_Sales,
    SUM(Operating_Profit) AS Total_Profit,
    RANK() OVER (ORDER BY SUM(Total_Sales) DESC) AS Sale_Rank,
    RANK() OVER (ORDER BY SUM(Operating_Profit) DESC ) AS Profit_Rank
FROM adidasUS
GROUP BY Product;
```

### 4. **Month-Wise Sales & Profits**
Extract the month from a date column stored as text and calculate sales and profits:
```sql
SELECT 
    DATE_FORMAT(STR_TO_DATE(Invoice_Date, '%d-%m-%Y'), '%b') AS month,
    SUM(Total_Sales) AS TOTAL_SALES,
    SUM(Operating_Profit) AS TOTAL_PROFITS
FROM adidasUS
GROUP BY month
ORDER BY STR_TO_DATE(CONCAT('01-', month, '-2020'), '%d-%b-%Y');
```
### 5. **Which sales method produced highest amount of sales,profits**
```sql
select sales_method,sum(total_sales) as total_sales,
sum(operating_profit) as profits ,
sum(total_sales) * 100/(select sum(total_sales) from adidasUS) as percentage_of_sales,
sum(operating_profit)*100/(select sum(operating_profit) from adidasUS) as percentage_of_profits
from adidasUS
group by sales_method;
```

### 6. **Sales Method Contribution**
Calculate the contribution of each sales method to total sales and profits:
```sql
SELECT 
    Sales_Method,
    SUM(Total_Sales) AS Total_Sales,
    SUM(Operating_Profit) AS Profits,
    SUM(Total_Sales) * 100 / (SELECT SUM(Total_Sales) FROM adidasUS) AS Percentage_of_Sales,
    SUM(Operating_Profit) * 100 / (SELECT SUM(Operating_Profit) FROM adidasUS) AS Percentage_of_Profits
FROM adidasUS
GROUP BY Sales_Method;
```
### 7. **Percentage sales of each product state wise**
```sql
select state,product,sum(total_sales)*100/(select sum(total_sales) from adidasUS ) as percentage_of_sales
from adidasUS
group by state,product;
```

### 8. **Year wise sales and profits**
```sql
SELECT 
    YEAR(STR_TO_DATE(Invoice_Date, '%d-%m-%Y')) AS year,
    sum(total_sales) as Total_Sales,
    sum(operating_Profit) as Total_Profit
FROM adidasUS
group by year;
```

### 9. **Max Sales of product percentage month wise**

``` sql
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
```

---

## **Skills Demonstrated**
- **SQL Proficiency**:
  - Used advanced SQL techniques including aggregate functions, subqueries, Common Table Expressions (CTEs), and window functions.
  - Performed data transformation and analysis to derive meaningful insights.

- **Data Analysis**:
  - Analyzed trends in sales and profits over months and years.
  - Identified and quantified top-performing products, states, and sales methods.

- **Database Management**:
  - Designed queries to handle text-based date conversion and sorting.
  - Ensured efficient data handling by grouping, filtering, and ordering large datasets.

---

## **Tools Used**
- **Database**: MySQL
- **Platform**: SQL Workbench / Power BI for data visualization
- **Techniques**: Data transformation, trend analysis, and SQL-based reporting

