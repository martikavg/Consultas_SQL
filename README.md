# 🎬 Proyecto Lógica: Consultas de SQL 🚀

## 1. Descripción del Proyecto
Este proyecto consiste en el diseño, desarrollo y optimización de un script de base de datos compuesto por 64 consultas SQL sobre el esquema **Shakila** en PostgreSQL. 
El objetivo principal es resolver requerimientos analíticos de negocio —simulando un entorno real de backend de una plataforma de alquiler de películas— aplicando estándares estrictos de normalización, legibilidad y eficiencia en el procesamiento de datos.
A través de este análisis, se resuelven problemas transaccionales como el control de inventario, métricas de rendimiento por categorías de películas, segmentación de clientes y auditoría de tiempos de entrega en alquileres.

## 2. Estructura del Proyecto
La organización de los archivos en este repositorio se estructura de la siguiente manera para facilitar la navegación y entender el flujo de trabajo:
```text
proyecto-consultas-SQL/
 ├── db/
 │    └── consultas_proyecto.sql   # Script principal con las 64 consultas SQL estandarizadas
 │
 ├── img/
 │    └── Diagrama_Shakila.png     # Exportación del Diagrama Entidad-Relación (DER)
 │
 └── README.md                     # Descripción técnica del proyecto
```

## 3. Modelado de Datos Subyacente (Análisis Técnico del Backend)
Para dar respuesta a la exigencia de profundidad en la documentación técnica, se detalla a continuación la arquitectura relacional utilizada:

### 📊Diagrama Entidad-Relación (DER)
El "diagrama_shakila.png" representa el esquema public analizado y mapeado desde DBeaver.

### 🧠Lógica de Negocio y Decisiones Críticas de Arquitectura
** • Relaciones Muchos a Muchos ($N:M$):** Las entidades complejas como películas (film) y actores (actor) no se pueden unir directamente. Se conectan mediante la tabla intermedia film_actor usando claves compuestas (actor_id, film_id), lo que garantiza la integridad referencial del modelo.
** • Control de Devoluciones (Valores NULL):** En la tabla rental, un valor NULL en "return_date" indica que la película sigue alquilada y en posesión del cliente. Esta regla de negocio se aplicó estrictamente en la consulta 53 usando "return_date" IS NULL.
** • Sintaxis Estándar en PostgreSQL:** Se usaron comillas dobles obligatorias ("tabla", "columna") tanto en elementos nativos como en sus alias. Esto evita conflictos con palabras reservadas del sistema y asegura la portabilidad del código.


