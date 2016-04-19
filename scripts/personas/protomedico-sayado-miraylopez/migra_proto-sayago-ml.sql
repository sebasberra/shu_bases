DROP TABLE IF EXISTS proto_sayago_ml;

CREATE TABLE proto_sayago_ml
(
tipodoc				CHAR(3) 		NULL,
documento			INTEGER 		NULL,
nombre				VARCHAR(255) 	NULL,
domicilio			VARCHAR(255) 	NULL,
localidad			INTEGER		 	NULL,
beneficiario		VARCHAR(255) 	NULL,
parentezco			VARCHAR(255) 	NULL,
sexo				VARCHAR(255) 	NULL,
obrasocial			VARCHAR(255) 	NULL,
carnet				VARCHAR(255) 	NULL,
emitido				VARCHAR(255) 	NULL,
vencimiento			VARCHAR(255) 	NULL,
empresa				VARCHAR(255) 	NULL,
ultrecibo			VARCHAR(255) 	NULL,
historia			VARCHAR(255) 	NULL,
direccion			VARCHAR(255) 	NULL,
fecnac				VARCHAR(255) 	NULL,
cuit				VARCHAR(255) 	NULL
) TYPE=MyISAM;


/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE './protomedico/moPACIENTES.txt' 
	INTO TABLE proto_sayago_ml
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES;

/* Agrega el campo de marca de borrado para eliminar fallecidos */
ALTER TABLE proto_sayago_ml
	ADD COLUMN marca_borrado		BOOLEAN		NOT NULL DEFAULT FALSE;
	
/* Cambia el formato de la fecha y hora para capturarlo y pasarlo a mysql */
UPDATE proto_sayago_ml
	SET
		fecnac = CONCAT(
					/* año */
					SUBSTRING(fecnac,LENGTH(SUBSTRING_INDEX(fecnac,'/',2))+2,4),'-',
					/* mes */
					LPAD(SUBSTRING(fecnac,INSTR(fecnac,'/')+1, LENGTH(SUBSTRING_INDEX(fecnac,'/',2))-INSTR(fecnac,'/') ),2,'0'),'-',
					/* dia */
					LPAD(SUBSTRING_INDEX(fecnac,'/',1),2,'0')
					)
	WHERE	fecnac IS NOT NULL 
	AND		TRIM(fecnac)<>'';
	
UPDATE proto_sayago_ml
	SET
		fecnac = NULL
	WHERE	TRIM(fecnac) = '';
		

/* Modifica el tipo de dato fecha */
ALTER TABLE proto_sayago_ml	
	MODIFY COLUMN		fecnac		DATE 	NULL;

/* Actualiza el tipo de documento */
UPDATE proto_sayago_ml
	SET
		tipodoc =
				(CASE tipodoc
					WHEN 'DU'	THEN 'DNI'
					WHEN ''		THEN 'DNR'
					ELSE tipodoc
				END);
				
				
/* Actualiza errores del Protomedico */				
UPDATE proto_sayago_ml SET sexo = 'Femenino'  WHERE sexo='126205';

UPDATE proto_sayago_ml SET sexo = 'Masculino' WHERE sexo ='(null)' OR sexo='maculino';

DELETE FROM proto_sayago_ml WHERE TRIM(sexo)='Femenin';


/* tabla localidades */
DROP TABLE IF EXISTS proto_sayago_ml_localidades;

CREATE TABLE proto_sayago_ml_localidades
(
	localidad				SMALLINT 		NOT NULL,
	nombre					VARCHAR(255)	NOT NULL,
	cpostal					SMALLINT		NOT NULL,
	provincia				VARCHAR(255)	NOT NULL
)TYPE=MyISAM;

/* carga los datos de los archivos de texto */
LOAD DATA LOCAL INFILE './protomedico/localidades.txt' 
	INTO TABLE proto_sayago_ml_localidades
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES;