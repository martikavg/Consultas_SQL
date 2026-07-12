-- ====================================================
-- PROYECTO: CONSULTAS SQL (SAKILA DATABASE)
-- TECNOLOGÍAS: PostgreSQL + DBeaver
-- ====================================================

-- ======================================================================================
--1. Crea el esquema de la BBDD.
-- Para este paso se ejecutó el script de inicialización de la base de datos "Shakila" en PostgreSQL,
-- creando las tablas correspondientes y cargando los datos de prueba a través de DBeaver.
-- ======================================================================================

-- ======================================================================================
--2. Muestra los nombres de todas las películas con una clasificación por edades de 'R'.
SELECT "title" 
FROM "film"
WHERE "rating" = 'R';
-- ======================================================================================

-- ======================================================================================
--3. Encuentra los nombres de los actores que tengan un "actor_id" entre 30 y 40.
SELECT "first_name" , "last_name" 
FROM "actor" 
WHERE "actor_id" BETWEEN 30 AND 40 ;
-- ======================================================================================

-- ======================================================================================
--4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT "title" 
FROM "film"
WHERE "language_id" = "original_language_id" ;
-- ======================================================================================

-- ======================================================================================
--5. Ordena las películas por duración de forma ascendente.
SELECT "title", "length" 
FROM "film" 
ORDER BY "length" ASC ;
-- ======================================================================================

-- ======================================================================================
--6. Encuentra el nombre y apellido de los actores que tengan 'Allen' en su apellido.
SELECT "first_name", "last_name"
FROM "actor"
WHERE "last_name" ILIKE '%Allen%';
-- ======================================================================================

-- ======================================================================================
--7. Encuentra la cantidad total de películas en cada clasificación de la tabla "film" y muestra la clasificación junto con el recuento.
SELECT "rating" AS "clasificacion", COUNT(*) AS "total_peliculas"
FROM "film"
GROUP BY "rating" ;
-- ======================================================================================

-- ======================================================================================
--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una duración mayor a 3 horas en la tabla film.
SELECT "title" 
FROM "film"
WHERE "rating" = 'PG-13' OR "length" > 180 ;
-- ======================================================================================

-- ======================================================================================
--9. Encuentra la Variabilidad de lo que costaría reemplazar las películas.
SELECT VARIANCE("replacement_cost") AS "varianza_costo_reemplazo"
FROM "film" ;
-- ======================================================================================

-- ======================================================================================
--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT MAX("length") AS "duracion_maxima", MIN("length") AS "duracion_minima"
FROM "film" ;
-- ======================================================================================

-- ======================================================================================
--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT "amount"
FROM "payment" 
ORDER BY "payment_date" DESC 
LIMIT 1 OFFSET 2 ;
-- ======================================================================================

-- ======================================================================================
--12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.
SELECT "title", "rating" 
FROM "film" 
WHERE "rating" NOT IN ('NC-17', 'G');
-- ======================================================================================

-- ======================================================================================
--13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT "rating", ROUND(AVG("length"), 2) AS "promedio_duracion"
FROM "film"
GROUP BY "rating" ;
-- ======================================================================================

-- ======================================================================================
--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT "title" 
FROM "film"
WHERE "length" > 180 ;
-- ======================================================================================

-- ======================================================================================
--15. ¿Cuánto dinero ha generado en total la empresa?
SELECT SUM("amount") AS "total_generado"
FROM "payment" ;
-- ======================================================================================

-- ======================================================================================
--16. Muestra los 10 clientes con mayor valor de id.
SELECT * 
FROM "customer"
ORDER BY "customer_id" DESC 
LIMIT 10 ;
-- ======================================================================================

-- ======================================================================================
-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.
SELECT "a"."first_name", "a"."last_name"
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "b" ON "a"."actor_id" = "b"."actor_id"
INNER JOIN "film" AS "c" ON "b"."film_id" = "c"."film_id"
WHERE "c"."title" = 'EGG IGBY';
-- ======================================================================================

