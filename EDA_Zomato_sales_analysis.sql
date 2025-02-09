-----EDA ------

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM restaurants;
SELECT * FROM riders;
SELECT * FROM deliveries;


--HENCE WE ALREADY IMPORTED OUR DATA 
--WE WILL DO EDA IN IT 

--EDA

--1: CHECKING FOR ANY NULL VALUES IN THE TABLE

SELECT*FROM customers
WHERE
  customer_id IS NULL 
      OR
 customer_name IS NULL 
      OR 
 reg_date IS NUll;

-- hence we couldn't find any null value in customer table 

SELECT*FROM riders
WHERE
  rider_id IS NULL 
      OR
 rider_name IS NULL 
      OR 
 sign_up IS NUll;

--hence we couldn't find any null values in the riders table

SELECT*FROM deliveries
WHERE
  delivery_id IS NULL 
      OR
 order_id IS NULL 
      OR 
 delivery_status IS NUll
      OR
 delivery_time IS NULL 
      OR
 rider_id IS NULL;

 --HENCE WE can see that delivery_time is null in every column

 SELECT*FROM orders
WHERE
  order_id IS NULL 
      OR
 customer_id IS NULL 
      OR 
 restaurant_id IS NUll
      OR
 order_item IS NULL 
      OR
  order_date IS NULL
     OR 
  order_time IS NULL 
     OR
  order_status IS NULL 
	 OR 
  totaL_amount IS NULL;

 --hence we don't find anuy null values in the orders table 

SELECT*FROM restaurants
WHERE
  restaurant_id IS NULL 
      OR
 restaurant_name IS NULL 
      OR 
 city IS NUll
      OR
 opening_hours IS NULL;

 --inserting some null values in orders table we get 

 INSERT INTO orders(order_id , customer_id , restaurant_id)
 VALUES 
 (10002 , 9 , 54 ),
 (10009 , 10 , 51 ),
 (10005 , 10 , 50 );

 --NOW RUNNIG ORDERS TABLE QUERY AGAIN TO SEE ANY NUL VALUES IN THE TABLE 

 
 SELECT*FROM orders
  WHERE
  order_id IS NULL 
      OR
 customer_id IS NULL 
      OR 
 restaurant_id IS NUll
      OR
 order_item IS NULL 
      OR
  order_date IS NULL
     OR 
  order_time IS NULL 
     OR
  order_status IS NULL 
	 OR 
  totaL_amount IS NULL;

  --hence we found some null values in the table ---

  --now we will delete the null values ---

  DELETE FROM orders
  WHERE
  order_id IS NULL 
      OR
 customer_id IS NULL 
      OR 
 restaurant_id IS NUll
      OR
 order_item IS NULL 
      OR
  order_date IS NULL
     OR 
  order_time IS NULL 
     OR
  order_status IS NULL 
	 OR 
  totaL_amount IS NULL;

  --hence we successfully delete the null values ---


 --QUESTION 1 : WRITE A QUERY TO FIND THE TOP 5 MOST FREQUENLTY ORDERED DISHES BY CUSTOMER CALLED 'Arjun Mehta' in the 1ST YEAR 

  --first selecting the table we get 
  SELECT * FROM customers;
  SELECT * FROM orders;

  --now using joins we get it will show the data of all the dishes order by Arjun Mehta
   SELECT 
   c.customer_id ,
   c.customer_name,
   o.order_item as dishes ,
   count(*) as total_orders
   FROM orders as o
   JOIN 
   customers AS c 
   ON o.customer_id = c.customer_id
   WHERE 
   o.order_date >= CURRENT_DATE - INTERVAL '2 year'
   AND 
   c.customer_name = 'Arjun Mehta'
   GROUP BY 1,2,3
   ORDER BY 1,4 DESC;

   --now to get the data of top 5 most frequently ordered dishes by Arjun Mehta 

   SELECT 
   c.customer_id ,
   c.customer_name,
   o.order_item as dishes ,
   count(*) as total_orders ,
   --now this is a window function to get top 5 dishes 
   DENSE_RANK() OVER (ORDER BY COUNT(*) DESC ) as rank
   FROM orders as o
   JOIN 
   customers AS c 
   ON o.customer_id = c.customer_id
   WHERE 
   o.order_date >= CURRENT_DATE - INTERVAL '2 year'
   AND 
   c.customer_name = 'Arjun Mehta'
   GROUP BY 1,2,3
   ORDER BY 1,4 DESC;

   --now making it again a table we get --

   SELECT *FROM  
     (
   SELECT 
   c.customer_id ,
   c.customer_name,
   o.order_item as dishes ,
   count(*) as total_orders ,
   --now this is a window function to get top 5 dishes 
   DENSE_RANK() OVER (ORDER BY COUNT(*) DESC ) as rank
   FROM orders as o
   JOIN 
   customers AS c 
   ON o.customer_id = c.customer_id
   WHERE 
   o.order_date >= CURRENT_DATE - INTERVAL '2 year'
   AND 
   c.customer_name = 'Arjun Mehta'
   GROUP BY 1,2,3
   ORDER BY 1,4 DESC) as t1 
   WHERE rank <=5;
  

  --now only selecting customer_name , dishes from t1 we get

  SELECT 
   customer_name,
   dishes ,
   total_orders
   FROM
   (
   SELECT 
   c.customer_id ,
   c.customer_name,
   o.order_item as dishes ,
   count(*) as total_orders ,
   --now this is a window function to get top 5 dishes 
   DENSE_RANK() OVER (ORDER BY COUNT(*) DESC ) as rank
   FROM orders as o
   JOIN 
   customers AS c 
   ON o.customer_id = c.customer_id
   WHERE 
   o.order_date >= CURRENT_DATE - INTERVAL '2 year'
   AND 
   c.customer_name = 'Arjun Mehta'
   GROUP BY 1,2,3
   ORDER BY 1,4 DESC) as t1 
   WHERE rank <= 5;


 --HENCE WE CLEARLY GET THE DATA OF THE DISHES ORDER BY ARJUN MEHTA IN YEAR 2024 

 --Q2 : WRITE A QUERY TO FIND THE TOP 5 MOST FREQUENLTY ORDERED DISHES BY CUSTOMER CALLED 'PRIYA SHARMA' in the 1ST YEAR 

  --first selecting the table we get 

  SELECT * FROM CUSTOMERS ;
  SELECT * FROM ORDERS ;

  --NOW we will inner join the customer table and order table we get 
  SELECT 
  customer_name,
  dishes,
  total_orders,
  rank
  FROM 
  (SELECT 
  c.customer_id ,
  c.customer_name ,
  o.order_item as dishes ,
  COUNT(*) AS total_orders ,
  DENSE_RANK () OVER (ORDER BY COUNT(*) DESC) as RANK
  FROM orders as o 
  JOIN
  customers as c 
  ON 
  o.customer_id = c.customer_id
  WHERE 
  o.order_date >= CURRENT_DATE - INTERVAL '2 years'
  AND 
  c.customer_name = 'Priya Sharma'
  GROUP BY 1 , 2 ,3
  ORDER BY 1, 4 DESC)
  WHERE RANK <=5;


