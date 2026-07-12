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

## 3. Modelado de Datos Subyacente (Análisis Técnico del Backend)
Para dar respuesta a la exigencia de profundidad en la documentación técnica, se detalla a continuación la arquitectura relacional utilizada:
### Diagrama Entidad-Relación (DER)
El siguiente diagrama representa el esquema public analizado y mapeado desde DBeaver:
Lógica de Negocio y Decisiones Críticas de Arquitectura
•	Resolución de Relaciones Muchos a Muchos ($N:M$): El modelo maneja entidades complejas que no pueden unirse directamente. Por ejemplo, la relación entre películas (film) y actores (actor) se resuelve mediante la tabla puente o intermedia film_actor con claves primarias compuestas (actor_id, film_id). Omitir estas tablas intermedias destruiría la integridad referencial del backenSemántica de Estados (Control de Devoluciones): En la tabla transaccional rental, la columna "return_date" acepta valores NULL. Técnicamente, esto representa una restricción de lógica de negocio: la película se encuentra actualmente "alquilada y en posesión del cliente" (aplicado de manera estricta con "return_date" IS NULL en la consulta 53).
•	Estandarización de Sintaxis en PostgreSQL: Para blindar el backend ante conflictos con palabras reservadas del sistema y garantizar portabilidad, se implementó el comillado doble obligatorio ("tabla", "columna") tanto en los elementos nativos como en sus alias.