-- ======================================================================================
-- 18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT "title" 
FROM "film" ;
-- ======================================================================================

-- ======================================================================================
--19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film”.
SELECT "a"."title"
FROM "film" AS "a"
INNER JOIN "film_category" AS "b" ON "a"."film_id" = "b"."film_id"
INNER JOIN "category" AS "c" ON "b"."category_id" = "c"."category_id"
WHERE "c"."name" = 'Comedy' AND "a"."length" > 180 ;
-- ======================================================================================

-- ======================================================================================
-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT "c".name AS categoria, ROUND(AVG("a"."length"),2) AS "promedio_duracion"
FROM "category" AS "c"
INNER JOIN "film_category" AS "b" ON "c"."category_id" = "b"."category_id"
INNER JOIN "film" AS "a" ON "b"."film_id" = "a"."film_id"
GROUP BY "c"."category_id", "c".name
HAVING AVG("a"."length") > 110 ;
-- ======================================================================================

-- ======================================================================================
-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT AVG("rental_duration") AS "media_duracion_alquiler"
FROM "film";
-- ======================================================================================

-- ======================================================================================
-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT CONCAT("first_name", ' ' , "last_name") AS "nombre_y_apellido"
FROM "actor";
-- ======================================================================================

-- ======================================================================================
-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT DATE("rental_date") AS "fecha", COUNT(*) AS "total_alquileres"
FROM "rental"
GROUP BY DATE("rental_date")
ORDER BY "total_alquileres" DESC;
-- ======================================================================================

-- ======================================================================================
-- 24. Encuentra las películas con una duración superior al promedio.
SELECT "title", "length"
FROM "film"
WHERE "length" > (SELECT AVG("length") FROM "film");
-- ======================================================================================

-- ======================================================================================
-- 25. Averigua el número de alquileres registrados por mes.
SELECT TO_CHAR("rental_date", 'YYYY-MM') AS "mes", COUNT(*) AS "total_alquileres"
FROM "rental"
GROUP BY TO_CHAR("rental_date", 'YYYY-MM')
ORDER BY "mes" ASC;
-- ======================================================================================

-- ======================================================================================
-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT 
    ROUND(AVG("amount"), 2) AS "promedio_pago",
    ROUND(STDDEV("amount"), 2) AS "desviacion_estandar_pago",
    ROUND(VARIANCE("amount"), 2) AS "varianza_pago"
FROM "payment";
-- ======================================================================================

-- ======================================================================================
-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT "title", "rental_rate"
FROM "film"
WHERE "rental_rate" > (SELECT AVG("rental_rate") FROM "film");
-- ======================================================================================

-- ======================================================================================
-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT "actor_id", COUNT("film_id") AS "total_peliculas"
FROM "film_actor"
GROUP BY "actor_id"
HAVING COUNT("film_id") > 40
ORDER BY "total_peliculas" DESC ;
-- ======================================================================================

-- ======================================================================================
-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT "f"."title", COUNT("i"."inventory_id") AS "cantidad_disponible"
FROM "film" AS "f"
LEFT JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id"
GROUP BY "f"."film_id", "f"."title"
ORDER BY "cantidad_disponible" DESC;
-- ======================================================================================

-- ======================================================================================
-- 30. Obtener los actores y el número de películas en las que han actuado.
SELECT "a"."actor_id", "a"."first_name", "a"."last_name", COUNT("fa"."film_id") AS "numero_de_peliculas"
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
GROUP BY "a"."actor_id", "a"."first_name", "a"."last_name"
ORDER BY "numero_de_peliculas" DESC;
-- ======================================================================================

-- ======================================================================================
-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT "f"."title", "a"."first_name", "a"."last_name"
FROM "film" AS "f"
LEFT JOIN "film_actor" AS "fa" ON "f"."film_id" = "fa"."film_id"
LEFT JOIN "actor" AS "a" ON "fa"."actor_id" = "a"."actor_id";
-- ======================================================================================

