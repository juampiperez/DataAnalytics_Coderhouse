-- CONSULTA 1  Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes. Calculá el total como cantidad * precio_unitario. Usá alias descriptivos en español y agrupá por mes con EXTRACT(MONTH FROM fecha_venta).
--  tabla ventas (recordá que tiene id_cliente, id_producto, cantidad, precio_unitario y fecha_venta
SELECT
  EXTRACT(MONTH FROM fecha_venta) AS mes,
  SUM(cantidad * precio_unitario) AS total_facturado,
  COUNT(*) AS cantidad_pedidos,
  AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta);
