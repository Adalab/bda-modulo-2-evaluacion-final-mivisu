USE sakila;

-- EJERCICIO 1 : Selecciona todos los nombres de las películas sin que aparezcan duplicados.

SELECT DISTINCT(film.title)  -- uso DISTINCT para eliminar duplicados de la consulta.
FROM film
GROUP BY film.title;         -- GROUP BY para agruparlos

-- EJERCICIO 2 : Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".

SELECT title
	FROM film
    WHERE rating = 'PG-13';
    
 -- SELECT title, rating 'PG-13'  (Compruebo que sea correcto)
 --	-- FROM film
    
-- EJERCICIO 3: . Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción.

SELECT title, description
FROM film 
WHERE description LIKE '%amazing%'; -- uso LIKE para buscar el valor e incluyo el  caracter especial para buscar la palabra.

-- EJERCICIO 4 :Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title
	FROM film
    WHERE length > 120; 
    
-- SELECT title, length  (Compruebo que este correcto y que las peliculas tengan esa duracion mayor.
-- FROM film
-- WHERE title 

-- EJERCICIO 5 : . Recupera los nombres de todos los actores

SELECT first_name, last_name 
	FROM actor;

-- EJERCICIO 6: Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.

SELECT first_name, last_name
	FROM actor 
	WHERE last_name  LIKE '%Gibson%'; -- uso LIKE para buscar el valor e incluyo el  caracter especial para buscar la palabra "Gibson"

-- EJERCICIO 7 : Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.

SELECT first_name, last_name -- Compruebo que esta correcto incluyendo actor_id al select
	FROM actor
	WHERE actor_id BETWEEN 10 AND 20; -- uso BETWEEN para comprobar si el valor esta dentro del rango especifico y AND para que nos diga si ambas condiciones son verdaderas.

-- EJERCICIO 8 : . Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación.

SELECT title        -- Compruebo que esta correcto incluyendo rating al select
	FROM film
    WHERE rating NOT IN ( 'R', 'PG-13'); -- utilizo el NOT IN para que me devuelva las filas de la columna rating que no sea ni R ni PG13.
    
-- EJERCICIO 9 : Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la clasificación junto con el recuento.

SELECT rating, COUNT(*) AS total  -- uso el COUNT(*) para contar todas las filas incluyendo los valores nulos.
FROM film
GROUP BY rating;      -- uso el GROUP BY para agrupar 

-- EJERCICIO 10 : Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y
-- apellido junto con la cantidad de películas alquiladas. 

-- EXPLICACION: En SELECT incluyo todos los campos que voy a necesitar informacion e incluyo un COUNT para contar el numero de alquileres
-- de los clientes, FROM para seleccionar la tabla que quiero,utilizo tambien un LEFT JOIN para unir a la izq con la tabla rental y ON para,
-- poder definir entre las tablas y GROUP BY para poder agruparlas y contar los alquileres. 

SELECT c.customer_id, c.first_name, c.last_name, COUNT(r.rental_id) AS total_rentals
	FROM customer c 
    LEFT JOIN rental r ON c.customer_id = r.rental_id
    GROUP BY c.customer_id, c.first_name, c.last_name;

-- EJERCICIO 11 : Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el
-- recuento de alquileres.

-- Explicacion: En este caso vuelvo a usar el COUNT que me ayuda a contar el total de alquileres,uso 3 JOIN para poder combinar varias
-- tablas que estan relacionadas y los acompaño con un ON para determinar que fila incluyo en el resultado y el GROUP BY para poder agruparlos.

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals 
FROM category c
JOIN film f ON c.category_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.name;

-- EJERCICIO 12 : . Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la
-- clasificación junto con el promedio de duración

-- Explicacion uso SELECT para seleccionar el campo rating de la tabla FILM, uso el AVG(length) para que me calcule el promedio de la duracion,
-- el AS(length) para asignarle un alias,el FROM para indicarle que tabla necesito y el GROUP BY para agrupar el resultado de clasificacion Rating.

SELECT rating, AVG(length) AS length
FROM film
GROUP BY rating;

-- EJERCICIO 13 : . Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".

SELECT a.first_name, a.last_name     -- Compruebo que esta correcto incluyendo title al select
	FROM actor AS a
    JOIN film_actor ON a.actor_id = film_actor.actor_id 
    JOIN film f ON film_actor.film_id = f.film_id
    WHERE f.title = 'Indian Love';     -- uso WHERE para que me filtre el titulo de la pelicula pedida.
    
-- EJERCICIO 14 : . Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.
    
-- EXPLICACION : uso el WHERE para filtra datos y LIKE para buscar una palabra expecifica en este caso Dog y Cat y lo acompaño con OR
-- para verificar que al menos cumpla con una de las condiciones y tambien uso caracteres especiales para incluir la palabra solicitada.

SELECT title,description     -- Compruebo que esta correcto incluyendo description al select
FROM film
WHERE description LIKE '%Dog%' OR description LIKE '%Cat%';   --

--  EJERCICIO 15 : . Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.
 
 -- EXPLICACION: Esta Query me devuelve una tabla vacia,queriendo decir que todos los actores de la tabla film han realizado alguna pelicula.
 
 -- Resultado final
 SELECT a.actor_id, a.first_name, a.last_name       
	FROM actor AS a                              
    LEFT JOIN film_actor ON a.actor_id = film_actor.actor_id
    WHERE film_actor.film_id IS NULL;
    
-- Compruebo y cuento todos los actores que son 200 
SELECT COUNT(*) AS total_actors
FROM actor;

-- Cuento cuantos actores estan relaciones con peliculas en film_actor
SELECT COUNT(*) AS total_film_actors
FROM film_actor;


-- EJERCICIO 16 : . Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.

SELECT title, release_year      -- Compruebo que esta correcto incluyendo release_year (cuando se estreno) al select
	FROM film
    WHERE release_year BETWEEN 2005 AND 2010;  -- uso el BETWEEN para que me de el rango de valores que especifique en este caso los años 2005 al 2010
    
-- EJERCICIO 17 : Encuentra el título de todas las películas que son de la misma categoría que "Family" 

SELECT film. title -- incluyo en el SELECT category.name AS category para que en el resultado salga la columna category y compruebe que es correcto.
FROM film
JOIN film_category ON film.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
WHERE category.name = 'Family';  


 -- EJERCICIO 18 :Muestra el nombre y apellido de los actores que aparecen en más de 10 película.
 
 -- EXPLICACION: Uso el SELECT para seleccionar a los actores,FROM para indicarle de que tabla necesito informacion,JOIN para unir las tablas
 -- el GROUP BY lo estoy utilizando para agrupar el resultado por el id del actor y el HAVING para filtrar y luego incluir los actores de 
 -- mas de 10 peliculas y el COUNT para hacer un conteo de las peliculas asociadas a los actores.
 
SELECT a.first_name, a.last_name
	FROM actor a
	JOIN film_actor film_actor ON a.actor_id = fIlm_actor.actor_id
	GROUP BY a.actor_id, a.first_name, a.last_name
	HAVING COUNT(film_actor.film_id) > 10;
    
    -- SELECT COUNT(*) FROM actor;  Hago comprobacion son 200 actores
    
-- EJERCICIO 19 :Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla film.
    
SELECT title, rating, length  
	FROM film
    WHERE rating = 'R' AND length > 120;
    
-- EJERCICIO 20 :. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el
-- nombre de la categoría junto con el promedio de duración. 

-- EXPLICACION 
SELECT name AS category_name, AVG(length) AS length
FROM category AS c
JOIN film_category ON c.category_id = film_category.category_id
JOIN film AS f ON film_category.film_id = f.film_id
GROUP BY c.name
HAVING AVG(length) >120;

-- EJERCICIO 21 : . Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la
-- cantidad de películas en las que han actuado.
 
 SELECT a.first_name, a.last_name, COUNT(film_actor.film_id) AS total_movies
 	FROM actor AS a
    JOIN film_actor ON a.actor_id = film_actor.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
    HAVING COUNT(film_actor.film_id) >= 5;
    
 
-- EJERCICIO 22 : Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para
-- encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes

SELECT f.title AS peliculas -- DATEDIFF(r.return_date, r.rental_date) AS dias_alquilada  -- REVISAR
FROM film f
WHERE f.film_id IN (
    SELECT i.film_id -- Subconsulta para extraer las peliculas que cumplan la condicion pedidas
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id -- uso JOIN para unir la tabla inventory con rental- 
    WHERE DATEDIFF(r.return_date, r.rental_date) > 5);   -- utilizo el  WHERE Y DATADIFF para filtrar la diferencia del calculo de las dos fechas.
    

-- EJERCICIO 23:  Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror".
-- Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego
-- exclúyelos de la lista de actores.

SELECT a.first_name, a.last_name
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT actor_id      -- Empiezo con la subconsulta 
		FROM film_actor fa
		JOIN film f ON fa.film_id = f.film_id -- primer JOIN obtengo datos de las peliculas
		JOIN film_category fc ON f.film_id = fc.film_id -- segundo JOIN asocio las peliculas junto a sus categorias.
		JOIN category c ON fc.category_id = c.category_id  -- tercer JOIN obtengo de cada pelicula su categoria correpondiente.
		WHERE c.name = 'Horror'); -- filtro el resultado de la categoria HORROR.
    
	
-- ++++++++++++++++++++++++++++++++++++++ BONUS ++++++++++++++++++++++++++++++++++++++++++++++++++

-- EJERCICIO 24: Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la
-- tabla film.

SELECT f.title    -- compruebo que esta correcto incluyendo length en el select
	FROM film f
	JOIN film_category fc ON f.film_id = fc.film_id  -- segundo JOIN asocio las peliculas junto a sus categorias.
	JOIN category c ON fc.category_id = c.category_id -- tercer JOIN obtengo de cada pelicula su categoria correpondiente.
	WHERE c.name = 'Comedy' AND f.length > 180;     -- filtro el resultado en este caso la categoria es comedy y la duracion (lenght)
                                                     -- el AND lo uso porque cumple ambas condiciones y el signo de > mayor para los 180.





    
   


 
 