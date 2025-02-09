# Zomato_sales_analysis
## 📌 Overview
This repository contains SQL queries designed for comprehensive business analysis of Zomato's sales and customer behavior. These queries help in understanding key aspects such as order trends, customer segmentation, rider efficiency, restaurant revenue, and more.
## 🏢 About Zomato
Zomato is a global restaurant aggregator and food delivery company headquartered in India. Founded in 2008, Zomato provides detailed restaurant listings, online ordering, and delivery services across multiple countries. The platform connects customers with restaurants, delivery partners, and restaurant owners, facilitating a seamless food experience. Zomato's vast dataset allows for deep business insights into customer behavior, restaurant performance, and operational efficiency.
## 📂 Repository Contents
* EDA_Zomato_sales_analysis.sql - Exploratory Data Analysis (EDA) queries related to Zomato's sales performance.
* ZOMATO_sales_analysis.sql - Analytical SQL queries addressing key business challenges and insights

## 🗄️ Database & Technology Stack
* Database Used: Zomato Database
* SQL Engine: PostgreSQL
* Schema Components: Customers, Orders, Restaurants, Riders, Deliveries

## 📊 Business Problems Solved
* Identifying high-value customers and frequent buyers.
* Analyzing sales trends and revenue growth by city and restaurant.
* Understanding peak order times and improving delivery efficiency.
* Detecting order cancellations and customer churn patterns.
* Ranking top-performing dishes and restaurants based on popularity.
* Enhancing rider performance analysis with delivery time tracking.
* Evaluating customer lifetime value (CLV) and spending behaviors.

## 📝 Zomato Business Challenges & SQL Solutions
This repository aims to solve the following 20 advanced business problems using SQL:
#### 1. Top 5 Most Frequently Ordered Dishes

**Goal**: Identify the top 5 most frequently ordered dishes by customer Arjun Mehta in the past year.

#### 2. Popular Time Slots

**Goal**: Determine the most active time slots for orders, grouped in 2-hour intervals.

#### 3. Order Value Analysis

**Goal**: Calculate the Average Order Value (AOV) for customers who have placed more than 750 orders.

#### 4. High-Value Customers

**Goal**: Identify customers who have spent over 100K in total food orders.

#### 5. Orders Without Delivery

**Goal**: Identify orders that were placed but not delivered, along with the restaurant name, city, and count of undelivered orders.

#### 6. Restaurant Revenue Ranking

**Goal**: Rank restaurants based on their total revenue over the last year, including city-wise ranking.

#### 7. Most Popular Dish by City

**Goal**: Find the most frequently ordered dish in each city.

#### 8. Customer Churn

**Goal**: Identify customers who placed orders in 2023 but not in 2024.

#### 9. Cancellation Rate Comparison

**Goal**: Compare the order cancellation rates for each restaurant between the current and previous year.

#### 10. Rider Average Delivery Time

**Goal**: Compute the average delivery time for each rider.

#### 11. Monthly Restaurant Growth Ratio

**Goal**: Analyze the growth ratio of restaurants based on delivered orders since their launch.

#### 12. Customer Segmentation

**Goal**: Classify customers into Gold or Silver based on their total spending relative to the AOV.

#### 13. Rider Monthly Earnings

**Goal**: Calculate each rider’s monthly earnings, assuming they earn 8% of the order value.

#### 14. Rider Ratings Analysis

**Goal**: Analyze rider ratings based on delivery time:

**5-star**: Delivered in under 15 minutes

**4-star**: Delivered in 15-20 minutes

**3-star**: Delivered in more than 20 minutes

#### 15. Order Frequency by Day

**Goal**: Identify peak order days for each restaurant by analyzing order frequency per day of the week.

#### 16. Customer Lifetime Value (CLV)

**Goal**: Compute the total revenue generated by each customer over their lifetime.

#### 17. Monthly Sales Trends

**Goal**: Track sales trends by comparing each month's total sales with the previous month.

#### 18. Rider Efficiency
 
 **Goal**: Evaluate rider efficiency by computing average delivery times and identifying the most and least efficient riders.

#### 19. Order Item Popularity

**Goal**: Monitor the popularity of specific food items over time and detect seasonal demand fluctuations.

#### 20. City Revenue Ranking

**Goal**: Rank cities based on total revenue for the last year (2023)

#### CREATING A DATABASE AND SQL QUERIES 
**Creating a database named Zomato Db**

'''SQL
**Creating table called customers**


CREATE TABLE customers 
     ( customer_id INT PRIMARY KEY ,
		 customer_name	 VARCHAR(30),
		 reg_date DATE);

**Creating table called restaurant**

CREATE TABLE restaurants
      (restaurant_id	INT PRIMARY KEY ,
				restaurant_name	 VARCHAR(55),
				city  VARCHAR(15),
				opening_hours VARCHAR(55) );

****Creating table called  orders****

CREATE TABLE orders 
    ( order_id INT PRIMARY KEY ,
		customer_id INT , --THIS IS A FOREIGN KEY COMING FROM CUSTOMER TABLE 
		restaurant_id INT , --THIS IS A FOREIGN KEY COMING FROM RESTAURANT TABLE 
		order_item	VARCHAR(55),
		order_date  DATE,
		order_time	TIME ,
		order_status VARCHAR(55),
		total_amount FLOAT);

****Creating table called riders****
CREATE TABLE riders
     (rider_id INT PRIMARY KEY ,
		  rider_name VARCHAR(55),
		  sign_up  DATE );

****Creating table called deliveries****
CREATE TABLE deliveries 
      (delivery_id  INT PRIMARY KEY ,
		 order_id INT , --THIS IS COMING FROM  ORDERS TABLE 
		 delivery_status  VARCHAR(35),
		 delivery_time	 TIME ,
		 rider_id INT --THIS IS COMING FROM RIDERS TABLE);

**NOW ALTERING AND ADDING FOREIGN KEY CONSTAINT IN CUSTOMERS TABLE**
ALTER TABLE orders 
ADD CONSTRAINT fk_customers
FOREIGN KEY(customer_id)
REFERENCES customers(customer_id);

**NOW ALTERING AND ADDING FOREIGN KEY CONSTAINT IN RESTAURANTS TABLE**
ALTER TABLE orders 
ADD CONSTRAINT fk_restaurant
FOREIGN KEY(restaurant_id)
REFERENCES restaurants(restaurant_id);

**NOW ALTERING AND ADDING FOREIGN KEY CONSTAINT IN DELIVERIES TABLE**

DROP TABLE IF EXISTS deliveries;
CREATE TABLE deliveries 
      (delivery_id  INT PRIMARY KEY ,
		 order_id INT , --THIS IS COMING FROM  ORDERS TABLE 
		 delivery_status  VARCHAR(35),
		 delivery_time	 TIME ,
		 rider_id INT , --THIS IS COMING FROM RIDERS TABLE 
		 CONSTRAINT fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
		 CONSTRAINT fk_rider FOREIGN KEY (rider_id) REFERENCES riders(rider_id));




