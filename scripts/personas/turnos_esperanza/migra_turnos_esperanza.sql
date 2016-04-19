/* migracion turnos esperanza */

/* elimina la tabla */
DROP TABLE IF EXISTS pacientes_turnos_esperanza;

/* carga los pacientes de esperanza */
CREATE TABLE IF NOT EXISTS pacientes_turnos_esperanza(

	tipo				CHAR(3)						NOT NULL,
	nrodoc				INTEGER		UNSIGNED		NOT NULL,
	apeynom				VARCHAR(255)				NOT NULL,
	domicilio			VARCHAR(255)				NULL,
	sexo				CHAR(1)						NOT NULL,
	fenaaa				CHAR(4)						NOT NULL,
	fenamm				CHAR(2)						NOT NULL,
	fenadd				CHAR(2)						NOT NULL,
	codpos				CHAR(4)						NOT NULL,
	ciudad				VARCHAR(255)				NOT NULL,
	provincia			CHAR(1)						NOT NULL,
	cuilti				CHAR(11)					NOT NULL,
	codobr				CHAR(6)						NULL,
	marca				CHAR(1)						NOT NULL,
	peapor				CHAR(4)						NOT NULL,
	nhc					INTEGER		UNSIGNED		NULL,			
	ntel				VARCHAR(255)				NULL,
	id_localidad		INTEGER						NULL,
	marca_borrado		BOOLEAN						NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (tipo,nrodoc)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'pacientes_esperanza.txt'
	INTO TABLE pacientes_turnos_esperanza
	FIELDS	TERMINATED BY '\t'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n';
	
/* carga los id de localidad */
UPDATE
	pacientes_turnos_esperanza pe
SET
	pe.id_localidad = (
					SELECT 
						l.id_localidad 
					FROM 
						localidades l 
					WHERE 
						l.nom_loc = pe.ciudad
					AND id_dpto IS NOT NULL
					LIMIT 0,1);
					
					
/* pone NULL a vacios */
UPDATE
	pacientes_turnos_esperanza
SET
	domicilio = NULL
WHERE 
	TRIM(domicilio) = '';
	
UPDATE
	pacientes_turnos_esperanza
SET
	nhc = NULL
WHERE 
	TRIM(nhc) = '';
	
UPDATE
	pacientes_turnos_esperanza
SET
	codobr = NULL
WHERE 
	TRIM(codobr) = ''
OR codobr='000000';

UPDATE
	pacientes_turnos_esperanza
SET
	codobr = NULL
WHERE 
	es_entero(codobr) = 0;
	
UPDATE
	pacientes_turnos_esperanza
SET
	ntel = NULL
WHERE 
	TRIM(ntel) = '';
	
UPDATE
	pacientes_turnos_esperanza
SET
	nhc = NULL
WHERE 
	TRIM(nhc) = ''
	OR nhc = 0;

	
!!!!!!!!!!!!!!!!!!!!
	
/*DELETE FROM pacientes_turnos_esperanza WHERE apeynom='ROMANO MARIA FLOREN';*/
/*DELETE FROM pacientes_turnos_esperanza WHERE apeynom='ZUBLER YAQUELINA';*/


!!!!!!!!!!!!!!!!!!!


UPDATE
	pacientes_turnos_esperanza
SET
	tipo = (CASE tipo
			WHEN 	'DU'	THEN	'DNI'
			WHEN 	'LE'	THEN	'LE'
			WHEN 	'LE.'	THEN	'LE'
			WHEN 	'L.E'	THEN	'LE'
			WHEN 	'DNI'	THEN	'DNI'
			WHEN 	'LC'	THEN	'LC'
			WHEN 	'LC.'	THEN	'LC'
			WHEN 	'L.C'	THEN	'LC'
			WHEN	'PAS'	THEN	'OTR'
			WHEN	'OTR'	THEN	'OTR'
			WHEN	'CI'	THEN	'CI'
			WHEN	'CED'	THEN	'CI'
			ELSE 'DNI'
			END);
			