-- ======================================================================================
-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT "a"."first_name", "a"."last_name", "f"."title"
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
LEFT JOIN "film" AS "f" ON "fa"."film_id" = "f"."film_id";
-- ======================================================================================

-- ======================================================================================
-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT "f"."title", "r"."rental_id", "r"."rental_date"
FROM "film" AS "f"
LEFT JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id"
LEFT JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id";
-- ======================================================================================

-- ======================================================================================
-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT "c"."customer_id", "c"."first_name", "c"."last_name", SUM("p"."amount") AS "total_gastado"
FROM "customer" AS "c"
INNER JOIN "payment" AS "p" ON "c"."customer_id" = "p"."customer_id"
GROUP BY "c"."customer_id", "c"."first_name", "c"."last_name"
ORDER BY "total_gastado" DESC
LIMIT 5;
-- ======================================================================================

-- ======================================================================================
-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT "actor_id", "first_name", "last_name"
FROM "actor"
WHERE "first_name" = 'JOHNNY';
-- ======================================================================================

-- ======================================================================================
-- 36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.
SELECT "first_name" AS "Nombre", "last_name" AS "Apellido"
FROM "actor";
-- ======================================================================================

-- ======================================================================================
-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT MIN("actor_id") AS "id_mas_bajo", MAX("actor_id") AS "id_mas_alto"
FROM "actor";
-- ======================================================================================

-- ======================================================================================
-- 38. Cuenta cuántos actores hay en la tabla “actor”.
SELECT COUNT(*) AS "total_actores"
FROM "actor";
-- ======================================================================================

-- ======================================================================================
-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT "actor_id", "first_name", "last_name"
FROM "actor"
ORDER BY "last_name" ASC;
-- ======================================================================================

-- ======================================================================================
-- 40. Selecciona las primeras 5 películas de la tabla “film”.
SELECT "film_id", "title", "description"
FROM "film"
LIMIT 5;
-- ======================================================================================

-- ======================================================================================
-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT "first_name", COUNT(*) AS "cantidad_repetidos"
FROM "actor"
GROUP BY "first_name"
ORDER BY "cantidad_repetidos" DESC;
-- ======================================================================================

-- ======================================================================================
-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT "r"."rental_id", "r"."rental_date", "c"."first_name", "c"."last_name"
FROM "rental" AS "r"
INNER JOIN "customer" AS "c" ON "r"."customer_id" = "c"."customer_id";
-- ======================================================================================

-- ======================================================================================
-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT "c"."customer_id", "c"."first_name", "c"."last_name", "r"."rental_id", "r"."rental_date"
FROM "customer" AS "c"
LEFT JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id";
-- ======================================================================================

-- ======================================================================================
-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT "f"."film_id", "f"."title", "c"."category_id", "c"."name" AS "category_name"
FROM "film" AS "f"
CROSS JOIN "category" AS "c";
-- CONTESTACIÓN: No aporta valor práctico directo para el negocio. Un CROSS JOIN realiza un producto cartesiano,
-- es decir, combina cada una de las películas con cada una de las categorías existentes de forma matemática, 
-- generando combinaciones que no reflejan la realidad. En nuestra BBDD, la verdadera relación lógica entre películas y categorías 
-- se maneja de forma correcta a través de la tabla intermedia "film_category".
-- ======================================================================================

-- ======================================================================================
-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT DISTINCT "a"."actor_id", "a"."first_name", "a"."last_name"
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
INNER JOIN "film_category" AS "fc" ON "fa"."film_id" = "fc"."film_id"
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
WHERE "c"."name" = 'Action'
ORDER BY "a"."last_name" ASC;
-- ======================================================================================

