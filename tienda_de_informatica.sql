CREATE DATABASE informatica_dsd;

USE informatica_dsd;

CREATE TABLE IF NOT EXISTS informatica_dsd.condicion_iva (
id TINYINT NOT NULL AUTO_INCREMENT,
condicion VARCHAR(20) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.clientes (
id INT NOT NULL AUTO_INCREMENT,
id_condicion TINYINT NOT NULL, 
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NULL,
tipo_identificacion VARCHAR(15) NOT NULL, 
cuit_cuil_dni VARCHAR(15) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_cliente_condicion FOREIGN KEY (id_condicion) REFERENCES condicion_iva
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
INDEX nombre (nombre, apellido)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.proveedores (
id INT NOT NULL AUTO_INCREMENT,
id_condicion TINYINT NOT NULL, 
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NULL,
tipo_identificacion VARCHAR(15) NOT NULL, 
cuit_cuil_dni VARCHAR(15) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_proveedores_condicion FOREIGN KEY (id_condicion) REFERENCES condicion_iva
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
INDEX nombre (nombre, apellido)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.empleados (
id INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(30) NOT NULL,
apellido VARCHAR(30) NULL,
tipo_identificacion VARCHAR(15) NOT NULL, 
cuit_cuil_dni VARCHAR(15) NOT NULL,
PRIMARY KEY (id),
INDEX nombre (nombre, apellido)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.provincias (
id TINYINT NOT NULL AUTO_INCREMENT,
provincia VARCHAR(25) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.direcciones (
id INT NOT NULL AUTO_INCREMENT,
id_cliente INT DEFAULT 0,
id_empleado INT DEFAULT 0,
id_proveedor INT DEFAULT 0,
id_provincia TINYINT NOT NULL,
pais VARCHAR(20) DEFAULT 'ARGENTINA',
localidad VARCHAR(30) NOT NULL,
direccion  VARCHAR(30) NOT NULL,
cod_postal VARCHAR(10),
direccion_principal TINYINT DEFAULT 1,
PRIMARY KEY (id), 
CONSTRAINT fk_direccion_cliente FOREIGN KEY (id_cliente) REFERENCES clientes
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_direccion_empleado FOREIGN KEY (id_empleado) REFERENCES empleados
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_direccion_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedores
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_direccion_provincia FOREIGN KEY (id_provincia) REFERENCES provincias
(id) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS informatica_dsd.emails (
id INT NOT NULL AUTO_INCREMENT,
id_cliente INT DEFAULT 0,
id_empleado INT DEFAULT 0,
id_proveedor INT DEFAULT 0,
email VARCHAR(100) NOT NULL UNIQUE,
principal TINYINT DEFAULT 1,
PRIMARY KEY (id), 
CONSTRAINT fk_email_cliente FOREIGN KEY (id_cliente) REFERENCES clientes
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_email_empleado FOREIGN KEY (id_empleado) REFERENCES empleados
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_email_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedores
(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS informatica_dsd.telefonos (
id INT NOT NULL AUTO_INCREMENT,
id_cliente INT DEFAULT 0,
id_empleado INT DEFAULT 0,
id_proveedor INT DEFAULT 0,
telefono VARCHAR(15) NOT NULL,
detalle VARCHAR(20),
principal TINYINT DEFAULT 1,
PRIMARY KEY (id), 
CONSTRAINT fk_telefono_cliente FOREIGN KEY (id_cliente) REFERENCES clientes
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_telefono_empleado FOREIGN KEY (id_empleado) REFERENCES empleados
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_telefono_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedores
(id) ON DELETE RESTRICT ON UPDATE CASCADE);


CREATE TABLE IF NOT EXISTS informatica_dsd.facturacion (
id INT NOT NULL AUTO_INCREMENT,
id_cliente INT NOT NULL,
numbfactura VARCHAR(15)  NOT NULL, 
subtotal DECIMAL(10,2) NOT NULL,
iva DECIMAL(8,2) DEFAULT 0.00,
total DECIMAL(11,2) NOT NULL,
fecha DATE NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_facturacion_cliente FOREIGN KEY (id_cliente) REFERENCES clientes
(id) ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS informatica_dsd.categoria_productos (
id INT NOT NULL AUTO_INCREMENT,
categoria VARCHAR(25) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.servicios (
id INT NOT NULL AUTO_INCREMENT,
tipo_servicio VARCHAR(35) NOT NULL,
costo DECIMAL(7,2) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS informatica_dsd.productos (
id INT NOT NULL AUTO_INCREMENT,
id_proveedor INT NOT NULL,
id_categoria INT NOT NULL,
nombre VARCHAR(45) NOT NULL,
presentacion VARCHAR(45) NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_producto_proveedor FOREIGN KEY (id_proveedor) REFERENCES proveedores
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria_productos
(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS ventas_productos (
id INT NOT NULL AUTO_INCREMENT,
id_factura INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_ventaprod_factura FOREIGN KEY (id_factura) REFERENCES facturacion
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_ventaprod_producto FOREIGN KEY (id_producto) REFERENCES productos
(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS servicio_tecnico (
id INT NOT NULL AUTO_INCREMENT,
id_empleado INT NOT NULL,
id_cliente INT NOT NULL,
detalle VARCHAR(300) NOT NULL,
recepcion DATETIME DEFAULT CURRENT_TIMESTAMP(),
estado VARCHAR(15) DEFAULT 'pendiente',
PRIMARY KEY (id),
CONSTRAINT fk_servtec_empleado FOREIGN KEY (id_empleado) REFERENCES empleados
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_servtec_cliente FOREIGN KEY (id_cliente) REFERENCES clientes
(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS servicios_facturados (
id INT NOT NULL AUTO_INCREMENT,
id_factura INT NOT NULL,
id_servicio_tecnico INT NOT NULL,
id_servicio INT NOT NULL,
cantidad INT NOT NULL,
PRIMARY KEY (id),
CONSTRAINT fk_servfac_factura FOREIGN KEY (id_factura) REFERENCES facturacion
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_servfac_servtec FOREIGN KEY (id_servicio_tecnico) REFERENCES servicio_tecnico
(id) ON DELETE RESTRICT ON UPDATE CASCADE,
CONSTRAINT fk_servfac_servicio FOREIGN KEY (id_servicio) REFERENCES servicios
(id) ON DELETE RESTRICT ON UPDATE CASCADE
);

USE informatica_dsd;

CREATE OR REPLACE VIEW serv_pend AS (
SELECT count(*) AS "trabajos_pendientes"
FROM servicio_tecnico
WHERE estado IS NULL);

CREATE OR REPLACE VIEW cont_empleado AS (
SELECT concat(nombre," ", apellido) AS name,
telefono,
email
FROM empleados e INNER JOIN telefonos t
ON (e.id = t.id_empleado)
INNER JOIN emails m
ON (e.id = m.id_empleado));


CREATE OR REPLACE VIEW prodxcat AS (
SELECT
categoria,
COUNT(id_categoria) as productos
FROM categoria_productos cp INNER JOIN productos np
ON (cp.id = np.id_categoria)
GROUP BY categoria);

CREATE OR REPLACE VIEW cant_vend AS (
SELECT 
id_producto AS producto,
SUM(cantidad) AS cantidades
FROM ventas_productos
GROUP BY id_producto
);

CREATE OR REPLACE VIEW provxprov AS (
SELECT
provincia,
COUNT(id_proveedor)
FROM
provincias p INNER JOIN direcciones d
ON (p.id = d.id_provincia)
WHERE id_proveedor > 0
GROUP BY id_provincia 
ORDER BY id_provincia
);

CREATE VIEW service_facturar AS ( 
SELECT *
FROM servicio_tecnico
WHERE estado like 'finalizado');

DELIMITER $$ 

USE informatica_dsd$$

CREATE FUNCTION final_cuotas (monto decimal (11,2), cuotas INT, interes INT) RETURNS decimal(11,2)
NO SQL
BEGIN
DECLARE imp_cuota decimal(11,2);
SET imp_cuota=(monto*(1+interes/100))/cuotas;
RETURN imp_cuota;
END$$

CREATE FUNCTION recaudacion (desde DATE, hasta DATE) RETURNS decimal(11,2)
NO SQL
BEGIN
DECLARE recau decimal(11,2);
SET recau = (SELECT SUM(total)
FROM facturacion
WHERE fecha > desde AND fecha < hasta);
RETURN recau;
END$$


USE informatica_dsd;

DELIMITER $$
CREATE PROCEDURE `dsd_ordenar` (IN campo CHAR(30), IN ordenamiento CHAR(30))  
BEGIN
	IF campo <> '' AND ordenamiento = 'descendente' THEN
		SET @variable = CONCAT('ORDER BY ', campo, ' DESC');
        ELSE IF campo <> '' THEN
        SET @variable = CONCAT('ORDER BY ', campo);
        ELSE
        SET @variable = '';
        END IF;
	END IF;
		SET @consulta = CONCAT('SELECT * FROM informatica_dsd.clientes', ' ', @variable); 
    
    PREPARE dsd_ordenar FROM @consulta;
    EXECUTE dsd_ordenar;
    DEALLOCATE PREPARE dsd_ordenar;
    
END $$

DELIMITER ;

-- actualizo valor en la tabla servicio_tecnico en el campo estado, con el fin de informar si un trabajo esta finalizado o demorado 

USE informatica_dsd;

DELIMITER $$
CREATE PROCEDURE `actualiza_estado` (IN c_ampo INT, IN ingreso CHAR(20))  
BEGIN
	UPDATE informatica_dsd.servicio_tecnico SET estado = ingreso WHERE id= c_ampo; 
END $$

DELIMITER ;



