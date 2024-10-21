SELECT f.title as "Назва фільму", f.length as "Тривалість фільму", c.name as "Категорія фільму"
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

SELECT c.first_name as "Ім'я", c.last_name as "Фамілія", r.rental_period as "Дата оренди", f.title as "Назва фільму"
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE c.first_name = 'MARY' AND c.last_name = 'SMITH'
ORDER BY f.title ASC;

SELECT f.title AS "Назва фільму",  
COUNT(r.rental_id) AS "Кількість оренд" 
FROM film f
JOIN inventory i ON f.film_id = i.film_id 
JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY f.title 
ORDER BY COUNT(r.rental_id) DESC 
LIMIT 5;
