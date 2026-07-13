# 🎬 Proyecto Lógica: Consultas de SQL 🚀

## 📝1. Descripción del Proyecto
Este proyecto consiste en el diseño, desarrollo y optimización de un script de base de datos compuesto por 64 consultas SQL sobre el esquema **Shakila** en PostgreSQL. 
El objetivo principal es resolver requerimientos analíticos de negocio —simulando un entorno real de backend de una plataforma de alquiler de películas— aplicando estándares estrictos de normalización, legibilidad y eficiencia en el procesamiento de datos.
A través de este análisis, se resuelven problemas transaccionales como el control de inventario, métricas de rendimiento por categorías de películas, segmentación de clientes y auditoría de tiempos de entrega en alquileres.

## 🏗️2. Estructura del Proyecto
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

## 📈3. Modelado de Datos Subyacente (Análisis Técnico del Backend)
Para dar respuesta a la exigencia de profundidad en la documentación técnica, se detalla a continuación la arquitectura relacional utilizada:

### 📊Diagrama Entidad-Relación (DER)
El *"diagrama_shakila.png"* representa el esquema public analizado y mapeado desde DBeaver.

### 🧠Lógica de Negocio y Decisiones Críticas de Arquitectura

• **Relaciones Muchos a Muchos (N:M):** Las entidades complejas como películas ("film") y actores ("actor") no se pueden unir directamente. Se conectan mediante la tabla intermedia "film_actor" usando claves compuestas (actor_id, film_id), lo que garantiza la integridad referencial del modelo.

• **Control de Devoluciones (Valores NULL):** En la tabla rental, un valor NULL en "return_date" indica que la película sigue alquilada y en posesión del cliente. Esta regla de negocio se aplicó estrictamente en la consulta 53 usando "return_date" IS NULL.  
• **Sintaxis Estándar en PostgreSQL:** Se usaron comillas dobles obligatorias ("tabla", "columna") tanto en elementos nativos como en sus alias. Esto evita conflictos con palabras reservadas del sistema y asegura la portabilidad del código.

## 💰4. Instalación y Requisitos
Para replicar, ejecutar y validar este análisis, se requieren las siguientes herramientas y dependencias:

•	Motor de Base de Datos: PostgreSQL (Versión 8.3.0).

•	Cliente de Gestión Integrado (IDE): DBeaver (26.0.4).

•	Base de Datos de Prueba: BBDD_Proyecto_shakila_sinuser.sql

### Pasos para la Ejecución:
1.	Instala PostgreSQL y DBeaver en tu entorno local.
2.	Descarga e impacta el script oficial de **Shakila** para levantar las tablas y datos de prueba en tu servidor local.
3.	Clona este repositorio e importa el archivo **consultas_proyecto.sql** en DBeaver.
4.	Ejecuta el script completo presionando Alt + X o ejecuta consulta por consulta seleccionando el bloque deseado.
   
## 🎯5. Resultados y Conclusiones
El desarrollo del script permitió extraer hallazgos clave sobre el comportamiento de la plataforma:

•	**Optimización del Espacio Físico (CTEs):** En lugar de generar tablas temporales físicas que saturan el almacenamiento en disco y penalizan la concurrencia en producción, se sugiere aplicar CTEs (Common Table Expressions) mediante la instrucción **WITH ... AS** (Consultas 51 y 52), procesando los subconjuntos complejos directamente en la memoria volátil de la sesión.

•	**Análisis del Rendimiento Analítico:** Se identificó que las consultas de tipo CROSS JOIN (Consulta 44) no aportan valor al negocio debido a que generan un crecimiento exponencial falso e inválido (Producto Cartesiano M x N), concluyendo que toda unión en el backend debe ser dirigida de forma explícita (INNER JOIN / LEFT JOIN) para salvaguardar el rendimiento del servidor.

•	**Métricas de Negocio:** Se aislaron las categorías de mayor consumo (como 'Action' y 'Sci-Fi') y se parametrizaron alertas de mora para clientes específicos (como 'Tammy Sanders') mediante filtros temporales avanzados (INTERVAL).

## 👣6. Próximos Pasos
Si este proyecto continuara expandiéndose en el backend, las fases de desarrollo programadas son:

•	**Indexación Estratégica**: Crear índices B-Tree en las claves foráneas de las tablas intermedias (Por ejemplo: "film_actor", "film_category") para acelerar los tiempos de respuesta en consultas con múltiples JOIN.

•	**Automatización con Triggers(disparadores)**: Programar "bloques de código inteligentes" que se ejecutan automáticamente cuando pasa un evento específico. Por ejemplo: que aumente automáticamente el stock en la tabla "inventory" cada vez que se inserte un registro en "rental".

•	**Migración a Vistas Materializadas**: Convertir las consultas agregadas recurrentes (como el conteo de películas por actor de la consulta 48) en MATERIALIZED VIEW para evitar recálculos en tiempo real.

## 🖋️7. Autores
- Martha Vergara
- https://github.com/martikavg 


