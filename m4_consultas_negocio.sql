-- CONSULTA 1: Resumen ejecutivo mensual
SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta);

-- CONSULTA 2: Ranking de productos top 5
SELECT
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

-- CONSULTA 3: Clientes recurrentes
SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- CONSULTA 4: Meses por encima/por debajo del promedio
SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_mes) 
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mes
                FROM ventas
                GROUP BY EXTRACT(MONTH FROM fecha_venta)
            ) subquery
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS performance_mensual
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta);

-- ══════════════════════════════════════════
-- HALLAZGOS
-- ══════════════════════════════════════════
-- 1. El mes de enero concentra la mayor cantidad de pedidos (7 de 10).
-- 2. El producto 1 (Laptop Pro 15) es el de mayor facturación, explicado por su alto precio unitario (1200) y su aparición en múltiples pedidos.
-- 3. Los clientes 1, 4 y 5 son los únicos recurrentes del período, esto indica que la mayoría de los clientes realizó una sola compra.