-- ======================================================================================
-- 46. Encuentra todos los actores que no han participado en películas.
SELECT "a"."actor_id", "a"."first_name", "a"."last_name"
FROM "actor" AS "a"
LEFT JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
WHERE "fa"."actor_id" IS NULL;
-- ======================================================================================

-- ======================================================================================
-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT "a"."first_name", "a"."last_name", COUNT("fa"."film_id") AS "cantidad_peliculas"
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
GROUP BY "a"."actor_id", "a"."first_name", "a"."last_name";
-- ======================================================================================

-- ======================================================================================
-- 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores y el número de películas en las que han participado.
WITH "actor_num_peliculas" AS (
    SELECT "a"."first_name", "a"."last_name", COUNT("fa"."film_id") AS "numero_de_peliculas"
    FROM "actor" AS "a"
    INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
    GROUP BY "a"."actor_id", "a"."first_name", "a"."last_name"
)
SELECT * 
FROM "actor_num_peliculas";
-- ======================================================================================

-- ======================================================================================
-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT "customer_id", COUNT(*) AS "total_alquileres"
FROM "rental"
GROUP BY "customer_id";
-- ======================================================================================

-- ======================================================================================
-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT SUM("f"."length") AS "duracion_total"
FROM "film" AS "f"
INNER JOIN "film_category" AS "fc" ON "f"."film_id" = "fc"."film_id"
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
WHERE "c"."name" = 'Action';
-- ======================================================================================

-- ======================================================================================
-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar el total de alquileres por cliente.
WITH "cliente_rentas_temporal" AS (
    SELECT "customer_id", COUNT(*) AS "total_alquileres"
    FROM "rental"
    GROUP BY "customer_id"
)
SELECT * 
FROM "cliente_rentas_temporal";
-- ======================================================================================

-- ======================================================================================
-- 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las películas que han sido alquiladas al menos 10 veces.
WITH "peliculas_alquiladas" AS (
    SELECT "i"."film_id", COUNT("r"."rental_id") AS "veces_alquilada"
    FROM "rental" AS "r"
    INNER JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id"
    GROUP BY "i"."film_id"
    HAVING COUNT("r"."rental_id") >= 10
)
SELECT * 
FROM "peliculas_alquiladas";
-- ======================================================================================

-- ======================================================================================
-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente por título de película.
SELECT "f"."title"
FROM "rental" AS "r"
INNER JOIN "customer" AS "c" ON "r"."customer_id" = "c"."customer_id"
INNER JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id"
INNER JOIN "film" AS "f" ON "i"."film_id" = "f"."film_id"
WHERE "c"."first_name" = 'TAMMY' AND "c"."last_name" = 'SANDERS' AND "r"."return_date" IS NULL
ORDER BY "f"."title" ASC;
-- ======================================================================================

-- ======================================================================================
-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT "a"."first_name", "a"."last_name"
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
INNER JOIN "film_category" AS "fc" ON "fa"."film_id" = "fc"."film_id"
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
WHERE "c"."name" = 'Sci-Fi'
ORDER BY "a"."last_name" ASC;
-- ======================================================================================

-- ======================================================================================
-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. Ordena los resultados alfabéticamente por apellido.
SELECT DISTINCT "a"."first_name", "a"."last_name"
FROM "actor" AS "a"
INNER JOIN "film_actor" AS "fa" ON "a"."actor_id" = "fa"."actor_id"
INNER JOIN "inventory" AS "i" ON "fa"."film_id" = "i"."film_id"
INNER JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
WHERE "r"."rental_date" > (
    SELECT MIN("sub_r"."rental_date")
    FROM "rental" AS "sub_r"
    INNER JOIN "inventory" AS "sub_i" ON "sub_r"."inventory_id" = "sub_i"."inventory_id"
    INNER JOIN "film" AS "sub_f" ON "sub_i"."film_id" = "sub_f"."film_id"
    WHERE "sub_f"."title" = 'SPARTACUS CHEAPER'
)
ORDER BY "a"."last_name" ASC;
-- ======================================================================================