--Question :3 Identify the time slots during which the most orders are placed based on 2 hour interval

SELECT * FROM orders;

--we need to extract order time we get
--NOW APPRAOCH 2 
SELECT 
 CASE 
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 0 AND 1 THEN '00:00 - 02:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 2 AND 3 THEN '02:00 - 04:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 4 AND 5 THEN '04:00 - 06:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 6 AND 7 THEN '06:00 - 08:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 8 AND 9 THEN '08:00 - 10:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 10 AND 11 THEN '10:00 - 12:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 12 AND 13 THEN '12:00 - 14:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 14 AND 15 THEN '14:00 - 16:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 16 AND 17 THEN '16:00 - 18:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 18 AND 19 THEN '18:00 - 20:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 20 AND 21 THEN '20:00 - 22:00'
    WHEN EXTRACT (HOUR FROM  order_time) BETWEEN 22 AND 23 THEN '22:00 - 00:00'
  END  AS time_slot,
  COUNT(order_id) AS order_count
FROM orders
GROUP BY time_slot
ORDER BY 2 DESC;

--approach 2 ---

SELECT  * FROM orders;

SELECT 
   FLOOR(EXTRACT (HOUR FROM order_time)/2)*2 AS start_time ,
   FLOOR(EXTRACT (HOUR FROM order_time)/2)*2+2 AS end_time ,
   COUNT(*) AS total_orders
FROM orders 
GROUP BY 1,2 
ORDER BY 3  DESC;


SELECT 
   FLOOR(EXTRACT (HOUR FROM order_time)/2)*2 AS start_time ,
   FLOOR(EXTRACT (HOUR FROM order_time)/2)*2+2 AS end_time ,
   COUNT(*) AS total_orders
FROM orders 
GROUP BY 1,2 
ORDER BY 3  DESC;



--QUESTION 4 : INDENTIFY THE TIME SLOT DURING THE MOST ORDERS PLACED BETWEEN 7 HOURS INTERVAL 

--WE WILL DO IT WITH BOTH APPOARCH WE WILL GET

SELECT * FROM orders;

--now we will do it 

SELECT 
 CASE
   WHEN EXTRACT(HOUR FROM order_time) BETWEEN 0 AND 6 THEN '00:00 - 07:00'
   WHEN EXTRACT(HOUR FROM order_time) BETWEEN 7 AND 13 THEN '07:00 - 14:00'
   WHEN EXTRACT(HOUR FROM order_time ) BETWEEN 14 AND 20 THEN '14:00 - 21:00'
   WHEN EXTRACT (HOUR FROM order_time) BETWEEN 21 AND 23 THEN  '21:00 - 00:00'
 END as time_slot,
 COUNT(*) AS total_orders
FROM orders
GROUP BY 1 
ORDER BY 2 ;


--QUESTION NO 5 : ORDER VALUE ANALYSIS 
  --FIND THE AVERAGE ORDER VALUE PER CUSTOMER WHO HAS PLACED MORE THAN 750 ORDERS
  --RETURN CUSTOMER_NAME , AND AOV (AVERAGE ORDER VALUE)

--first calculation averafe order value 
SELECT 
   customer_id, 
   AVG(total_amount) AS AOV
FROM orders 
GROUP BY 1;

--now calculating the total orders as and and also having orders more than 750 
SELECT 
  customer_id ,
  AVG(total_amount) AS aov,
  COUNT(order_id) as total_orders 
FROM orders 
GROUP BY 1 
HAVING COUNT(order_id) >750;

--now analysis we can see that only three peoples have placed orders more than 750 

--now getting the customer and aov and total_orders who have placed more than 750


SELECT 
  c.customer_name,
  AVG(o.total_amount) AS aov,
  COUNT(o.order_id) AS total_orders
FROM orders AS o 
   JOIN
   customers AS C 
   ON c.customer_id = o.customer_id
GROUP BY 1 
HAVING COUNT(order_id) >750;

--QUESTION NO 6 : ORDER VALUE ANALYSIS 
  --FIND THE AVERAGE ORDER VALUE PER CUSTOMER WHO HAS PLACED MORE THAN 500 ORDERS
  --RETURN CUSTOMER_NAME , AND AOV (AVERAGE ORDER VALUE)

--first we will find the average order value 

SELECT 
  customer_id,
  AVG(total_amount) AS AOV,
  COUNT(order_id) AS total_orders
FROM orders 
GROUP BY 1
HAVING COUNT(order_id) > 500;


--now we will also return the names of the people who have order more than 500 orders 

SELECT 
  c.customer_name,
  AVG(o.total_amount) AS AOV,
  COUNT(o.order_id) AS total_orders
FROM orders AS o
    JOIN
	customers AS C
	ON c.customer_id = o.customer_id
GROUP BY 1
HAVING COUNT(order_id) > 500;



