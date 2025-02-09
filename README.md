# Adidas-Sales-Analysis Using SQL
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

** OUTPUT :
Men's Street Footwear	208826244

Women's Apparel	179038860

Men's Athletic Footwear	153673680 
**



### 2. **Second Highest Operating Profit**
Find the product with the second-highest operating profit using a subquery:
```sql
SELECT Product, MAX(Operating_Profit) AS MAXIMUM_PROFIT
FROM adidasUS
WHERE Operating_Profit < (SELECT MAX(Operating_Profit) FROM adidasUS)
GROUP BY Product
LIMIT 1;
```

** OUTPUT : 

Men's Street Footwear	382500 
**


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
**OUTPUT : 
Women's Apparel	179038860	68650996	2	2

Men's Athletic Footwear	153673680	51846964	3	3

Women's Street Footwear	128002813	45095897	4	4

Men's Apparel	123728632	44763099	5	5

Women's Athletic Footwear	106631896	38975843	6	6
**

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

**OUTPUT : 

Jan	71479142	25141970

Feb	61100153	21392765

Mar	56809109	20439808

Apr	72339970	27559278

May	80507695	29946287

Jun	74747372	26714734

Jul	95480694	34054930

Aug	92166201	34451469

Sep	77661459	31009630

Oct	63911033	25078465

Nov	67857340	24755550

Dec	85841957	31590236
**

### 5. **Which sales method produced highest amount of sales,profits**
```sql
select sales_method,sum(total_sales) as total_sales,
sum(operating_profit) as profits ,
sum(total_sales) * 100/(select sum(total_sales) from adidasUS) as percentage_of_sales,
sum(operating_profit)*100/(select sum(operating_profit) from adidasUS) as percentage_of_profits
from adidasUS
group by sales_method;
```
**OUTPUT : 

In-store	356643750	127591382	39.6314	38.4155

Outlet	295585493	107988403	32.8464	32.5134

Online	247672882	96555337	27.5222	29.0711
**


### 7. **Percentage sales of each product state wise**
```sql
select state,product,sum(total_sales)*100/(select sum(total_sales) from adidasUS ) as percentage_of_sales
from adidasUS
group by state,product;
```

**OUTPUT:

