USE informatica_dsd;

/*
SELECT * 
FROM ventas_productos;
*/

SET autocommit=0;

START TRANSACTION;

USE informatica_dsd;

set SQL_SAFE_UPDATES=0;

DELETE 
FROM ventas_productos
WHERE id_factura>3 AND id_factura<6;

set SQL_SAFE_UPDATES=1;

#ROLLBACK;

#COMMIT;

/*
INSERT INTO productos (id,id_proveedor,id_categoria,nombre,presentacion,precio_unitario,stock)
VALUES
(2,3,12,2),
(3,3,41,1),
(4,4,41,2),
(5,5,2,3);
*/


INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado)
VALUES
(NULL,4,69,'potenti cras in purus eu magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes','2023-05-07','finalizado'),
(NULL,14,184,'in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet','2023-05-09','finalizado'),
(NULL,4,257,'nulla justo aliquam quis turpis eget elit sodales scelerisque mauris sit','2023-05-09','finalizado'),
(NULL,14,186,'etiam pretium iaculis justo in hac habitasse platea dictumst etiam faucibus cursus urna ut','2023-05-11','finalizado');



# SAVEPOINT


INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,15,21,'dapibus duis at velit eu est congue elementum in hac habitasse platea dictumst morbi vestibulum velit id pretium iaculis','2023-06-21',NULL);
INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,15,54,'vel lectus in quam fringilla rhoncus mauris enim leo rhoncus sed vestibulum sit amet cursus id turpis integer aliquet massa','2023-06-21',NULL);
INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,4,67,'nisi at nibh in hac habitasse platea dictumst aliquam augue quam sollicitudin vitae consectetuer','2023-06-21',NULL);
INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,14,231,'purus eu magna vulputate luctus cum sociis natoque penatibus et magnis','2023-06-21',NULL);

SAVEPOINT insert_1;

INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,15,154,'luctus et ultrices posuere cubilia curae nulla dapibus dolor vel','2023-06-21',NULL);
INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,14,12,'nulla sed accumsan felis ut at dolor quis odio consequat varius integer ac leo pellentesque ultrices','2023-06-21',NULL);
INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,4,64,'cubilia curae mauris viverra diam vitae quam suspendisse potenti nullam porttitor lacus at','2023-06-21',NULL);
INSERT INTO servicio_tecnico (id,id_empleado,id_cliente,detalle,recepcion,estado) VALUES (NULL,15,45,'mi in porttitor pede justo eu massa donec dapibus duis','2023-06-21',NULL);

SAVEPOINT insert_2;

#ROLLBACK TO insert_1;


/*
SELECT * 
FROM servicio_tecnico;
*/