--QUESTION NO : 6 HIGH VALUE CUSTOMERS 
--LIST ALL THE CUSTOMER WHO HAVE SPENT MORE THAN 100K ON TOTAL ON FOOD ORDERS
--RETURN CUSTOMER NAME AND CUSTOMER ID 

SELECT 
  c.customer_name ,
  SUM(o.total_amount) AS total_Spent ,
  COUNT(o.order_id ) AS total_orders
FROM orders AS o
    JOIN 
	customers AS c 
	ON  c.customer_id = o.customer_id
GROUP BY 1 
HAVING SUM(o.total_amount) > 100000;


--QUESTION NO 7 : ORDERS WITHOUT DELIVERY 
--QUESTION - WRITE A QUERY TO FIND ORDERS THAT WERE PLACED BUT NOT DELIVERED 
--QUESTION - RETURN EACH RESTAURANT NAME , CITY AND NUMBERS OF NOT DELIVERED ORDERS  


--NOW AS WE KNOW FROM ERD that orders table has restaurant_id and as well as delivery id 
--so we will left join both the tables 


--writing a query to find the orders that were placed but not delivered 

SELECT * 
FROM orders AS o
LEFT JOIN 
restaurants AS r 
ON r.restaurant_id = o.restaurant_id 
LEFT JOIN 
deliveries as d
ON d.order_id = o.order_id
WHERE d.delivery_id IS  NULL ;

-- NOW RETURN EACH RESTAURANT NAME , CITY AND NUMBERS OF NOT DELIVERED ORDERS 

SELECT 
    r.restaurant_name ,
	COUNT(o.order_id) AS NO_OF_NOT_DELIVERED,
	r.city
FROM orders AS o
LEFT JOIN 
restaurants AS r 
ON r.restaurant_id = o.restaurant_id 
LEFT JOIN 
deliveries as d
ON d.order_id = o.order_id
WHERE d.delivery_id IS  NULL 
GROUP BY 1 ,3
ORDER BY 2 DESC;


--QUESTION No 8 : ORDERS WITH DELIVERY 
--QUESTION - WRITE A QUERY TO FIND ORDERS THAT WERE PLACE AND DELIVERED 
--QUESTION - RETURN EACH RESTAURANT NAME , CITY AND NUMBERS  DELIVERED ORDERS  


--NOW AS WE KNOW FROM ERD that orders table has restaurant_id and as well as delivery id 
--so we will left join both the tables 


--writing a query to find the orders that were placed and delivered 

SELECT * 
FROM orders AS o
LEFT JOIN 
restaurants AS r 
ON r.restaurant_id = o.restaurant_id 
LEFT JOIN 
deliveries as d
ON d.order_id = o.order_id
WHERE 
  d.delivery_id IS NOT  NULL
       AND 
  d.delivery_status = 'Delivered';


-- NOW RETURN EACH RESTAURANT NAME , CITY AND NUMBERS  DELIVERED ORDERS

SELECT 
  r.restaurant_name,
  r.city,
  COUNT(o.order_id) AS orders_that_are_delivered
FROM orders AS o
LEFT JOIN 
restaurants AS r 
ON r.restaurant_id = o.restaurant_id 
LEFT JOIN 
deliveries as d
ON d.order_id = o.order_id
WHERE 
  d.delivery_id IS NOT  NULL
       AND 
  d.delivery_status = 'Delivered'
GROUP BY 1,2 
ORDER BY 3 DESC;




--QUESTION NO : 9 RESTAURANT REVENUE RANKING 
--RESTAURANT REVENUE RANKING 
--RANK RESTAURANT BY THEIR ENTOTAL REVENUE FROM THE LAST YEAR INCLUDING THEIR NAME , 
--TOTAL REVENUE WITHIN THEIR CITY 


--first we will select from orders and restuarant to analyse the data 

SELECT * 
FROM 
orders;

SELECT * FROM restaurants;


--now we will join the two tables to get the insights from the table

SELECT * 
FROM orders AS o 
    JOIN 
  restaurants AS r 
  ON r.restaurant_id = o.restaurant_id;


--RESTAURANT REVENUE RANKING  now getting restaurant revenue ranking we get 
SELECT 
	r.city ,
	r.restaurant_name,
	SUM(o.total_amount) AS revenue
FROM orders AS o 
    JOIN 
  restaurants AS r 
  ON r.restaurant_id = o.restaurant_id
GROUP BY 1,2
ORDER BY 1,3 DESC;

--now applying rank function we get 

SELECT 
	r.city ,
	r.restaurant_name,
	SUM(o.total_amount) AS revenue,
	RANK() OVER(ORDER BY SUM(o.total_amount) DESC) as rank
FROM orders AS o 
    JOIN 
  restaurants AS r 
  ON r.restaurant_id = o.restaurant_id
GROUP BY 1,2
ORDER BY 1,3 DESC;


--now getting data of restaurant within each city 


SELECT 
	r.city ,
	r.restaurant_name,
	SUM(o.total_amount) AS revenue,
	RANK() OVER(PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) as rank
FROM orders AS o 
    JOIN 
  restaurants AS r 
  ON r.restaurant_id = o.restaurant_id
  WHERE o.order_date >= CURRENT_DATE - INTERVAL '2 year'
GROUP BY 1,2;


--now getting top restaurant name within each city
WITH  Ranking_table
AS(
SELECT 
	r.city ,
	r.restaurant_name,
	SUM(o.total_amount) AS revenue,
	RANK() OVER(PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) as rank
FROM orders AS o 
    JOIN 
  restaurants AS r 
  ON r.restaurant_id = o.restaurant_id
GROUP BY 1,2)
SELECT * from Ranking_table 
WHERE rank = 1;