New York	Men's Street Footwear	1.5620
New York	Men's Athletic Footwear	1.1258
New York	Women's Street Footwear	0.9532
New York	Women's Athletic Footwear	0.9083
New York	Men's Apparel	1.1900
New York	Women's Apparel	1.3980
Texas	Men's Apparel	0.6693
Texas	Women's Apparel	1.0377
Texas	Men's Street Footwear	0.8689
Texas	Men's Athletic Footwear	0.9682
Texas	Women's Street Footwear	0.9037
Texas	Women's Athletic Footwear	0.7039
California	Men's Apparel	0.9848
California	Women's Apparel	1.3078
California	Men's Street Footwear	1.2070
California	Men's Athletic Footwear	1.2133
California	Women's Street Footwear	1.0602
California	Women's Athletic Footwear	0.9136
Illinois	Men's Apparel	0.1225
Illinois	Women's Apparel	0.2179
Illinois	Men's Street Footwear	0.3431
Illinois	Men's Athletic Footwear	0.1734
Illinois	Women's Street Footwear	0.1290
Illinois	Women's Athletic Footwear	0.1028
Pennsylvania	Men's Apparel	0.1173
Pennsylvania	Women's Apparel	0.2281
Pennsylvania	Men's Street Footwear	0.3780
Pennsylvania	Men's Athletic Footwear	0.1818
Pennsylvania	Women's Street Footwear	0.1428
Pennsylvania	Women's Athletic Footwear	0.1030
Nevada	Men's Apparel	0.2911
Nevada	Women's Apparel	0.4422
Nevada	Men's Street Footwear	0.4652
Nevada	Men's Athletic Footwear	0.4477
Nevada	Women's Street Footwear	0.3723
Nevada	Women's Athletic Footwear	0.2993
Colorado	Men's Apparel	0.2934
Colorado	Women's Apparel	0.4378
Colorado	Men's Street Footwear	0.4649
Colorado	Men's Athletic Footwear	0.4489
Colorado	Women's Street Footwear	0.3770
Colorado	Women's Athletic Footwear	0.3111
Washington	Men's Apparel	0.3714
Washington	Women's Apparel	0.5237
Washington	Men's Street Footwear	0.6025
Washington	Men's Athletic Footwear	0.5597
Washington	Women's Street Footwear	0.4700
Washington	Women's Athletic Footwear	0.3986
Florida	Men's Apparel	1.0061
Florida	Women's Apparel	1.2551
Florida	Men's Street Footwear	1.3966
Florida	Men's Athletic Footwear	1.1264
Florida	Women's Street Footwear	0.9644
Florida	Women's Athletic Footwear	0.8392
Minnesota	Men's Apparel	0.0825
Minnesota	Women's Apparel	0.1640
Minnesota	Men's Street Footwear	0.2777
Minnesota	Men's Athletic Footwear	0.1297
Minnesota	Women's Street Footwear	0.0990
Minnesota	Women's Athletic Footwear	0.0669
Montana	Men's Apparel	0.2237
Montana	Women's Apparel	0.3454
Montana	Men's Street Footwear	0.3353
Montana	Men's Athletic Footwear	0.3390
Montana	Women's Street Footwear	0.2767
Montana	Women's Athletic Footwear	0.2257
Tennessee	Men's Apparel	0.2560
Tennessee	Women's Apparel	0.4267
Tennessee	Men's Street Footwear	0.3403
Tennessee	Men's Athletic Footwear	0.3749
Tennessee	Women's Street Footwear	0.3535
Tennessee	Women's Athletic Footwear	0.2562
Nebraska	Men's Apparel	0.0589
Nebraska	Women's Apparel	0.1336
Nebraska	Men's Street Footwear	0.2368
Nebraska	Men's Athletic Footwear	0.1048
Nebraska	Women's Street Footwear	0.0729
Nebraska	Women's Athletic Footwear	0.0517
Alabama	Men's Apparel	0.2458
Alabama	Women's Apparel	0.4196
Alabama	Men's Street Footwear	0.3289
Alabama	Men's Athletic Footwear	0.3613
Alabama	Women's Street Footwear	0.3512
Alabama	Women's Athletic Footwear	0.2528
Maine	Men's Apparel	0.1107
Maine	Women's Apparel	0.2082
Maine	Men's Street Footwear	0.3298
Maine	Men's Athletic Footwear	0.1604
Maine	Women's Street Footwear	0.1238
Maine	Women's Athletic Footwear	0.0890
Alaska	Women's Apparel	0.3198
Alaska	Men's Street Footwear	0.4880
Alaska	Men's Athletic Footwear	0.2810
Alaska	Women's Street Footwear	0.2121
Alaska	Women's Athletic Footwear	0.1521
Alaska	Men's Apparel	0.1864
Hawaii	Women's Athletic Footwear	0.3206
Hawaii	Men's Apparel	0.3103
Hawaii	Women's Apparel	0.4564
Hawaii	Men's Street Footwear	0.5028
Hawaii	Men's Athletic Footwear	0.4826
Hawaii	Women's Street Footwear	0.4034
Wyoming	Women's Athletic Footwear	0.2476
Wyoming	Men's Apparel	0.3196
Wyoming	Women's Apparel	0.4193
Wyoming	Men's Street Footwear	0.4863
Wyoming	Men's Athletic Footwear	0.3224
Wyoming	Women's Street Footwear	0.2692
Virginia	Women's Athletic Footwear	0.3064
Virginia	Men's Apparel	0.3092
Virginia	Women's Apparel	0.4418
Virginia	Men's Street Footwear	0.4929
Virginia	Men's Athletic Footwear	0.4621
Virginia	Women's Street Footwear	0.3850
Michigan	Women's Athletic Footwear	0.2407
Michigan	Men's Apparel	0.3244
Michigan	Women's Apparel	0.4208
Michigan	Men's Street Footwear	0.5031
Michigan	Men's Athletic Footwear	0.3223
Michigan	Women's Street Footwear	0.2585
Missouri	Women's Athletic Footwear	0.1011
Missouri	Men's Apparel	0.1609
Missouri	Women's Apparel	0.2264
Missouri	Men's Street Footwear	0.3042
Missouri	Men's Athletic Footwear	0.1636
Missouri	Women's Street Footwear	0.1198
Utah	Women's Athletic Footwear	0.1009
Utah	Men's Apparel	0.1605
Utah	Women's Apparel	0.2328
Utah	Men's Street Footwear	0.2817
Utah	Men's Athletic Footwear	0.1694
Utah	Women's Street Footwear	0.1323
Oregon	Women's Athletic Footwear	0.3058
Oregon	Men's Apparel	0.2972
Oregon	Women's Apparel	0.4425
Oregon	Men's Street Footwear	0.4663
Oregon	Men's Athletic Footwear	0.4639
Oregon	Women's Street Footwear	0.3967
Louisiana	Women's Athletic Footwear	0.3553
Louisiana	Men's Apparel	0.3423
Louisiana	Women's Apparel	0.4939
Louisiana	Men's Street Footwear	0.5053
Louisiana	Men's Athletic Footwear	0.5120
Louisiana	Women's Street Footwear	0.4306
Idaho	Women's Athletic Footwear	0.2822
Idaho	Men's Apparel	0.2607
Idaho	Women's Apparel	0.4484
Idaho	Men's Street Footwear	0.3606
Idaho	Men's Athletic Footwear	0.4002
Idaho	Women's Street Footwear	0.3901
Arizona	Women's Athletic Footwear	0.2168
Arizona	Men's Apparel	0.2101
Arizona	Women's Apparel	0.3390
Arizona	Men's Street Footwear	0.3556
Arizona	Men's Athletic Footwear	0.3450
Arizona	Women's Street Footwear	0.2872
New Mexico	Women's Athletic Footwear	0.2870
New Mexico	Men's Apparel	0.2810
New Mexico	Women's Apparel	0.4299
New Mexico	Men's Street Footwear	0.4325
New Mexico	Men's Athletic Footwear	0.4226
New Mexico	Women's Street Footwear	0.3545
Georgia	Women's Athletic Footwear	0.2601
Georgia	Men's Apparel	0.2708
Georgia	Women's Apparel	0.3978
Georgia	Men's Street Footwear	0.4459
Georgia	Men's Athletic Footwear	0.4079
Georgia	Women's Street Footwear	0.3285
South Carolina	Women's Athletic Footwear	0.4161
South Carolina	Men's Apparel	0.5462
South Carolina	Women's Apparel	0.6430
South Carolina	Men's Street Footwear	0.7184
South Carolina	Men's Athletic Footwear	0.5064
South Carolina	Women's Street Footwear	0.4243
North Carolina	Women's Athletic Footwear	0.3336
North Carolina	Men's Apparel	0.4434
North Carolina	Women's Apparel	0.5342
North Carolina	Men's Street Footwear	0.6043
North Carolina	Men's Athletic Footwear	0.4088
North Carolina	Women's Street Footwear	0.3378
Ohio	Women's Athletic Footwear	0.2485
Ohio	Men's Apparel	0.3301
Ohio	Women's Apparel	0.4201
Ohio	Men's Street Footwear	0.4961
Ohio	Men's Athletic Footwear	0.3079
Ohio	Women's Street Footwear	0.2514
Kentucky	Women's Athletic Footwear	0.1007
Kentucky	Men's Apparel	0.1425
Kentucky	Women's Apparel	0.2276
Kentucky	Men's Street Footwear	0.3444
Kentucky	Men's Athletic Footwear	0.1752
Kentucky	Women's Street Footwear	0.1291
Mississippi	Women's Athletic Footwear	0.2027
Mississippi	Men's Apparel	0.2795
Mississippi	Women's Apparel	0.3604
Mississippi	Men's Street Footwear	0.4259
Mississippi	Men's Athletic Footwear	0.2602
Mississippi	Women's Street Footwear	0.2039
Arkansas	Women's Athletic Footwear	0.1545
Arkansas	Men's Apparel	0.2214
Arkansas	Women's Apparel	0.2987
Arkansas	Men's Street Footwear	0.3648
Arkansas	Men's Athletic Footwear	0.2068
Arkansas	Women's Street Footwear	0.1583
Oklahoma	Women's Athletic Footwear	0.1217
Oklahoma	Men's Apparel	0.1752
Oklahoma	Women's Apparel	0.2530
Oklahoma	Men's Street Footwear	0.3267
Oklahoma	Men's Athletic Footwear	0.1737
Oklahoma	Women's Street Footwear	0.1299
Kansas	Women's Athletic Footwear	0.1089
Kansas	Men's Apparel	0.1561
Kansas	Women's Apparel	0.2354
Kansas	Men's Street Footwear	0.3204
Kansas	Men's Athletic Footwear	0.1633
Kansas	Women's Street Footwear	0.1240
South Dakota	Women's Athletic Footwear	0.0762
South Dakota	Men's Apparel	0.1106
South Dakota	Women's Apparel	0.1985
South Dakota	Men's Street Footwear	0.3125
South Dakota	Men's Athletic Footwear	0.1427
South Dakota	Women's Street Footwear	0.1035
North Dakota	Women's Athletic Footwear	0.0684
North Dakota	Men's Apparel	0.1028
North Dakota	Women's Apparel	0.1865
North Dakota	Men's Street Footwear	0.2842
North Dakota	Men's Athletic Footwear	0.1275
North Dakota	Women's Street Footwear	0.0901
Iowa	Women's Athletic Footwear	0.0655
Iowa	Men's Apparel	0.1032
Iowa	Women's Apparel	0.1831
Iowa	Men's Street Footwear	0.2677
Iowa	Men's Athletic Footwear	0.1210
Iowa	Women's Street Footwear	0.0845
Wisconsin	Women's Athletic Footwear	0.0697
Wisconsin	Men's Apparel	0.1078
Wisconsin	Women's Apparel	0.1886
Wisconsin	Men's Street Footwear	0.2764
Wisconsin	Men's Athletic Footwear	0.1270
Wisconsin	Women's Street Footwear	0.0893
Indiana	Women's Athletic Footwear	0.0846
Indiana	Men's Apparel	0.1307
Indiana	Women's Apparel	0.2141
Indiana	Men's Street Footwear	0.3011
Indiana	Men's Athletic Footwear	0.1452
Indiana	Women's Street Footwear	0.1063
West Virginia	Women's Athletic Footwear	0.1168
West Virginia	Men's Apparel	0.1722
West Virginia	Women's Apparel	0.2624
West Virginia	Men's Street Footwear	0.3349
West Virginia	Men's Athletic Footwear	0.1707
West Virginia	Women's Street Footwear	0.1307
Maryland	Women's Athletic Footwear	0.0637
Maryland	Men's Apparel	0.0898
Maryland	Women's Apparel	0.1784
Maryland	Men's Street Footwear	0.3010
Maryland	Men's Athletic Footwear	0.1332
Maryland	Women's Street Footwear	0.0961
Delaware	Women's Athletic Footwear	0.1381
Delaware	Men's Apparel	0.1808
Delaware	Women's Apparel	0.2801
Delaware	Men's Street Footwear	0.3914
Delaware	Men's Athletic Footwear	0.2094
Delaware	Women's Street Footwear	0.1669
New Jersey	Women's Athletic Footwear	0.1003
New Jersey	Men's Apparel	0.1360
New Jersey	Women's Apparel	0.2270
New Jersey	Men's Street Footwear	0.3389
New Jersey	Men's Athletic Footwear	0.1698
New Jersey	Women's Street Footwear	0.1320
Connecticut	Women's Athletic Footwear	0.1251
Connecticut	Men's Apparel	0.1643
Connecticut	Women's Apparel	0.2660
Connecticut	Men's Street Footwear	0.3803
Connecticut	Men's Athletic Footwear	0.1956
Connecticut	Women's Street Footwear	0.1547
Rhode Island	Women's Athletic Footwear	0.0750
Rhode Island	Men's Apparel	0.1032
Rhode Island	Women's Apparel	0.1962
Rhode Island	Men's Street Footwear	0.3128
Rhode Island	Men's Athletic Footwear	0.1431
Rhode Island	Women's Street Footwear	0.1083
Massachusetts	Women's Athletic Footwear	0.1276
Massachusetts	Men's Apparel	0.1465
Massachusetts	Women's Apparel	0.2478
Massachusetts	Men's Street Footwear	0.3737
Massachusetts	Men's Athletic Footwear	0.1878
Massachusetts	Women's Street Footwear	0.1475
Vermont	Women's Athletic Footwear	0.1608
Vermont	Men's Apparel	0.2070
Vermont	Women's Apparel	0.3177
Vermont	Men's Street Footwear	0.4579
Vermont	Men's Athletic Footwear	0.2489
Vermont	Women's Street Footwear	0.2026
New Hampshire	Women's Athletic Footwear	0.1921
New Hampshire	Men's Apparel	0.2430
New Hampshire	Women's Apparel	0.3621
New Hampshire	Men's Street Footwear	0.5094
New Hampshire	Men's Athletic Footwear	0.2820
New Hampshire	Women's Street Footwear	0.2352


