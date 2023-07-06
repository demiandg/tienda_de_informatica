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