-- ======================================================================================
-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music’.
SELECT "actor_id", "first_name", "last_name"
FROM "actor"
WHERE "actor_id" NOT IN (
    SELECT "fa"."actor_id"
    FROM "film_actor" AS "fa"
    INNER JOIN "film_category" AS "fc" ON "fa"."film_id" = "fc"."film_id"
    INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
    WHERE "c"."name" = 'Music'
    )
ORDER BY "last_name" ASC;
-- ======================================================================================

-- ======================================================================================
-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT DISTINCT "f"."title"
FROM "film" AS "f"
INNER JOIN "inventory" AS "i" ON "f"."film_id" = "i"."film_id"
INNER JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
WHERE ("r"."return_date" - "r"."rental_date") > INTERVAL '8 days';
-- ======================================================================================

-- ======================================================================================
-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.
SELECT "f"."title"
FROM "film" AS "f"
INNER JOIN "film_category" AS "fc" ON "f"."film_id" = "fc"."film_id"
INNER JOIN "category" AS "c" ON "fc"."category_id" = "c"."category_id"
WHERE "c"."name" = 'Animation';
-- ======================================================================================

-- ======================================================================================
-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.
SELECT "title", "length"
FROM "film"
WHERE "length" = (
    SELECT "length"
    FROM "film"
    WHERE "title" = 'DANCING FEVER'
)
ORDER BY "title" ASC;
-- ======================================================================================

-- ======================================================================================
-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. Ordena los resultados alfabéticamente por apellido.
SELECT "c"."first_name", "c"."last_name"
FROM "customer" AS "c"
INNER JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id"
INNER JOIN "inventory" AS "i" ON "r"."inventory_id" = "i"."inventory_id"
GROUP BY "c"."customer_id", "c"."first_name", "c"."last_name"
HAVING COUNT(DISTINCT "i"."film_id") >= 7
ORDER BY "c"."last_name" ASC;
-- ======================================================================================

-- ======================================================================================
-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT "c"."name" AS "categoria_peliculas", COUNT("r"."rental_id") AS "total_alquileres"
FROM "category" AS "c"
INNER JOIN "film_category" AS "fc" ON "c"."category_id" = "fc"."category_id"
INNER JOIN "inventory" AS "i" ON "fc"."film_id" = "i"."film_id"
INNER JOIN "rental" AS "r" ON "i"."inventory_id" = "r"."inventory_id"
GROUP BY "c"."category_id", "c"."name"
ORDER BY "total_alquileres" DESC;
-- ======================================================================================

-- ======================================================================================
-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT "c"."name" AS "categoria", COUNT("fc"."film_id") AS "total_peliculas"
FROM "category" AS "c"
INNER JOIN "film_category" AS "fc" ON "c"."category_id" = "fc"."category_id"
INNER JOIN "film" AS "f" ON "fc"."film_id" = "f"."film_id"
WHERE "f"."release_year" = 2006
GROUP BY "c"."category_id", "c"."name"
ORDER BY "total_peliculas" DESC;
-- ======================================================================================

-- ======================================================================================
-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
-- Nota: El enunciado pide explícitamente "todas las combinaciones posibles", por lo que usamos un CROSS JOIN.
SELECT "s"."staff_id", "s"."first_name", "s"."last_name", "st"."store_id"
FROM "staff" AS "s"
CROSS JOIN "store" AS "st";
-- ======================================================================================

-- ======================================================================================
-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT "c"."customer_id", "c"."first_name", "c"."last_name", COUNT("r"."rental_id") AS "total_alquileres"
FROM "customer" AS "c"
INNER JOIN "rental" AS "r" ON "c"."customer_id" = "r"."customer_id"
GROUP BY "c"."customer_id", "c"."first_name", "c"."last_name"
ORDER BY "total_alquileres" DESC;
-- ======================================================================================








