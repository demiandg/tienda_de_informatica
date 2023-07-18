/*
En los bloques de comentarios abajo de los triggers dejo instrucciones para probar los mismos
*/

-- TRIGGER 1 si un empleado cambia de area, llevaremos un historial de puestos anteriores en mov empleados.

USE informatica_dsd;

CREATE TABLE IF NOT EXISTS mov_empleados (
id TINYINT NOT NULL AUTO_INCREMENT,
id_empleado INT NOT NULL,
id_area_anterior TINYINT NOT NULL,
fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id));


CREATE TRIGGER cambios_de_area
BEFORE UPDATE
ON empleados
FOR EACH ROW
INSERT INTO mov_empleados (id_empleado, id_area_anterior)
VALUES (OLD.id, OLD.area_emp);


/* UPDATE empleados
SET area_emp = 3
WHERE id = 2;

UPDATE empleados 
SET 
    area_emp = 2
WHERE
    id = 5; */


CREATE OR REPLACE VIEW mov_internos AS (SELECT  
concat(nombre," ", apellido) AS name,
sector AS puesto_anterior,
fecha AS hasta
FROM empleados e INNER JOIN  mov_empleados me
ON (me.id_empleado = e.id)
INNER JOIN area_empleado a
ON (me.id_area_anterior = a.id));

/*
SELECT concat(nombre, " ", apellido),
sector
FROM empleados e INNER JOIN area_empleado ae
ON (e.area_emp = ae.id)
WHERE e.id = 2 OR e.id = 5;


SELECT * FROM informatica_dsd.mov_internos;

*/

-- TRIGGER 2 Al vender un producto este trigger descontara la cantidad en la campo de cantidad, en la tabla productos.

CREATE 
    TRIGGER  control_stock
 BEFORE INSERT ON ventas_productos FOR EACH ROW 
    UPDATE productos SET stock = productos.stock - new.cantidad WHERE
        (new.id_producto = productos.id);

/*
 SELECT *
 FROM productos;

 INSERT INTO ventas_productos (id_factura,id_producto,cantidad)
 VALUES (35, 1 , 20);

 SELECT *
 FROM productos;
*/

-- TRIGGER 3 en caso de aplicar un delete en un registro de la tabla ventas_productos se hara un respaldo en la tabla ventas_productos_respaldo.

CREATE TABLE IF NOT EXISTS ventas_productos_respaldo (
    id INT NOT NULL AUTO_INCREMENT,
    id_factura INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_ventaprodres_factura FOREIGN KEY (id_factura)
        REFERENCES facturacion (id),
    CONSTRAINT fk_ventaprodres_producto FOREIGN KEY (id_producto)
        REFERENCES productos (id)
);

CREATE 
    TRIGGER  respaldo_ventasproduc
 BEFORE DELETE ON ventas_productos FOR EACH ROW 
    INSERT INTO ventas_productos_respaldo (id_factura , id_producto , cantidad) VALUES (old.id_factura , old.id_producto , old.cantidad);
    
/*
    SELECT *
    FROM ventas_productos;
    
    DELETE FROM ventas_productos
    WHERE id = 3;

  SELECT *
    FROM ventas_productos;

	SELECT *
	FROM
	ventas_productos_respaldo;
	*/


-- TRIGGER 4 Nos permitira llevar un historial de los cambios de precios de nuestros productos.

CREATE TABLE IF NOT EXISTS ante_val_prod (
id INT NOT NULL AUTO_INCREMENT,
id_prod INT NOT NULL,
precio_ant DECIMAL (8,2) NOT NULL,
fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY (id));



CREATE TRIGGER valor_anterior
BEFORE UPDATE
ON productos
FOR EACH ROW
INSERT INTO ante_val_prod (id_prod, precio_ant)
VALUES (OLD.id, OLD.precio_unitario);

/*
SELECT*
FROM productos;

UPDATE productos
SET precio_unitario = 650000
WHERE id = 1;

SELECT*
FROM ante_val_prod;

SELECT*
FROM productos;
*/

