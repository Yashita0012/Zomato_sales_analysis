--CREATED A ZOMATO DB 

--CREATING A TABLE CUSTOMERS
CREATE TABLE customers 
     (
         customer_id INT PRIMARY KEY ,
		 customer_name	 VARCHAR(30),
		 reg_date DATE

     );

--CREATING SECOND TABLE 
--CREATING TABLE RESTAURANT

CREATE TABLE restaurants
      (
                restaurant_id	INT PRIMARY KEY ,
				restaurant_name	 VARCHAR(55),
				city  VARCHAR(15),
				opening_hours VARCHAR(55)
	  );


--CREATING ORDERS TABLE WE GET 

CREATE TABLE orders 
    (
        order_id INT PRIMARY KEY ,
		customer_id INT , --THIS IS A FOREIGN KEY COMING FROM CUSTOMER TABLE 
		restaurant_id INT , --THIS IS A FOREIGN KEY COMING FROM RESTAURANT TABLE 
		order_item	VARCHAR(55),
		order_date  DATE,
		order_time	TIME ,
		order_status VARCHAR(55),
		total_amount FLOAT
	);

--CREATING RIDERS TABLE WE GET
CREATE TABLE riders
     (
          rider_id INT PRIMARY KEY ,
		  rider_name VARCHAR(55),
		  sign_up  DATE
	 );

--NOW CREATING TABLE DELIVERY

CREATE TABLE deliveries 
      (
         delivery_id  INT PRIMARY KEY ,
		 order_id INT , --THIS IS COMING FROM  ORDERS TABLE 
		 delivery_status  VARCHAR(35),
		 delivery_time	 TIME ,
		 rider_id INT --THIS IS COMING FROM RIDERS TABLE

	  );


--adding foreign key constraint in orders table 
ALTER TABLE orders 
ADD CONSTRAINT fk_customers
FOREIGN KEY(customer_id)
REFERENCES customers(customer_id);

--adding another foreign key constraint in orders table
ALTER TABLE orders 
ADD CONSTRAINT fk_restaurant
FOREIGN KEY(restaurant_id)
REFERENCES restaurants(restaurant_id);

--now dropping table deliveries just to able constraint while creating table

DROP TABLE IF EXISTS deliveries;
--now creating it again to add constraint to the table 
CREATE TABLE deliveries 
      (
         delivery_id  INT PRIMARY KEY ,
		 order_id INT , --THIS IS COMING FROM  ORDERS TABLE 
		 delivery_status  VARCHAR(35),
		 delivery_time	 TIME ,
		 rider_id INT , --THIS IS COMING FROM RIDERS TABLE 
		 CONSTRAINT fk_orders FOREIGN KEY (order_id) REFERENCES orders(order_id),
		 CONSTRAINT fk_rider FOREIGN KEY (rider_id) REFERENCES riders(rider_id)
	  );