--now for last year
WITH  Ranking_table
AS(
SELECT 
	r.city ,
	r.restaurant_name,
	SUM(o.total_amount) AS revenue,
	RANK() OVER(PARTITION BY r.city ORDER BY SUM(o.total_amount) DESC) as rank
FROM orders AS o 
    JOIN 
  restaurants AS r 
  ON r.restaurant_id = o.restaurant_id
  WHERE o.order_date >= CURRENT_DATE - INTERVAL '2 year'
GROUP BY 1,2)
SELECT * from Ranking_table 
WHERE rank = 1;

--QUESTION NO : 10  RESTAURANT  ORDER HISTORY 
--WHICH RESTAURANT HAS THE MOST ORDERS 
--WHICH RESTAURANT HAS THE HIGHEST NUMBER OF ORDERS WITHIN EACH CITY 

select* from orders;

select * from restaurants; 


--now joining each restaurant we get 

select * from orders as o 
    join 
	restaurants as r 
	ON r.restaurant_id = o.restaurant_id ;

--now selecting the restaurant_name , city and numbers of orders of each restaurants

select 
    r.city , 
	r.restaurant_name,
	count(o.order_id) AS total_orders,
	rank() over(order by count(o.order_id) desc) as rank
from orders as o 
    join 
	restaurants as r 
	ON r.restaurant_id = o.restaurant_id 
group by 1 , 2 ;

--now partitioning over cities we get 

select 
    r.city , 
	r.restaurant_name,
	count(o.order_id) AS total_orders,
	rank() over( partition by r.city order by count(o.order_id) desc) as rank
from orders as o 
    join 
	restaurants as r 
	ON r.restaurant_id = o.restaurant_id 
group by 1 , 2 ;

--top first restaurant which has highest number of orders 
with ranking_table
AS
(select 
    r.city , 
	r.restaurant_name,
	count(o.order_id) AS total_orders,
	rank() over(order by count(o.order_id) desc) as rank
from orders as o 
    join 
	restaurants as r 
	ON r.restaurant_id = o.restaurant_id 
group by 1 , 2 )
select * from ranking_table
where rank = 1;

--now its giving rank globally not within each city so we will use parition by 


with ranking_table
AS
(select 
    r.city , 
	r.restaurant_name,
	count(o.order_id) AS total_orders,
	rank() over(partition by r.city order by count(o.order_id) desc) as rank
from orders as o 
    join 
	restaurants as r 
	ON r.restaurant_id = o.restaurant_id 
group by 1 , 2 )
select * from ranking_table
where rank = 1;

--hence we get the highest orders in each restaurant in each city 

--QUESTION NO 11 : 
   --MOST POPULAR DISH BY CITY 
   --IDENTIFY THE MOST POPULAR DISH IN EACH CITY  BASED ON THE NO OF ORDERS 


--as we know we we will join restaurant and orders table we will get 

SELECT * FROM orders as o
 JOIN 
 restaurants as r 
 ON r.restaurant_id = o.restaurant_id ;


 --now will get city name , order item and restaurant to see which is popular 

 SELECT 
    r.city,
	r.restaurant_name,
	o.order_item , 
	COUNT(o.order_id) as total_orders,
	RANK() OVER(PARTITION BY r.city ORDER BY  COUNT(o.order_id) DESC) AS RANK
 FROM orders as o
 JOIN 
 restaurants as r 
 ON r.restaurant_id = o.restaurant_id 
 GROUP BY 1,2,3;


--NOW WE WILL SEE WITHIN EACH CITY MOST POPULAR DISH 
SELECT *
FROM
(SELECT 
    r.city,
	r.restaurant_name,
	o.order_item , 
	COUNT(o.order_id) as total_orders,
	RANK() OVER(PARTITION BY r.city ORDER BY  COUNT(o.order_id) DESC) AS RANK
 FROM orders as o
 JOIN 
 restaurants as r 
 ON r.restaurant_id = o.restaurant_id 
 GROUP BY 1,2,3) AS T1
 WHERE RANK = 1;




--12:CUSTOMER CHURN ---

--FIND CUSTOMERS WHO HAVEN'T PLACED ORDER IN 2024 BUT DID INN 2023 


--first we will break the question and find the customer who has placed order in 2023 
--second we will find the customer who has not placed order in 2024 


--first selecting from orders 

select*from orders;

select distinct customer_id from orders 
where extract(year from order_date) = 2023;


--now applying subquery for 2024 

select distinct customer_id from orders 
where extract(year from order_date) = 2023
and 
customer_id not in
    (select distinct customer_id from orders 
	where extract(year from order_date) = 2024);



--now we will fetch the customer name also 
select * from customers;


select distinct 
      o.customer_id,
	  c.customer_name
from orders as o 
join 
customers as c 
on c.customer_id = o.customer_id
where extract(year from o.order_date) = 2023
and 
o.customer_id not in
    (select distinct o.customer_id from orders  as o
	where extract(year from o.order_date) = 2024)
group by 1 , 2;



--13 : CANCELLATION RATE COMPARISON 

--calculate and compare thr order cancellation rate for each restaurant between the 
--current year and previous year 

select * from orders ;

select 
  restaurant_id ,
  count(order_id)
from orders 
Where extract ( year  from order_date) = 2023
group by 1


--now joining hte table we get 

select 
    o.restaurant_id,
	Count(o.order_id) as total_orders,
	Count(Case when d.delivery_id is null Then 1 End) as not_delivered 
from orders as o 
left join 
deliveries as d 
on o.order_id = d.order_id 
WHERE extract(year from o.order_date) = 2023
group by 1;



--we will do similar for 2024 
select 
    o.restaurant_id,
	Count(o.order_id) as total_orders,
	Count(Case when d.delivery_id is null Then 1 End) as not_delivered 
from orders as o 
left join 
deliveries as d 
on o.order_id = d.order_id 
WHERE extract(year from o.order_date) = 2024
group by 1;


--now finding cancellation rate 
WITH cancel_ratio_2023 
AS 
   (select 
    o.restaurant_id,
	Count(o.order_id) as total_orders,
	Count(Case when d.delivery_id is null Then 1 End) as not_delivered 
   from orders as o 
   left join 
   deliveries as d 
   on o.order_id = d.order_id 
   WHERE extract(year from o.order_date) = 2023
   group by 1
)
SELECT 
     restaurant_id, 
     total_orders,
     not_delivered ,
     ROUND(not_delivered :: numeric/total_orders :: numeric * 100 ,2) as cancel_ratio
