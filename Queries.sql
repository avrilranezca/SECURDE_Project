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

SELECT FOUND_ROWS(product);

SELECT * FROM product;

SELECT product.id, product.price, product.name, description, category_id, category.name as c_name FROM product INNER JOIN category ON product.category_id = category.id WHERE isActive = 1 ORDER BY id LIMIT 2;

SELECT R.id, R.user_id, U.user_name, R.product_id, R.review, R.date, R.rating FROM review R INNER JOIN user U ON R.user_id = U.id WHERE product_id = 1;

SELECT * FROM transaction;
SELECT * FROM transaction_entry;

SELECT T.id, user_id, user_name FROM transaction T INNER JOIN transaction_entry TE ON T.id = TE.transaction_id INNER JOIN user U on U.id = T.user_id WHERE U.user_name = 'user_2' AND TE.product_id = 1;

SELECT * FROM review;
SELECT * FROM address;

SELECT A.* FROM user U INNER JOIN address A ON U.billing_address_id = A.id WHERE U.id = 2;

SELECT * FROM product;
SELECT * FROM category;
SELECT * FROM user;

UPDATE user SET log_in_attempts = log_in_attempts + 1 WHERE id = 1;
	/*public User(String first_name, String last_name,
			String middle_initial, String user_name, String email,
			String account_type, int isActive)*/
            
SELECT first_name, last_name, middle_initial, user_name, email, account_type_enum, isActive FROM user WHERE isActive = 1 AND account_type_enum NOT LIKE "CUSTOMER" ORDER BY account_type_enum;
SELECT first_name, last_name, middle_initial, user_name, email, account_type_enum, isActive FROM user WHERE isActive = 1 AND account_type_enum LIKE "ACCOUNTING_MANAGER" ORDER BY user_name;

SELECT user_name FROM user WHERE user_name LIKE "user";

SELECT * FROM user;
SELECT * FROM authorization_matrix;

SELECT page_url, customer FROM authorization_matrix WHERE page_url LIKE "/index.jsp";

