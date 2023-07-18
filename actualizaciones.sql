USE informatica_dsd;

ALTER TABLE productos
ADD stock INT;

UPDATE productos
SET precio_unitario = 1050000
WHERE id = 29;

UPDATE productos 
SET 
    stock = 30
WHERE
    ID = 1;
UPDATE productos 
SET 
    stock = 20
WHERE
    ID = 2;
UPDATE productos 
SET 
    stock = 24
WHERE
    ID = 3;
UPDATE productos 
SET 
    stock = 32
WHERE
    ID = 4;
UPDATE productos 
SET 
    stock = 17
WHERE
    ID = 5;
UPDATE productos 
SET 
    stock = 30
WHERE
    ID = 6;
UPDATE productos 
SET 
    stock = 27
WHERE
    ID = 7;
UPDATE productos 
SET 
    stock = 16
WHERE
    ID = 8;
UPDATE productos 
SET 
    stock = 23
WHERE
    ID = 9;
UPDATE productos 
SET 
    stock = 16
WHERE
    ID = 10;
UPDATE productos 
SET 
    stock = 19
WHERE
    ID = 11;
UPDATE productos 
SET 
    stock = 24
WHERE
    ID = 12;
UPDATE productos 
SET 
    stock = 15
WHERE
    ID = 13;
UPDATE productos 
SET 
    stock = 29
WHERE
    ID = 14;
UPDATE productos 
SET 
    stock = 23
WHERE
    ID = 15;
UPDATE productos 
SET 
    stock = 24
WHERE
    ID = 16;
UPDATE productos 
SET 
    stock = 23
WHERE
    ID = 17;
UPDATE productos 
SET 
    stock = 28
WHERE
    ID = 18;
UPDATE productos 
SET 
    stock = 25
WHERE
    ID = 19;
UPDATE productos 
SET 
    stock = 27
WHERE
    ID = 20;
UPDATE productos 
SET 
    stock = 19
WHERE
    ID = 21;
UPDATE productos 
SET 
    stock = 26
WHERE
    ID = 22;
UPDATE productos 
SET 
    stock = 29
WHERE
    ID = 23;
UPDATE productos 
SET 
    stock = 20
WHERE
    ID = 24;
UPDATE productos 
SET 
    stock = 17
WHERE
    ID = 25;
UPDATE productos 
SET 
    stock = 30
WHERE
    ID = 26;
UPDATE productos 
SET 
    stock = 17
WHERE
    ID = 27;
UPDATE productos 
SET 
    stock = 19
WHERE
    ID = 28;
UPDATE productos 
SET 
    stock = 9
WHERE
    ID = 29;
UPDATE productos 
SET 
    stock = 18
WHERE
    ID = 30;
UPDATE productos 
SET 
    stock = 31
WHERE
    ID = 31;
UPDATE productos 
SET 
    stock = 29
WHERE
    ID = 32;
UPDATE productos 
SET 
    stock = 34
WHERE
    ID = 33;
UPDATE productos 
SET 
    stock = 18
WHERE
    ID = 34;
UPDATE productos 
SET 
    stock = 35
WHERE
    ID = 35;
UPDATE productos 
SET 
    stock = 34
WHERE
    ID = 36;
UPDATE productos 
SET 
    stock = 32
WHERE
    ID = 37;
UPDATE productos 
SET 
    stock = 27
WHERE
    ID = 38;
UPDATE productos 
SET 
    stock = 35
WHERE
    ID = 39;
UPDATE productos 
SET 
    stock = 27
WHERE
    ID = 40;
UPDATE productos 
SET 
    stock = 21
WHERE
    ID = 41;
UPDATE productos 
SET 
    stock = 33
WHERE
    ID = 42;
UPDATE productos 
SET 
    stock = 19
WHERE
    ID = 43;
UPDATE productos 
SET 
    stock = 28
WHERE
    ID = 44;
 
 
set SQL_SAFE_UPDATES=0;

UPDATE clientes SET tipo_identificacion = 1 
WHERE tipo_identificacion = 'CUIT';

UPDATE clientes SET tipo_identificacion = 3 
WHERE tipo_identificacion = 'DNI';

UPDATE proveedores SET tipo_identificacion = 1 
WHERE tipo_identificacion = 'CUIT';

UPDATE empleados SET tipo_identificacion = 3 
WHERE tipo_identificacion = 'DNI';

set SQL_SAFE_UPDATES=1;

ALTER TABLE clientes MODIFY tipo_identificacion tinyint;

ALTER TABLE proveedores MODIFY tipo_identificacion tinyint;

ALTER TABLE empleados MODIFY tipo_identificacion tinyint;

CREATE TABLE IF NOT EXISTS tipos_identificacion (
id TINYINT NOT NULL AUTO_INCREMENT,
t_identificacion VARCHAR (20),
PRIMARY KEY (id));

INSERT INTO tipos_identificacion (id, t_identificacion) 
VALUES 
(1,'cuit'),
(2,'cuil'),
(3,'dni'),
(4,'no especificado');

ALTER TABLE clientes 
ADD CONSTRAINT fk_tipo_iden FOREIGN KEY (tipo_identificacion) REFERENCES tipos_identificacion(id);

ALTER TABLE proveedores 
ADD CONSTRAINT fk_tipo_idenp FOREIGN KEY (tipo_identificacion) REFERENCES tipos_identificacion(id);

ALTER TABLE empleados
ADD CONSTRAINT fk_tipo_idene FOREIGN KEY (tipo_identificacion) REFERENCES tipos_identificacion(id);

CREATE TABLE IF NOT EXISTS area_empleado (
id TINYINT NOT NULL AUTO_INCREMENT,
sector VARCHAR(25) NOT NULL,
PRIMARY KEY (id)); 

INSERT INTO area_empleado (id, sector)
VALUES (1,'venta'),
(2,'atencion clientes'),
(3,'caja'),
(4,'servicio tecnico'),
(5,'deposito'),
(6,'gerencia'),
(7,'compras');


ALTER TABLE empleados 
ADD area_emp TINYINT;

UPDATE empleados SET area_emp = 7 WHERE id = 1;
UPDATE empleados SET area_emp = 2 WHERE id = 2;
UPDATE empleados SET area_emp = 2 WHERE id = 3;
UPDATE empleados SET area_emp = 4 WHERE id = 4;
UPDATE empleados SET area_emp = 3 WHERE id = 5;
UPDATE empleados SET area_emp = 2 WHERE id = 6;
UPDATE empleados SET area_emp = 3 WHERE id = 7;
UPDATE empleados SET area_emp = 3 WHERE id = 8;
UPDATE empleados SET area_emp = 6 WHERE id = 9;
UPDATE empleados SET area_emp = 2 WHERE id = 10;
UPDATE empleados SET area_emp = 5 WHERE id = 11;
UPDATE empleados SET area_emp = 7 WHERE id = 12;
UPDATE empleados SET area_emp = 7 WHERE id = 13;
UPDATE empleados SET area_emp = 4 WHERE id = 14;
UPDATE empleados SET area_emp = 4 WHERE id = 15;

ALTER TABLE empleados 
ADD CONSTRAINT fk_areaemp FOREIGN KEY (area_emp) REFERENCES area_empleado(id);