### 8. **Year wise sales and profits**
```sql
SELECT 
    YEAR(STR_TO_DATE(Invoice_Date, '%d-%m-%Y')) AS year,
    sum(total_sales) as Total_Sales,
    sum(operating_Profit) as Total_Profit
FROM adidasUS
group by year;
```
**OUTPUT:

2020	182080675	63375710

2021	717821450	268759412
**

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
**OUTPUT:

Jan	Men's Street Footwear	23.20544
Jan	Men's Athletic Footwear	17.07671
Jan	Women's Street Footwear	14.22408
Jan	Women's Athletic Footwear	11.84928
Jan	Men's Apparel	13.74912
Jan	Women's Apparel	19.89537
Feb	Men's Athletic Footwear	17.07671
Feb	Women's Street Footwear	14.22408
Feb	Women's Athletic Footwear	11.84928
Feb	Men's Apparel	13.74912
Feb	Women's Apparel	19.89537
Feb	Men's Street Footwear	23.20544
Mar	Women's Apparel	19.89537
Mar	Men's Street Footwear	23.20544
Mar	Men's Athletic Footwear	17.07671
Mar	Women's Street Footwear	14.22408
Mar	Women's Athletic Footwear	11.84928
Mar	Men's Apparel	13.74912
Apr	Men's Apparel	13.74912
Apr	Women's Apparel	19.89537
Apr	Men's Street Footwear	23.20544
Apr	Men's Athletic Footwear	17.07671
Apr	Women's Street Footwear	14.22408
Apr	Women's Athletic Footwear	11.84928
May	Men's Apparel	13.74912
May	Women's Apparel	19.89537
May	Men's Street Footwear	23.20544
May	Men's Athletic Footwear	17.07671
May	Women's Street Footwear	14.22408
May	Women's Athletic Footwear	11.84928
Jun	Men's Street Footwear	23.20544
Jun	Women's Apparel	19.89537
Jun	Men's Athletic Footwear	17.07671
Jun	Women's Street Footwear	14.22408
Jun	Women's Athletic Footwear	11.84928
Jun	Men's Apparel	13.74912
Jul	Women's Apparel	19.89537
Jul	Men's Athletic Footwear	17.07671
Jul	Women's Street Footwear	14.22408
Jul	Women's Athletic Footwear	11.84928
Jul	Men's Apparel	13.74912
Jul	Men's Street Footwear	23.20544
Aug	Men's Athletic Footwear	17.07671
Aug	Women's Street Footwear	14.22408
Aug	Women's Athletic Footwear	11.84928
Aug	Men's Apparel	13.74912
Aug	Women's Apparel	19.89537
Aug	Men's Street Footwear	23.20544
Sep	Women's Street Footwear	14.22408
Sep	Women's Athletic Footwear	11.84928
Sep	Men's Apparel	13.74912
Sep	Women's Apparel	19.89537
Sep	Men's Street Footwear	23.20544
Sep	Men's Athletic Footwear	17.07671
Oct	Men's Street Footwear	23.20544
Oct	Men's Athletic Footwear	17.07671
Oct	Women's Street Footwear	14.22408
Oct	Women's Athletic Footwear	11.84928
Oct	Men's Apparel	13.74912
Oct	Women's Apparel	19.89537
Nov	Men's Street Footwear	23.20544
Nov	Men's Athletic Footwear	17.07671
Nov	Women's Street Footwear	14.22408
Nov	Women's Athletic Footwear	11.84928
Nov	Men's Apparel	13.74912
Nov	Women's Apparel	19.89537
Dec	Women's Athletic Footwear	11.84928
Dec	Men's Apparel	13.74912
Dec	Men's Street Footwear	23.20544
Dec	Men's Athletic Footwear	17.07671
Dec	Women's Street Footwear	14.22408
Dec	Women's Apparel	19.89537
**
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

