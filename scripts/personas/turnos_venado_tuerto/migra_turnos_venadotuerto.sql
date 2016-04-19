DROP TABLE IF EXISTS pacientes_turnos_venadotuerto;
DROP TABLE IF EXISTS documentos_turnos_venadotuerto;

/* carga los pacientes de venado tuerto */
CREATE TABLE IF NOT EXISTS pacientes_turnos_venadotuerto(
	Rec_No					INTEGER			NOT NULL,
	Nropaciente             VARCHAR(255)	NOT NULL,
	Razonsocial             VARCHAR(255)	NOT NULL,
	Domicilio               VARCHAR(255)	NOT NULL,
	Codigopostal            INTEGER			NOT NULL,
	Codigoprovincia         TINYINT			NOT NULL,
	Telefonoparticular      VARCHAR(255)	NOT NULL,
	Telefonocomercial       VARCHAR(255)	NOT NULL,
	Celular                 VARCHAR(255)	NOT NULL,
	Email                   VARCHAR(255)	NOT NULL,
	Codigodocumento         TINYINT			NOT NULL,
	Numerodocumento         VARCHAR(255)	NOT NULL,
	Nacionalidad            TINYINT			NOT NULL,
	Fechanacimiento         VARCHAR(255)	NOT NULL,
	Edad                    TINYINT			NOT NULL,
	Sexo                    TINYINT			NOT NULL,
	marca_borrado			BOOLEAN			NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (Rec_No)
)ENGINE=MyISAM;	
	
/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'pacientes.txt'
	INTO TABLE pacientes_turnos_venadotuerto
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n'
	IGNORE 1 LINES;

/* reemplaza las comas en los campos NroPaciente y Numerodocumento */
UPDATE pacientes_turnos_venadotuerto
	SET Nropaciente = REPLACE(Nropaciente,',',''),
		Numerodocumento = REPLACE(Numerodocumento,',','');

ALTER TABLE pacientes_turnos_venadotuerto
	MODIFY COLUMN Nropaciente INTEGER NOT NULL;
	
ALTER TABLE pacientes_turnos_venadotuerto
	MODIFY COLUMN Numerodocumento INTEGER NOT NULL;

	
/* carga los tipos de documentos de venado tuerto */
CREATE TABLE IF NOT EXISTS documentos_turnos_venadotuerto(
	Rec_No				INTEGER				NOT NULL,
	Codigo_Documento	TINYINT				NOT NULL,
	Denominacion		VARCHAR(255)		NOT NULL,
	Abreviatura			VARCHAR(255)		NOT NULL,
PRIMARY KEY (Rec_No),
INDEX codigodocumento (Codigo_Documento)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de documentos */
LOAD DATA LOCAL INFILE 'documentos.txt'
	INTO TABLE documentos_turnos_venadotuerto
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n'
	IGNORE 1 LINES;
	
/* carga las localidades de venado tuerto */
CREATE TABLE IF NOT EXISTS localidades_turnos_venadotuerto(
	Rec_No				INTEGER				NOT NULL,
	Codigopostal		INTEGER				NOT NULL,
	Localidad			VARCHAR(255)		NOT NULL,
	Codigoprovincia		INTEGER				NOT NULL,
	Ddn					VARCHAR(255)		NOT NULL,
PRIMARY KEY (Rec_No),
INDEX codigopostal (Codigopostal)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de documentos */
LOAD DATA LOCAL INFILE 'localidades.txt'
	INTO TABLE localidades_turnos_venadotuerto
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n'
	IGNORE 1 LINES;
	
/* carga las provincias de venado tuerto */
CREATE TABLE IF NOT EXISTS provincias_turnos_venadotuerto(
	Rec_No				INTEGER				NOT NULL,
	Codigo_Provincia	TINYINT				NOT NULL,
	Provincia			VARCHAR(255)		NOT NULL,
PRIMARY KEY (Rec_No),
INDEX codigoprovincia (Codigo_Provincia)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de documentos */
LOAD DATA LOCAL INFILE 'provincias.txt'
	INTO TABLE provincias_turnos_venadotuerto
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n'
	IGNORE 1 LINES;