from cancel_ratio_2023;




--now doing same for 2024 we get 

WITH cancel_ratio_2024 
AS 
   (select 
    o.restaurant_id,
	Count(o.order_id) as total_orders,
	Count(Case when d.delivery_id is null Then 1 End) as not_delivered 
   from orders as o 
   left join 
   deliveries as d 
   on o.order_id = d.order_id 
   WHERE extract(year from o.order_date) = 2024
   group by 1
)
SELECT 
  restaurant_id, 
  total_orders,
  not_delivered ,
  ROUND(not_delivered :: numeric/total_orders :: numeric * 100 ,2) as cancel_ratio_24
  from cancel_ratio_2024;


--NOW COMPARING WE WILL GET 

WITH cancel_ratio_2023 AS 
   (SELECT 
      o.restaurant_id,
      COUNT(o.order_id) AS total_orders,
      COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS not_delivered 
    FROM orders AS o 
    LEFT JOIN deliveries AS d 
    ON o.order_id = d.order_id 
    WHERE EXTRACT(YEAR FROM o.order_date) = 2023
    GROUP BY 1
),
data_2023 AS
 (SELECT 
      restaurant_id, 
      total_orders,
      not_delivered,
      ROUND(not_delivered::NUMERIC / total_orders::NUMERIC * 100, 2) AS cancel_ratio_23
  FROM cancel_ratio_2023),

cancel_ratio_2024 AS 
   (SELECT 
      o.restaurant_id,
      COUNT(o.order_id) AS total_orders,
      COUNT(CASE WHEN d.delivery_id IS NULL THEN 1 END) AS not_delivered 
    FROM orders AS o 
    LEFT JOIN deliveries AS d 
    ON o.order_id = d.order_id 
    WHERE EXTRACT(YEAR FROM o.order_date) = 2024
    GROUP BY 1
),
data_2024 AS
(SELECT 
    restaurant_id, 
    total_orders,
    not_delivered,
    ROUND(not_delivered::NUMERIC / total_orders::NUMERIC * 100, 2) AS cancel_ratio_24
  FROM cancel_ratio_2024)

SELECT  
  data_2024.restaurant_id, 
  data_2024.cancel_ratio_24 as year_2024_data, 
  data_2023.cancel_ratio_23 as year_2023_data
FROM data_2024 
JOIN data_2023 
ON data_2023.restaurant_id = data_2024.restaurant_id;


--QUESTION : 14 RIDER AVERAGE DELIVERY TIME 
--determine each rider's average delivery time 

--we need to join delivery table and orders table 

select * from orders;

select* from deliveries;

select * from riders ;


select
  o.order_id , 
  d.rider_id ,
  o.order_time ,
  d.delivery_time ,
  d.delivery_time - o.order_time AS time_difference
from  orders as o
JOIN  deliveries as d 
ON o.order_id = d.order_id
WHERE delivery_status = 'Delivered';

--now we will get data in second we will get 

select
  o.order_id , 
  d.rider_id ,
  o.order_time ,
  d.delivery_time ,
  d.delivery_time - o.order_time AS time_difference,
  EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
  CASE WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' ELSE INTERVAL '0 day' END)) as time_difference_second
from  orders as o
JOIN  deliveries as d 
ON o.order_id = d.order_id;
WHERE delivery_status = 'Delivered';


--now having this data in minutes we get 

select
  o.order_id , 
  d.rider_id ,
  o.order_time ,
  d.delivery_time ,
  d.delivery_time - o.order_time AS time_difference,
  EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
  CASE WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' ELSE INTERVAL '0 day' END))/60 as time_difference_in_min
from  orders as o
JOIN  deliveries as d 
ON o.order_id = d.order_id;
WHERE delivery_status = 'Delivered';





--15 :Monthly Restaurant Growth Ratio ----

--calculate each restaurant's growth ratio based on the total number of delivered orders since its joining 


select * from orders;

--now joining two tables we get 

select *,
      o.restaurant_id ,
	  r.restaurant_name,
	  TO_CHAR(o.order_date ,'mm-yy') as month
from orders as o 
join 
deliveries as d 
on o.order_id = d.order_id 
join 
restaurants as r 
on r.restaurant_id = o.restaurant_id ;

--now counting orders 
select 
      o.restaurant_id ,
	  r.restaurant_name,
	  TO_CHAR(o.order_date ,'mm-yy') as month,
	  count(o.order_id ) as current_month_orders
from orders as o 
join 
deliveries as d 
on o.order_id = d.order_id 
join 
restaurants as r 
on r.restaurant_id = o.restaurant_id 
GROUP BY 1 , 2 , 3
ORDER BY 1,3;

--now finding growth ratio we get  

select 
      o.restaurant_id ,
	  r.restaurant_name,
	  TO_CHAR(o.order_date ,'mm-yy') as month,
	  count(o.order_id ) as current_month_orders,
	  LAG(COUNT(o.order_id),1)OVER(PARTITION BY o.restaurant_id ORDER BY  TO_CHAR(o.order_date ,'mm-yy')) AS PREV_MONTH_ORDER
from orders as o 
join 
deliveries as d 
on o.order_id = d.order_id 
join 
restaurants as r 
on r.restaurant_id = o.restaurant_id 
WHERE d.delivery_status = 'Delivered'
GROUP BY 1 , 2 , 3
ORDER BY 1,3;


--now using cte 

