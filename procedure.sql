-- llamando al procedimiento dsd_ordenar ordenamos una consulta en la tabla clientes

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