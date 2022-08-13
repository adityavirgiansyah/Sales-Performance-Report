SELECT * FROM baru.dbo.SQL_Retail1_DQLab$;

-- DQLab Store overall performance from 2009–2012 for number of orders and total sales orders completed
-- Overall Performance by Year
SELECT
	YEAR(order_date) AS Years,
	SUM(sales) AS Sales,
	COUNT(order_quantity) AS number_of_order
FROM
	baru.dbo.SQL_Retail1_DQLab$
WHERE
	order_status = 'Order Finished'
GROUP BY
	YEAR(order_date)
ORDER BY
	Years;

-- Overall performance of DQLab by product subcategory to be compared between 2011 and 2012
-- Overall Performance by Product Subcategory
SELECT 
	YEAR(order_date) AS Years, 
	product_sub_category, 
	SUM(sales) AS sales
FROM 
	baru.dbo.SQL_Retail1_DQLab$
WHERE 
	order_status = 'Order Finished'
	AND YEAR(order_date) > 2010
GROUP BY 
	YEAR(order_date), product_sub_category
ORDER BY 
	Years, sales DESC;

-- The effectiveness and efficiency of the promotions carried out so far, by calculating the burn rate of the promotions carried out as a whole by year
-- Promotion Effectiveness and Efficiency by Years
SELECT
	YEAR(order_date) AS Years,
	SUM(sales) AS Sales,
	SUM(discount_value) AS Discount,
	ROUND(SUM(discount_value) / SUM(sales) * 100, 2) AS [Burn Rate]
FROM
	baru.dbo.SQL_Retail1_DQLab$
WHERE 
	order_status = 'Order Finished'
GROUP BY
	YEAR(order_date)
ORDER BY
	Years ASC;

-- The effectiveness and efficiency of the promotions carried out so far, 
-- by calculating the burn rate of the promotions carried out as a whole based on sub-categories
-- Promotion Effectiveness and Efficiency by Product Subcategory
SELECT
	YEAR(order_date) AS Years,
	product_category,
	product_sub_category,
	SUM(sales) AS Sales,
	SUM(discount_value) AS Discount,
	ROUND(SUM(discount_value) / SUM(sales) * 100, 2) AS [Burn Rate]
FROM
	baru.dbo.SQL_Retail1_DQLab$
WHERE 
	order_status = 'Order Finished' AND YEAR(order_date) = 2012
GROUP BY
	YEAR(order_date), 
	product_sub_category, 
	product_category
ORDER BY
	Sales DESC;

-- Customer Analysis
-- Customers Per Year
SELECT
	YEAR(order_date) AS Years,
	COUNT(DISTINCT customer) AS Number_of_Customer
FROM
	baru.dbo.SQL_Retail1_DQLab$
WHERE
	order_status = 'Order Finished'
GROUP BY
	YEAR(order_date)
ORDER BY
	Years;

-- New Customers Per Year
SELECT
	YEAR(First_Transaction) AS Years,
	COUNT(DISTINCT customer) AS Number_of_New_Customer
FROM
	(SELECT 
		customer,
		MIN(order_date) AS First_Transaction
	FROM 
		baru.dbo.SQL_Retail1_DQLab$
	WHERE
		order_status = 'Order Finished'
	GROUP BY
		customer) A
GROUP BY
	YEAR(First_Transaction)
ORDER BY
	Years;