WITH growth_ratio 
AS 
(select 
      o.restaurant_id ,
	  r.restaurant_name,
	  TO_CHAR(o.order_date ,'mm-yy') as month,
	  count(o.order_id ) as current_month_orders,
	  LAG(COUNT(o.order_id),1)OVER(PARTITION BY o.restaurant_id ORDER BY  TO_CHAR(o.order_date ,'mm-yy')) AS PREV_MONTH_ORDER
from orders as o 
join 
deliveries as d 
on o.order_id = d.order_id 
join 
restaurants as r 
on r.restaurant_id = o.restaurant_id 
WHERE d.delivery_status = 'Delivered'
GROUP BY 1 , 2 , 3
ORDER BY 1,3
)
select 
   restaurant_id , 
    month, 
   PREV_MONTH_ORDER,
   current_month_orders ,
   ROUND((current_month_orders::numeric-PREV_MONTH_ORDER::numeric)/PREV_MONTH_ORDER*100 ::numeric , 2) as growthratio
from growth_ratio ;


--16: CUSTOMER SEGMENTATION --

--CUSTOMER SEGMENTATIN SEGEMENT CUSTOMER 'GOLD' OR 'SILVER' BASED ON THEIR TOTAL SPENDING 
--COMPAREED TO THE AVERAGE ORDER VALUE (AOV) IF THE CUSTOMER TOTAL SPENDING  EXCEDDS THE AOV 
--LABEL THEM AS 'GOLD'; OTHERWISE LABLE THEM AS ' SILVER'.WRITE AN SQL QUERY TO DETERMINE EACH SEFEMENT 
--TOTAL NO OF ORDERS AND TOTAL  REVENUE 


SELECT * FROM orders;

--what we customer total spent 
--average value 
--gold 
--silver
--each category of total orders and total revenue 

SELECT 
   customer_id,
   SUM(total_amount) as total_spent 
FROM orders
GROUP BY 1;


--now total sum we get 
SELECT AVG(total_amount) from orders; --322.8216

--applying case when 
SELECT 
   o.customer_id,
   c.customer_name,
   SUM(o.total_amount) as total_spent,
   COUNT(o.order_id) as total_orders,
   CASE WHEN SUM(o.total_amount) > (SELECT AVG(total_amount) from orders) THEN 'Gold'
   ELSE 'Silver'
   END AS customer_cateogry
FROM orders as o 
    JOIN 
  customers as c
  ON c.customer_id = o.customer_id 
GROUP BY 1 , 2;

--now applying this query as a subquery to see total gold and silver 
select 
   customer_category,
   SUM(total_orders) as total_orders,
   SUM(total_spent) as total_Spent
FROM
(SELECT 
   o.customer_id,
   c.customer_name,
   SUM(o.total_amount) as total_spent,
   COUNT(o.order_id) as total_orders,
   CASE WHEN SUM(o.total_amount) > (SELECT AVG(total_amount) from orders) THEN 'Gold'
   ELSE 'Silver'
   END AS customer_category
FROM orders as o 
    JOIN 
  customers as c
  ON c.customer_id = o.customer_id 
GROUP BY 1 , 2) as t1
GROUP BY 1 ;







--17: RIDER MONTHLY EARNINGS 
--CALCULATE EACH RIDER'S TOTAL MONTHLY EARNINGS , ASSUMING THEY EARN 8% OF THE ORDER AMOUNT 

select * from deliveries;
select *  from riders;
--first joining orders and deliveries  
select * 
from orders as o
  join 
  deliveries as d 
on o.order_id = d.order_id ;

--now selecting the deliver_id and we get

select 
  d.rider_id ,
  TO_CHAR(o.order_date , 'mm-yy') as month ,
  SUM(o.total_amount) as total_revenue_company 
from orders as o
  join 
  deliveries as d 
on o.order_id = d.order_id 
group by 1 , 2
order by 1 , 3 desc;


--now getting each rider monthly earnings assuming they earn 8% of the order amount 

select 
  d.rider_id ,
  TO_CHAR(o.order_date , 'mm-yy') as month ,
  SUM(o.total_amount) as total_revenue_company,
  SUM(o.total_amount)*0.08 as riders_earnings
from orders as o
  join 
  deliveries as d 
on o.order_id = d.order_id 
group by 1 , 2
order by 1 , 3 desc;

--now also getting riders's name 
 select 
  d.rider_id ,
  r.rider_name,
  TO_CHAR(o.order_date , 'mm-yy') as month ,
  SUM(o.total_amount) as total_revenue_company,
  SUM(o.total_amount)*0.08 as riders_earnings
from orders as o
  join 
  deliveries as d 
on o.order_id = d.order_id
  join 
  riders as r
on r.rider_id = d.rider_id

group by d.rider_id ,r.rider_name ,month 
order by d.rider_id , total_revenue_company desc;


--18: RIDERS RATINGS ANALYSIS 
--FIND THE NUMBERS 5 STAR , 4 STAR AND 3 STAR RATINGS EACH RIDERS HAS
--RIDER RECEIVES THIS RATING BASED ON DELIVERY TIME 
--IF ORDERS ARE DELIVERED LESS THAN 15 MINTUTES OF ORDERS RECEIEVED TIME THEN RIDERS GET 5 STAR RATING 
--IF THEY DELIVERED 15 AND 20 MINUTE THEY GET 5 STAR 
--IF THEY DELIVERED AFTER 20 MINUTES THEY 3 STAR RATINGS 


--SOLUTION 

--first join the orders table and delivery table 

SELECT * 
FROM orders as o 
      JOIN 
	  deliveries as d
ON o.order_id = d.order_id
WHERE d.delivery_status = 'Delivered';

SELECT 
  o.order_id ,
  o.order_time,
  d.delivery_time ,
  d.rider_id
FROM orders as o 
      JOIN 
	  deliveries as d
ON o.order_id = d.order_id
WHERE d.delivery_status = 'Delivered';


--now finding the difference between order time ans delivery_time we get 


SELECT 
  o.order_id ,
  o.order_time,
  d.delivery_time ,
  EXTRACT(EPOCH FROM (d.delivery_time - o.order_time))/60 ,
  d.rider_id
FROM orders as o 
      JOIN 
	  deliveries as d
ON o.order_id = d.order_id
WHERE d.delivery_status = 'Delivered';