Here's a detailed README file tailored for your GitHub project, documenting your analysis:

---

# Adidas Sales Analysis Using Python

## Project Overview
This project provides an in-depth analysis of the Adidas US sales dataset. It utilizes Python for data cleaning, transformation, and visualization to extract meaningful insights and trends. The dataset includes sales records for various regions, states, and products across different sales methods.

## Dataset Description
The dataset contains sales records with the following columns:
- **Retailer, Retailer ID, Invoice Date**
- **Region, State, City**
- **Product, Price per Unit, Units Sold**
- **Total Sales, Operating Profit, Operating Margin**
- **Sales Method**

### Key Steps in Data Preprocessing:
1. **Dropped Null Values**: Ensured data integrity by removing any records with missing values.
2. **Renamed Columns**: Standardized column names for readability and ease of use.
3. **Data Type Conversion**: Corrected column data types to enable numerical computations and date manipulations.
4. **Outlier Removal**: Removed unwanted rows that could affect the analysis.
5. **Added Year and Month Columns**: Extracted year and month from the invoice dates for temporal analysis.

## Analysis and Insights

### 1. **Total Records in the Dataset**
   - The dataset consists of **9,647 records** after cleaning.

### 2. **Highest Sales and Profit by Region**
   - **Region with the Highest Sales**: **West** ($269,943,182)
   - **Region with the Highest Operating Profit**: **West** ($89,609,516)
   - **Method**: Grouped data by `Region` and calculated the sum of `Total Sales` and `Operating Profit`.

