SHOW DATABASES;

USE mysql;

# Creación del primer usuario

CREATE USER 'usuario1'@'localhost' IDENTIFIED BY 'Mipassword123';

# Asignación de permisos Lectura de datos del primer usuario.

GRANT SELECT ON *.* TO 'usuario1'@'localhost';

# Creación del segundo usuario

CREATE USER 'usuario2'@'localhost' IDENTIFIED BY 'Mipassword456';

# Asignación de permisos Lectura, Inserción y Modificación de datos del segundo usuario.

GRANT SELECT, INSERT, UPDATE ON *.* TO 'usuario2'@'localhost';

SELECT * FROM user; 