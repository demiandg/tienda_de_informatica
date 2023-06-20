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
id_cliente INT NOT NULL,
id_empleado INT NOT NULL,
id_proveedor INT NOT NULL,
id_provincia TINYINT NOT NULL,
pais VARCHAR(20) DEFAULT 'ARGENTINA',
localidad VARCHAR(20) NOT NULL,
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
id_cliente INT NOT NULL,
id_empleado INT NOT NULL,
id_proveedor INT NOT NULL,
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
id_cliente INT NOT NULL,
id_empleado INT NOT NULL,
id_proveedor INT NOT NULL,
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
id INT NOT NULL,
id_cliente INT NOT NULL,
numbfactura VARCHAR(15)  NOT NULL, 
subtotal DECIMAL(10,2) NOT NULL,
iva DECIMAL(7,2) DEFAULT 0.00,
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
nombre VARCHAR(40) NOT NULL,
presentacion VARCHAR(25) NOT NULL,
precio_unitario DECIMAL(8,2) NOT NULL,
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
