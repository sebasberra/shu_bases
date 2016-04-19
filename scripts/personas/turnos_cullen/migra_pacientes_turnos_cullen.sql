DROP TABLE IF EXISTS pacientes_turnos_cullen;

CREATE TABLE pacientes_turnos_cullen (
	nomap		VARCHAR(50) NOT NULL,
	tipo		CHAR(3)		NOT NULL,
	documento	INTEGER		NOT NULL,
	sexo		CHAR(1)		NOT NULL,
	fechanac	DATE		NOT NULL,
	domicilio	VARCHAR(50)	NOT NULL,
	barrio		VARCHAR(30)	NOT NULL,
	denom_prov	VARCHAR(20)	NOT NULL,
	calle		VARCHAR(85) NOT NULL,
	PRIMARY KEY (tipo,documento)
)TYPE=MyISAM;

/* carga los datos deL DUMP hecho con la consulta que esta en el archivo vista_pacientes.sql */
LOAD DATA LOCAL INFILE 'd:/sebas/proyectos/hospitales/shu_inicio/scripts/personas/turnos_cullen/vista_pacientes.txt' 
	INTO TABLE pacientes_turnos_cullen
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES;