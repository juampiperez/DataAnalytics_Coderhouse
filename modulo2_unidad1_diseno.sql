CREATE TABLE clientes(
    id_cliente INT,            -- INT: identificador numérico único, no requiere decimales
    nombre VARCHAR(100),       -- VARCHAR(100): texto de longitud variable, de hasta 100 caracteres
    perfil_bio TEXT,           -- TEXT: texto largo sin límite ya que es para biografía o notas
    fecha_registro DATE        -- DATE: almacena solo fecha, suficiente para registrar el alta del cliente
);

CREATE TABLE productos(
    id_producto INT,           -- INT: identificador numérico único, no requiere decimales
    descripcion VARCHAR(255),  -- VARCHAR(255): texto de longitud variable, 255 caracteres es suficiente para una descripción corta
    precio DECIMAL(10, 2),     -- DECIMAL(10,2): evita errores de redondeo propios de FLOAT, recomendado para valores monetarios
    esta_activo VARCHAR(2)     -- VARCHAR(2): almacena 'SI' o 'NO' para indicar si el producto está disponible para la venta
);
