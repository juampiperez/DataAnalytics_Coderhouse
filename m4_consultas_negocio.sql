-- CONSULTA 1
SELECT
  EXTRACT(MONTH FROM fecha_venta) AS mes,
  SUM(cantidad * precio_unitario) AS total_facturado,
  COUNT(*) AS cantidad_pedidos,
  AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta);

-- CONSULTA 2
SELECT
  id_producto,
  SUM(cantidad) AS unidades_vendidas,
  SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

--CONSULTA 3
SELECT
  id_cliente,
  COUNT(*) AS cantidad_pedidos,
  SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

--CONSULTA 4
SELECT
  EXTRACT(MONTH FROM fecha_venta) AS mes,
  SUM(cantidad * precio_unitario) AS total_facturado,
  COUNT(*) AS cantidad_pedidos,
  AVG(cantidad * precio_unitario) AS ticket_promedio,
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