--now we want the answer in positive value so we will use case when 

SELECT 
  o.order_id ,
  o.order_time,
  d.delivery_time ,
  EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
  CASE 
  WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
  ELSE INTERVAL '0 day' END
  ))/60  as delivery_took_time,
  d.rider_id
FROM orders as o 
      JOIN 
	  deliveries as d
ON o.order_id = d.order_id
WHERE d.delivery_status = 'Delivered';

--now applying CTE we get 
SELECT 
rider_id ,
delivery_took_time
FROM
    (SELECT 
         o.order_id ,
         o.order_time,
         d.delivery_time ,
         EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
         CASE 
        WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
        ELSE INTERVAL '0 day' END
         ))/60  as delivery_took_time,
         d.rider_id
     FROM orders as o 
         JOIN 
	    deliveries as d
       ON o.order_id = d.order_id
      WHERE d.delivery_status = 'Delivered'
) as t1;

--now applying cte again 
       SELECT 
           rider_id ,
          delivery_took_time,
		  CASE WHEN delivery_took_time < 15 THEN '5 Star' 
		       WHEN delivery_took_time  BETWEEN 15 AND 20 THEN '4 Star'
			   ELSE '3 STAR'
			   END as Stars 
           FROM
              (SELECT 
                  o.order_id ,
                  o.order_time,
                  d.delivery_time ,
                  EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
                        CASE 
                    WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
                    ELSE INTERVAL '0 day' END
                    ))/60  as delivery_took_time,
                    d.rider_id
                FROM orders as o 
                  JOIN 
	           deliveries as d
               ON o.order_id = d.order_id
              WHERE d.delivery_status = 'Delivered'
            ) as t1;

SELECT
      rider_id ,
	  Stars ,
	  COUNT(*) AS total_stars 
FROM
        (SELECT 
           rider_id ,
          delivery_took_time,
		  CASE WHEN delivery_took_time < 15 THEN '5 Star' 
		       WHEN delivery_took_time  BETWEEN 15 AND 20 THEN '4 Star'
			   ELSE '3 STAR'
			   END as Stars 
           FROM
              (SELECT 
                  o.order_id ,
                  o.order_time,
                  d.delivery_time ,
                  EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
                        CASE 
                    WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
                    ELSE INTERVAL '0 day' END
                    ))/60  as delivery_took_time,
                    d.rider_id
                FROM orders as o 
                  JOIN 
	           deliveries as d
               ON o.order_id = d.order_id
              WHERE d.delivery_status = 'Delivered'
            ) as t1
		) AS t2 
		GROUP BY 1,2 
		ORDER BY 1 , 3 DESC;


--19 : ORDER BY FREQUENCY BY DAY
--ANALYZE ORDER FRQUENCY PER DAY OF THE WEEK AND IDENTIFY THE PEAK DAY FOR EACH RESTAURANT 

select * from orders;

--now joining the table orders and restaurant 

select 
      r.restaurant_name , 
	  o.order_date ,
	  o.order_id
     from orders as o 
	  join 
	 restaurants as r 
on o.restaurant_id = r.restaurant_id ;


--now converting this to a day we get 
select 
      r.restaurant_name , 
	  o.order_date ,
	  TO_CHAR(o.order_date , 'Day'),
	  o.order_id 
     from orders as o 
	  join 
	 restaurants as r 
on o.restaurant_id = r.restaurant_id;

--now group by applying we get 

select 
      r.restaurant_name , 
	  TO_CHAR(o.order_date , 'Day'),
	  COUNT(o.order_id) as total_orders 
     from orders as o 
	  join 
	 restaurants as r 
on o.restaurant_id = r.restaurant_id
GROUP BY 1 , 2 
ORDER BY 1 ,3 DESC;

-- NOW APPLY RANK FUNCTION TO GET THE RANK WE GET 
select 
      r.restaurant_name , 
	  TO_CHAR(o.order_date , 'Day'),
	  COUNT(o.order_id) as total_orders,
	  RANK()OVER(PARTITION BY r.restaurant_name ORDER BY COUNT(o.order_id) DESC) AS RANK
     from orders as o 
	  join 
	 restaurants as r 
on o.restaurant_id = r.restaurant_id
GROUP BY 1 , 2 
ORDER BY 1 ,3 DESC;


--now apply cte we get to which day restaurant has the highest order
SELECT * 
FROM 
(select 
      r.restaurant_name , 
	  TO_CHAR(o.order_date , 'Day'),
	  COUNT(o.order_id) as total_orders,
	  RANK()OVER(PARTITION BY r.restaurant_name ORDER BY COUNT(o.order_id) DESC) AS RANK
     from orders as o 
	  join 
	 restaurants as r 
on o.restaurant_id = r.restaurant_id
GROUP BY 1 , 2 
ORDER BY 1 ,3 DESC
) AS t1
WHERE RANK = 1;



--20: CUSTOMER LIFETIME VALUE (CLV)
--CALCULATE THE TOTAL REVENUE GENERATED BY EACH CUSTOMER OVER ALL ORDERS 


SELECT * FROM orders ;

--now get customer_id and sum total_Amount we get 

select 
  customer_id , 
  SUM(total_amount) as customer_lifetime_value 
FROM orders 
GROUP BY 1;

--now we are want customer name and now joining two tables customer table and orders we get  

select 
  o.customer_id , 
  c.customer_name,
  SUM(o.total_amount) as customer_lifetime_value
FROM orders  as o
   JOIN 
   customers as c 
   ON o.customer_id = c.customer_id
GROUP BY 1,2
ORDER BY 1, 3;


-- 21 : MONTHLY SALES TRENDS
--IDENTIFY SALES TRENDS BY COMPARING EACH MONTH'S TOTAL SALES TO PREVIOUS MONTH 

SELECT * FROM orders;

--now extracting year and month we get 
SELECT   
    EXTRACT(YEAR FROM order_date) as year ,
	EXTRACT(MONTH FROM order_date) as month , 
	SUM(total_amount) as total_sale
