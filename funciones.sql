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



