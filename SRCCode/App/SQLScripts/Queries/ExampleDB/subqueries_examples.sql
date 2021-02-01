SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  lastName varchar(50),
  firstName varchar(50),
  officeCode varchar(50)
);

DROP TABLE IF EXISTS offices;
CREATE TABLE offices (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  officeCode varchar(50),
  country varchar(50)
);

DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customerNumber varchar(50),
  checkNumber varchar(50),
  amount varchar(50)
);

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customerName varchar(50),
  customerNumber varchar(50)
);

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customerNumber varchar(50),
  orderNumber varchar(50)
);

DROP TABLE IF EXISTS orderdetails;
CREATE TABLE orderdetails (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  customerNumber varchar(50),
  quantityOrdered varchar(50),
  orderNumber varchar(50),
  priceEach varchar(50)
);

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id int(10) unsigned NOT NULL PRIMARY KEY AUTO_INCREMENT,
  productName varchar(50),
  buyprice varchar(50),
  productline varchar(50)
);

# INSERT STATEMENTS HERE:




# QUERIES HERE:
SET FOREIGN_KEY_CHECKS=1;
# Subquery WHERE clause:
SELECT lastName, firstName
FROM employees
WHERE officeCode IN (SELECT officeCode FROM offices WHERE country = 'USA');

SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount = (SELECT MAX(amount) FROM payments);


SELECT customerNumber, checkNumber, amount
FROM payments
WHERE amount > (SELECT AVG(amount) FROM payments);


SELECT customerName
FROM customers
WHERE customerNumber NOT IN (SELECT DISTINCT customerNumber FROM orders);


# Subquery in FROM clause:
SELECT MAX(items), MIN(items), FLOOR(AVG(items))
FROM (SELECT orderNumber, COUNT(orderNumber) AS items FROM orderdetails GROUP BY orderNumber) AS lineitems;


# Correlated SUBQUERIES (uses outer query result in subquery)
SELECT productname, buyprice
FROM products p1
WHERE buyprice > (SELECT AVG(buyprice) FROM products WHERE productline = p1.productline);

SELECT customerNumber, customerName
FROM customers
WHERE EXISTS(
        SELECT orderNumber, SUM(priceEach * quantityOrdered)
        FROM orderdetails
        INNER JOIN orders USING (orderNumber)
        WHERE orders.customerNumber = customers.customerNumber
        GROUP BY orderNumber
        HAVING SUM(priceEach * quantityOrdered) > 60000
    );
