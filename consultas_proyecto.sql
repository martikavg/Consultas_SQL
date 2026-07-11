-- ====================================================
-- PROYECTO: CONSULTAS SQL (SAKILA DATABASE)
-- TECNOLOGÍAS: PostgreSQL + DBeaver
-- ====================================================


--1. Crea el esquema de la BBDD.
-- Para este paso se ejecutó el script de inicialización de la base de datos "Shakila" en PostgreSQL,
-- creando las tablas correspondientes y cargando los datos de prueba a través de DBeaver.

--2. Muestra los nombres de todas las películas con una clasificación por edades de 'R'.
SELECT "title" 
FROM "film"
WHERE "rating" = 'R';

--3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40.
SELECT "first_name" , "last_name" 
FROM "actor" 
WHERE "actor_id" BETWEEN 30 AND 40 ;

--4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT "title" 
FROM "film"
WHERE "language_id" = "original_language_id" ;

--5. Ordenar las películas por duración de forma ascendente.
SELECT "title", "length" 
FROM "film" 
ORDER BY "length" ASC ;

--6. Nombre y apellido de los actores que tengan 'Allen' en su apellido.
SELECT "first_name", "last_name"
FROM "actor"
WHERE "last_name" ILIKE '%Allen%';

--7. Cantidad total de películas en cada clasificación de la tabla "film".
SELECT "rating" , COUNT(*) AS "total_peliculas"
FROM "film"
GROUP BY "rating" ;

--8. Título de películas 'PG-13' o con duración mayor a 3 horas (180 minutos).
SELECT "title" 
FROM "film"
WHERE "rating" = 'PG-13' OR "length" > 180 ;

--9. Variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE("replacement_cost") AS "varianza_costo_reemplazo"
FROM "film" ;

--10. Mayor y menor duración de una película.
SELECT MAX("length") AS "duracion_maxima", MIN("length") AS "duracion_minima"
FROM "film" ;

--11. Costo del antepenúltimo alquiler ordenado por día
SELECT "amount"
FROM "payment" 
ORDER BY "payment_date" DESC 
LIMIT 1 OFFSET 2 ;

--12. Título de películas que no sean ni 'NC-17' ni 'G'.
SELECT title, rating 
FROM film 
WHERE rating NOT IN ('NC-17', 'G');

--13. Promedio de duración de las películas para cada clasificación.
SELECT "rating", ROUND(AVG("length"), 2) AS "promedio_duracion"
FROM "film"
GROUP BY "rating" ;

--14. Título de películas con duración mayor a 180 minutos.
SELECT "title" 
FROM "film"
WHERE "length" > 180 ;

--