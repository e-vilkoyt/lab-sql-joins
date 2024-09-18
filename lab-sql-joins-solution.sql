-- 1. Lista el número de películas por categoría.
-- Necesitamos la columna film_id de la tabla film_category y la columna name de la tabla category; la columna común es category_id.
SELECT c.name, COUNT(fc.film_id) AS 'número de películas' FROM sakila.category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
GROUP BY c.name;

-- 2. Recupera el ID de la tienda, la ciudad y el país para cada tienda.
-- Necesitamos la columna store_id de la tabla store.
-- Unimos la tabla address con la columna address_id con la tabla store.
-- La columna city proviene de la tabla city, con la columna city_id que se une a la tabla address.
-- La columna country proviene de la tabla country, con la columna country_id que se une a la tabla city.
SELECT s.store_id, cty.city, c.country FROM sakila.store AS s
JOIN sakila.address AS a
ON s.address_id = a.address_id
JOIN sakila.city AS cty
ON a.city_id = cty.city_id
JOIN sakila.country AS c
ON cty.country_id = c.country_id;

-- 3. Calcula el ingreso total generado por cada tienda en dólares.
-- Ingreso = ventas x precio promedio de venta
-- ...rental_id = número de película alquilada y amount = cuánto costó ese alquiler
-- ...ingreso = COUNT(rental_id) x AVG(amount)
-- Necesitamos las columnas rental_id y amount de la tabla payment, y store_id de la tabla staff.
-- Se conectan a través de staff_id.
SELECT s.store_id, ROUND(COUNT(p.rental_id) * AVG(p.amount)) AS 'ingreso' FROM sakila.payment AS p
JOIN staff AS s
ON p.staff_id = s.staff_id
GROUP BY s.store_id;

-- 4. Determina el tiempo promedio de duración de las películas para cada categoría.
-- Necesitamos la columna length de la tabla film y name de la tabla category.
-- También necesitamos la tabla film_category para unir.
SELECT c.name, CEILING(AVG(f.length)) AS 'tiempo promedio de duración' FROM sakila.category AS c
JOIN film_category AS fc
ON c.category_id = fc.category_id
JOIN film AS f
ON fc.film_id = f.film_id
GROUP BY c.name;
