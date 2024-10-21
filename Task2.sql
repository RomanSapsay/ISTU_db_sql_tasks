INSERT INTO city (city_id, city, country_id) VALUES ( (SELECT MAX(city_id) + 1 FROM city), 'San Francisco', 103 );
INSERT INTO address (address_id, address, city_id, district) VALUES ( (SELECT MAX(address_id) + 1 FROM address), '123 Main St', (SELECT MAX(city_id) FROM city), 'South of Market' );
INSERT INTO customer (first_name, last_name, address_id, store_id) VALUES ('Alice', 'Cooper', (SELECT MAX(address_id) FROM address), 2);

UPDATE address
SET address = '456 Elm St'
WHERE address_id = (
SELECT a.address_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
WHERE c.first_name = 'Alice' AND c.last_name = 'Cooper'
);

DELETE from customer c 
WHERE c.first_name = 'Alice' AND c.last_name = 'Cooper';