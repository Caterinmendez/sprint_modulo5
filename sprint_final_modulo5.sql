CREATE DATABASE telovendo_sprint;
USE telovendo_sprint;

CREATE TABLE cliente(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(45) NOT NULL,
    apellido varchar(30) NOT NULL,
    edad varchar(30) NOT NULL,
    correo_electronico varchar(50) NOT NULL,
    numero_accesos INT DEFAULT 1
);

CREATE TABLE operario(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre varchar(45) NOT NULL,
    apellido varchar(30) NOT NULL,
    edad varchar(30) NOT NULL,
    correo_electronico varchar(50) NOT NULL,
    numero_soporte INT DEFAULT 1 
); 

CREATE TABLE registros_soporte(
	id INT AUTO_INCREMENT PRIMARY KEY,
	id_operario INT, 
	id_cliente INT,  
    fecha DATE NOT NULL,
    evaluacion INT, 
    FOREIGN KEY(id_operario) references operario(id),
    FOREIGN KEY(id_cliente) references cliente(id)
); 

INSERT INTO cliente 
VALUES
	(default, "Juan", "Pérez", 25, "juan.perez@gmail.com", 12),
	(default, "Marcia", "Robles", 32, "marcia.r@hotmail.com", 35), 
	(default, "Plinio", "García", 40, "plinio_gar@gmail.com", 54),
	(default, "Anacleto", "López", 28, "anacleto_l@gmail.com", 3),
    (default, "Fleripondia", "Martínez", 37, "fleripond_m@gmail.com", 27);

INSERT INTO operario
VALUES
	(default, "Juanita", "González", 38, "juanita.g@hotmail.com", 12),
    (default, "Francisco", "Hernández", 19, "f.hernandez@hotmail.com", 3),
	(default, "Clementina", "Silva", 25, "clemen_tina.silva@hotmail.com", 8),
	(default, "Gustabo", "Torres", 31, "gus.torres@hotmail.com", 18), 
	(default, "Filomena", "Vargas", 33, "filomena.var@gmail.com", 2);

INSERT INTO registros_soporte
VALUES
	(default, 2, 1,"2022-10-12", 3),
    (default, 2, 5,"2022-01-04", 5),
    (default, 2, 3,"2021-05-14", 4),
    (default, 3, 3,"2021-09-15", 3),
	(default, 1, 5,"2022-11-28", 7),
	(default, 4, 4,"2022-11-06", 1),
	(default, 5, 1,"2021-12-01", 2),
	(default, 5, 3,"2022-06-28", 3),
	(default, 3, 4,"2021-12-29", 6),
	(default, 4, 2,"2023-03-27", 7);
    
#Seleccione las 3 operaciones con mejor evaluación.    
SELECT *
FROM registros_soporte
ORDER BY evaluacion DESC
LIMIT 3;

#Seleccione las 3 operaciones con menos evaluación.    
SELECT *
FROM registros_soporte
ORDER BY evaluacion 
LIMIT 3;

#Seleccione al operario que más soportes ha realizado.
SELECT nombre AS nombre_operario, COUNT(*) AS cantidad_operaciones FROM registros_soporte
JOIN operario ON operario.id = registros_soporte.id_operario
GROUP BY id_operario 
ORDER BY cantidad_operaciones DESC
LIMIT 1; 

#Seleccione al cliente que menos veces ha utilizado la aplicación.
SELECT nombre AS nombre_cliente, COUNT(*) AS cantidad_ingresos FROM registros_soporte
JOIN cliente ON cliente.id = registros_soporte.id_cliente
GROUP BY id_cliente
ORDER BY cantidad_ingresos ASC
LIMIT 1; 

#Agregue 10 años a los tres primeros usuarios registrados.
UPDATE cliente
SET edad = edad + 10
WHERE id = 1 or id = 2 or id = 3; 

#Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email
ALTER TABLE cliente 
RENAME COLUMN correo_electronico TO email;

ALTER TABLE operario 
RENAME COLUMN correo_electronico TO email;

#Seleccione solo los operarios mayores de 20 años.
SELECT * FROM operario
WHERE edad >= 20;
