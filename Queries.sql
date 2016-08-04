SELECT * FROM members;

SELECT * FROM user;

UPDATE user SET billing_address_id = null WHERE id = 1;

SELECT * FROM address;

SELECT id FROM address WHERE house_no = 'Uhouse1' LIMIT 1;

SELECT id FROM address WHERE house_no = 'Uhouse1' AND street = 'street1' AND subdivision = 'subdivision1' AND city = 'city1' AND postal_code = ? AND country = ? LIMIT 1;

SELECT * FROM category;
SELECT product.id, product.name, description, category_id, category.name AS c_name FROM product INNER JOIN category ON product.category_id = category.id;
SELECT product.id, product.name, description, category_id, category.name AS c_name FROM product INNER JOIN category ON product.category_id = category.id WHERE product.id = 1;
INSERT INTO category (name) VALUES ('slippers');

INSERT INTO product (name, description, price, category_id, isArchived) VALUES (?,?,?,?,?);

SELECT * FROM product WHERE category_id = (SELECT id FROM category WHERE name = 'shoes');

SELECT * FROM review;
UPDATE product SET name = 'new' AND description = 'boot1des' AND price = 1 AND category_id = 1 AND isActive = 1 WHERE id = 1;

SELECT * FROM transaction;

SELECT * FROM transaction_entry;

SET FOREIGN_KEY_CHECKS = 0; -- disable a foreign keys check

truncate address;

SET FOREIGN_KEY_CHECKS = 1; -- enable a foreign keys check

SELECT * FROM transaction;
SELECT * FROM transaction_entry;
SELECT * FROM category;
SELECT * FROM product;

SELECT * FROM user;
/*
	Get Transaction rby Product
*/
SELECT TE.product_id, P.name, SUM(TE.quantity) AS quantity, TE.price * SUM(TE.quantity) AS total FROM transaction_entry TE INNER JOIN product P ON TE.product_id = P.id GROUP BY product_id;
/*
	Get Transaction by Category
*/
/*SELECT TE.product_id, P.name, C.id, C.name AS c_name, SUM(TE.quantity) AS quantity, TE.price * SUM(TE.quantity) AS total FROM transaction_entry TE INNER JOIN product P ON TE.product_id = P.id INNER JOIN category C ON C.id = P.category_id GROUP BY product_id;*/
SELECT id, c_name, SUM(quantity) AS quantity, SUM(total) AS total FROM (SELECT TE.product_id, P.name, C.id, C.name AS c_name, SUM(TE.quantity) AS quantity, TE.price * SUM(TE.quantity) AS total FROM transaction_entry TE INNER JOIN product P ON TE.product_id = P.id INNER JOIN category C ON C.id = P.category_id GROUP BY product_id) A GROUP BY c_name;

SELECT * FROM transaction_entry INNER JOIN transaction ON transaction.id = transaction_entry.transaction_id;
SELECT TE.product_id, P.name, C.id, C.name AS c_name, TE.price * SUM(TE.quantity) AS total FROM transaction_entry TE INNER JOIN product P ON TE.product_id = P.id INNER JOIN category C ON C.id = P.category_id GROUP BY product_id;
/*
	Get Transaction Sales per Year
*/
SELECT YEAR(date) AS date, SUM(TE.quantity) AS quantity, SUM(TE.price * TE.quantity) AS total FROM transaction_entry TE INNER JOIN transaction T ON T.id = TE.transaction_id GROUP BY YEAR(date) ORDER BY YEAR(date);
/*month*/
SELECT CONCAT(MONTHNAME(date), ' ', YEAR(date)) AS date, SUM(TE.quantity) AS quantity, SUM(TE.price * TE.quantity) AS total FROM transaction_entry TE INNER JOIN transaction T ON T.id = TE.transaction_id GROUP BY YEAR(date), MONTH(date) ORDER BY YEAR(date), MONTH(date);
/*date*/
SELECT CONCAT(MONTHNAME(date), ' ', DAY(date), ' ', YEAR(date)) AS date, SUM(TE.quantity) AS quantity, SUM(TE.price * TE.quantity) AS total FROM transaction_entry TE INNER JOIN transaction T ON T.id = TE.transaction_id GROUP BY YEAR(date), MONTH(date), DAY(date) ORDER BY YEAR(date), MONTH(date), DAY(date);

SELECT * FROM review;
INSERT INTO review (user_id, product_id, review, date, rating) VALUES (1, 1, 'hi', NOW(), 1);

SELECT AVG(rating) FROM review WHERE product_id = 3;