### 3. **Highest Sales and Profit by State**
   - **State with the Highest Sales**: **California** ($60,174,133)
   - **State with the Highest Operating Profit**: **California** ($19,301,183)
   - **Method**: Grouped data by `State` and calculated the sum of `Total Sales` and `Operating Profit`.

### 4. **Product Distribution**
   - Visualization of product distribution shows a breakdown of product categories by percentage.
   - **Key Insight**: Balanced sales distribution across product categories.
   - **Visualization**: Pie chart of product counts.

### 5. **Sales Method Analysis**
   - **Sales Channels**: Products are sold via three methods - In-store, Online, and Outlet.
   - **Product Sales by Method**:
     - In-store: **289-291 records per product**
     - Online: **813-816 records per product**
     - Outlet: **502-505 records per product**
   - **Visualization**: A table showcasing sales per product by sales method.

### 6. **State-wise Product Analysis**
   - State-level product sales data highlights the cities ordering specific products and their quantities.
   - **Visualization**: Cross-tabulation of `Product` and `City`.

### 7. **Sales by Sales Method**
   - Percentage of sales by method:
     - **In-store**: 33.33%
     - **Online**: 33.33%
     - **Outlet**: 33.33%
   - **Visualization**: Pie chart of sales method distribution.

### 8. **Temporal Analysis**
   - Added **Year** and **Month** columns from `Invoice Date` for tracking trends over time.
   - **Key Insight**: Seasonal variations in sales can be observed.

---

## Visualizations
1. **Region-wise Sales and Profit**: Bar charts showcasing sales and profit for each region.
2. **State-wise Sales and Profit**: Bar charts for detailed state-level insights.
3. **Product Distribution**: Pie chart of product percentages.
4. **Sales Method Distribution**: Pie chart of sales percentages by sales method.
5. **State-wise Product Sales**: Cross-tabulated heatmap of products sold in each state.

## Key Libraries Used
- **Pandas**: For data manipulation and analysis.
- **Matplotlib**: For visualizations.
- **Seaborn**: For advanced statistical plots.

## How to Run
1. Clone this repository.
2. Install required libraries using `pip install -r requirements.txt`.
3. Run the analysis script: `python analysis.py`.

## Conclusion
This analysis highlights key trends in Adidas US sales data, enabling better decision-making for inventory management, regional focus, and sales strategy optimization.

---

