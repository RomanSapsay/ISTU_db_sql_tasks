/* №1. Загальна кількість фільмів у кожній категорії: Напишіть SQL-запит, який виведе назву категорії та кількість фільмів у кожній категорії. */

SELECT c.name AS "Жанр фільму", COUNT(f.film_id) AS "Кількість фільмів"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY "Кількість фільмів" DESC;

/* №2. Середня тривалість фільмів у кожній категорії: Напишіть запит, який виведе назву категорії та середню тривалість фільмів у цій категорії. */

SELECT c.name AS "Жанр фільму", AVG(f.length) AS "Середня тривалість фільмів"
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY "Середня тривалість фільмів" DESC;

/* №3. Мінімальна та максимальна тривалість фільмів: Напишіть запит, який виведе мінімальну та максимальну тривалість фільмів у базі даних. */

SELECT MAX(f.length) AS max_length, MIN(f.length) AS min_length
FROM film f;

/* №4. Загальна кількість клієнтів: Напишіть запит, який поверне загальну кількість клієнтів у базі даних. */

SELECT COUNT(customer_id) AS "Загальна кількість клієнтів"
FROM customer;

/* №5. Сума платежів по кожному клієнту: Напишіть запит, який виведе ім'я клієнта та загальну суму платежів, яку він здійснив. */
SELECT c.first_name AS "Ім'я", c.last_name AS "Фамілія", SUM(p.amount) AS "Сума платежів"
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "Сума платежів" DESC;

/* №6. П'ять клієнтів з найбільшою сумою платежів: Напишіть запит, який виведе п'ять клієнтів, які здійснили найбільшу кількість платежів, у порядку спадання. */
SELECT c.first_name AS "Ім'я", c.last_name AS "Фамілія", COUNT(p.payment_id) AS "Кількість платежів"
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "Кількість платежів" DESC
LIMIT 5;

/* №7. Загальна кількість орендованих фільмів кожним клієнтом: Напишіть запит, який поверне ім'я клієнта та кількість фільмів, які він орендував. */
SELECT c.first_name as "Ім'я", c.last_name as "Фамілія", COUNT(r.rental_id) AS "Кількість орендованих фільмів"
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY "Кількість орендованих фільмів" DESC;

/* 8. Середній вік фільмів у базі даних: Напишіть запит, який виведе середній вік фільмів (різниця між поточною датою та роком випуску фільму). */
SELECT AVG(EXTRACT(YEAR FROM CURRENT_DATE) - release_year) AS "Середній вік фільмів"
FROM film;

/* 9. Кількість фільмів, орендованих за певний період: Напишіть запит, який виведе кількість фільмів, орендованих у період між двома вказаними датами. */
SELECT COUNT(rental_id) AS "Кількість орендованих фільмів"
FROM rental
WHERE rental_period && tsrange('2022-05-01 00:00:00', '2022-05-31 23:59:59');

/* 10. Сума платежів по кожному місяцю: Напишіть запит, який виведе загальну суму платежів, здійснених кожного місяця. */
SELECT DATE_TRUNC('month', payment_date) AS "Місяць", SUM(amount) AS "Сума платежів"
FROM payment
GROUP BY DATE_TRUNC('month', payment_date)
ORDER BY "Місяць";

/* 11. Максимальна сума платежу, здійснена клієнтом: Напишіть запит, який виведе максимальну суму окремого платежу для кожного клієнта. */
SELECT c.first_name AS "Ім'я", c.last_name AS "Фамілія", MAX(p.amount) AS "Максимальна сума окремого платежу"
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

/* 12. Середня сума платежів для кожного клієнта: Напишіть запит, який виведе ім'я клієнта та середню суму його платежів. */
SELECT c.first_name AS "Ім'я", c.last_name AS "Фамілія", ROUND(AVG(p.amount), 2) AS "Cередня сума платежів"
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;

/* 13. Кількість фільмів у кожному рейтингу (rating): Напишіть запит, який поверне кількість фільмів для кожного з можливих рейтингів (G, PG, PG-13, R, NC-17). */
SELECT rating AS "Рейтинг фільму", COUNT(*) AS "Кількість фільмів"
FROM film
WHERE rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17')
GROUP BY rating
ORDER BY rating;

/* 14. Середня сума платежів по кожному магазину (store): Напишіть запит, який виведе середню суму платежів, здійснених у кожному магазині. */
SELECT s.store_id "Номер магазну", ROUND(AVG(p.amount), 2) AS "Середня сума платежів"
FROM store s
JOIN customer c ON s.store_id = c.store_id
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY s.store_id
ORDER BY s.store_id;