FROM orders
GROUP BY 1 , 2 
ORDER BY 1 , 2;


--now applying lag fuction to get previous month sale we get 
SELECT   
    EXTRACT(YEAR FROM order_date) as year ,
	EXTRACT(MONTH FROM order_date) as month , 
	SUM(total_amount) as total_sale ,
	LAG(SUM(total_amount),1) OVER(ORDER BY 
	EXTRACT(YEAR FROM order_date) ,
	EXTRACT(MONTH FROM order_date)) AS prev_month_sale
FROM orders
GROUP BY 1 , 2 
ORDER BY 1 , 2;


--20 : RIDER EFFIENCY 

--EVALUATE RIDER EFFICIENCY BY DETERMINIG AVERAGE DELIVERY TIMES AND IDENTIFYING THOSE LOWEST AND HIGHEST AVERAGE


SELECT * FROM orders;
SELECT * FROM deliveries ;
SELECT * FROM riders ;


--now joining deliveries and orders and riders table we get 

select * from orders as o 
    join 
	deliveries as d 
	ON  o.order_id = d.order_id 
	join 
	riders as r 
	on r.rider_id = d.rider_id 

where delivery_status = 'Delivered';

--now finding delivery time we get 
select 
     d.rider_id ,
	 r.rider_name,
     EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
                        CASE 
                    WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
                    ELSE INTERVAL '0 day' END
                    ))/60  as time_delivered
from orders as o 
    join 
	deliveries as d 
	ON  o.order_id = d.order_id 
	join 
	riders as r 
	on r.rider_id = d.rider_id 

where delivery_status = 'Delivered';


SELECT * 
   FROM 
   (select 
     d.rider_id ,
	 r.rider_name,
     EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
                        CASE 
                    WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
                    ELSE INTERVAL '0 day' END
                    ))/60  as time_delivered
from orders as o 
    join 
	deliveries as d 
	ON  o.order_id = d.order_id 
	join 
	riders as r 
	on r.rider_id = d.rider_id 

where delivery_status = 'Delivered'

) AS T1;


--now applying cte we get
 WITH new_table 
   AS 
   (select 
     d.rider_id ,
	 r.rider_name,
     EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
                        CASE 
                    WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
                    ELSE INTERVAL '0 day' END
                    ))/60  as time_delivered
from orders as o 
    join 
	deliveries as d 
	ON  o.order_id = d.order_id 
	join 
	riders as r 
	on r.rider_id = d.rider_id 

where delivery_status = 'Delivered'

) 
SELECT 
  rider_id ,
  rider_name,
 AVG(time_delivered) as avg_time_in_min
FROM new_table
GROUP BY 1,2;

--now finding maximum and minimum time we get 
 WITH new_table 
   AS 
   (select 
     d.rider_id ,
	 r.rider_name,
     EXTRACT(EPOCH FROM (d.delivery_time - o.order_time + 
                        CASE 
                    WHEN d.delivery_time < o.order_time THEN INTERVAL '1 day' 
                    ELSE INTERVAL '0 day' END
                    ))/60  as time_delivered
from orders as o 
    join 
	deliveries as d 
	ON  o.order_id = d.order_id 
	join 
	riders as r 
	on r.rider_id = d.rider_id 

where delivery_status = 'Delivered'

), 
rider_time AS
(SELECT 
  rider_id ,
  rider_name,
 AVG(time_delivered) as avg_time_in_min
FROM new_table
GROUP BY 1,2)
SELECT 
   MIN(avg_time_in_min),
   MAX(avg_time_in_min)
FROM rider_time;


--21 : ORDER ITEM POPULARITY 
--TRACK THE POPULARITY OF SPECIFIC ORDER ITEMS OVER TIME AND IDENTIFY SEASONAL DEMAND SPIKES


SELECT 
     *,
	 EXTRACT(MONTH FROM order_date ) as month 
FROM orders;

--putting them in a category of summer, spring and winter and autumn 
SELECT 
     *,
	 EXTRACT(MONTH FROM order_date ) as month,
     CASE 
	 WHEN EXTRACT(MONTH FROM order_date )BETWEEN  4 AND 6 THEN 'SPRING'
	 WHEN EXTRACT(MONTH FROM order_date ) > 6 AND
	      EXTRACT(MONTH FROM order_date ) < 9 THEN 'SUMMER'
	ELSE 'WINTER'
	END AS seasons
FROM orders;

--now applying cte we get 

SELECT 
    order_item ,
	seasons ,
	COUNT(order_id) as total_orders
FROM
   (SELECT 
     *,
	 EXTRACT(MONTH FROM order_date ) as month,
     CASE 
	 WHEN EXTRACT(MONTH FROM order_date )BETWEEN  4 AND 6 THEN 'SPRING'
	 WHEN EXTRACT(MONTH FROM order_date ) > 6 AND
	      EXTRACT(MONTH FROM order_date ) < 9 THEN 'SUMMER'
	ELSE 'WINTER'
	END AS seasons
FROM orders) AS t1
GROUP BY 1,2 
ORDER BY 1, 3 DESC ;


--22 : RANK EACH CITY BASED ON THE TOTAL REVENUE LAST YEAR 2023

--first doing join between restaurant and order we get 

select * 
from orders as o 
    join 
   restaurants as r
   ON o.restaurant_id = r.restaurant_id ;

--now selecting city and total amount to get revenue of each city 

select 
    r.city,
	SUM(total_amount) as total_revenue
from orders as o 
    join 
   restaurants as r
   ON o.restaurant_id = r.restaurant_id
GROUP BY 1;

--now applying window fucntion rank to get rankings of the city
   
select 
    r.city,
	SUM(total_amount) as total_revenue,
	RANK()OVER(ORDER BY SUM(total_amount) DESC) AS city_rank
from orders as o 
    join 
   restaurants as r
   ON o.restaurant_id = r.restaurant_id
GROUP BY 1;




---END OF PROJECT ---