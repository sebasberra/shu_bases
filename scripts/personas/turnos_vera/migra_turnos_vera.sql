/* DROP tabla de vuelco de datos */
DROP TABLE IF EXISTS pacientes_turnos_vera;

/* carga los pacientes de vera */
CREATE TABLE IF NOT EXISTS pacientes_turnos_vera(
	DNI					INTEGER					NOT NULL,
	TipoDoc				CHAR(3)					NOT NULL,
	Nombre				VARCHAR(255)			NOT NULL,
	Sexo              	VARCHAR(255)			NULL,
	FechaNac           	DATE					NULL,
	Direccion         	VARCHAR(255)			NULL,
	Ciudad      		VARCHAR(255)			NOT NULL,
	Provincia       	VARCHAR(255)			NULL,
	Telefono           	VARCHAR(255)			NULL,
	Observaciones		VARCHAR(255)			NULL,
	Ocupacion			VARCHAR(255)			NULL,
	LugarNac			VARCHAR(255)			NULL,
	EstadoCivil			VARCHAR(255)			NULL,
	FirmaPatronal		VARCHAR(255)			NULL,	
	Medicacion			VARCHAR(255)			NULL,
	NroAfiliado			VARCHAR(255)			NULL,
	id_localidad		INTEGER					NULL DEFAULT NULL,
	id_prov				INTEGER					NULL DEFAULT NULL,
	marca_borrado		BOOLEAN			NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (DNI,TipoDoc)
)ENGINE=MyISAM;	

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'pacientes_depurados_vera.txt'
	INTO TABLE pacientes_turnos_vera
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n'
	IGNORE 1 LINES;
	
/* pone NULL a vacios */
UPDATE
	pacientes_turnos_vera
SET
	Direccion = NULL
WHERE 
	TRIM(Direccion)='' OR
	TRIM(Direccion)='VERA';

UPDATE
	pacientes_turnos_vera
SET
	Sexo = NULL
WHERE 
	TRIM(Sexo)='';
	
UPDATE
	pacientes_turnos_vera
SET
	Provincia = NULL
WHERE 
	TRIM(Provincia)='';
	
UPDATE
	pacientes_turnos_vera
SET
	Telefono = NULL
WHERE 
	TRIM(Telefono)='';
	
UPDATE
	pacientes_turnos_vera
SET
	Observaciones = NULL
WHERE 
	TRIM(Observaciones)='';
	
UPDATE
	pacientes_turnos_vera
SET
	Ocupacion = NULL
WHERE 
	TRIM(Ocupacion)='';
	
UPDATE
	pacientes_turnos_vera
SET
	LugarNac = NULL
WHERE 
	TRIM(LugarNac)='';
	
UPDATE
	pacientes_turnos_vera
SET
	EstadoCivil = NULL
WHERE 
	TRIM(EstadoCivil)='';
	
UPDATE
	pacientes_turnos_vera
SET
	FirmaPatronal = NULL
WHERE 
	TRIM(FirmaPatronal)='';
	
UPDATE
	pacientes_turnos_vera
SET
	Medicacion = NULL
WHERE 
	TRIM(Medicacion)='';
	
UPDATE
	pacientes_turnos_vera
SET
	NroAfiliado = NULL
WHERE 
	TRIM(NroAfiliado)='';
	
/* pone NULL a fecha de nacimientos que no se corresponden con el nro de documento */
UPDATE
	pacientes_turnos_vera
SET
	FechaNac = NULL
WHERE 
	(FechaNac<'1921-01-01' 
		AND DNI > 20000000 )
OR	FechaNac = '1901-01-01'
OR  FechaNac = '1900-01-01';


/* actualiza tipo doc */
UPDATE
	pacientes_turnos_vera
SET
	TipoDoc = 'DNI'
WHERE 
	TipoDoc='/' 
OR	TRIM(TipoDoc)='';

/* UCASE nombre y direccion */
UPDATE
	pacientes_turnos_vera
SET
	Nombre = UCASE(Nombre);
UPDATE
	pacientes_turnos_vera
SET
	Direccion = UCASE(Direccion);
	
	
UPDATE
	pacientes_turnos_vera
SET
	Nombre = UCASE(Nombre);
	
/* direccion puntual */
UPDATE 
	pacientes_turnos_vera 
SET
	Direccion = 'PJE M. GARCIA 1750'
WHERE DNI=22245975;

/* ciudad puntual */
UPDATE 
	pacientes_turnos_vera 
SET
	Ciudad = 'CORDOBA'
WHERE 
	DNI=13779869;

/* elimina documentos menores a 1.000.000 */
DELETE FROM 
	pacientes_turnos_vera
WHERE
	DNI<1000000;
	
/* elimina campos que no se usan */
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	NroAfiliado;
	
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	Medicacion;
	
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	FirmaPatronal;
	
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	EstadoCivil;
	
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	Observaciones;
	
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	LugarNac;
	
ALTER TABLE
	pacientes_turnos_vera
DROP COLUMN	
	Ocupacion;
	
/* id_localidad */
UPDATE
	pacientes_turnos_vera
SET
	id_localidad = 
		(SELECT 
			l.id_localidad
		FROM
			localidades l
		WHERE
			l.nom_loc = Ciudad
		AND l.id_dpto IS NOT NULL);
			
/* id_prov */
UPDATE
	pacientes_turnos_vera
SET
	id_prov = 
		(SELECT 
			p.id_prov
		FROM
			provincias p
		WHERE
			p.nom_prov = Provincia);
			
UPDATE
	pacientes_turnos_vera ptv
SET
	id_prov = 
		(SELECT
			p.id_prov
		FROM
			provincias p
		INNER JOIN
			departamentos d
		ON
			p.id_prov = d.id_prov
		INNER JOIN
			localidades l
		ON
			l.id_dpto = d.id_dpto
		WHERE
			l.nom_loc = Ciudad)
WHERE
	ptv.id_prov IS NULL;
	
	
/* ------------------------------ */
/* elimina duplicado de documento */
/* ------------------------------ */

/* vista auxiliar para eliminar internaciones para evitar duplicados de historias clinicas */
CREATE OR REPLACE VIEW 
	vera_dni_duplicados
AS
	SELECT 
		ptv1.DNI AS dni,
		ptv1.TipoDoc AS tipodoc,
		ptv1.Nombre AS nombre,
		ptv2.DNI AS dni2,
		ptv2.TipoDoc AS tipodoc2,
		ptv2.Nombre AS nombre2
		
	FROM 
		pacientes_turnos_vera ptv1
	INNER JOIN
		pacientes_turnos_vera ptv2
	ON
		ptv1.DNI = ptv2.DNI
	AND	ptv1.TipoDoc <> ptv2.TipoDoc
	GROUP BY
		ptv1.DNI;
		
DELETE FROM
	pacientes_turnos_vera
USING
	pacientes_turnos_vera
INNER JOIN
	vera_dni_duplicados
WHERE 
	pacientes_turnos_vera.DNI = vera_dni_duplicados.dni  
AND pacientes_turnos_vera.TipoDoc = 'EC';
		

/* Tipo doc */
UPDATE
	pacientes_turnos_vera
SET
	TipoDoc = 'LC'
WHERE
	TipoDoc = 'EC'
AND Sexo = 'F';

/* Tipo doc */
UPDATE
	pacientes_turnos_vera
SET
	TipoDoc = 'LE'
WHERE
	TipoDoc = 'EC'
AND Sexo = 'M';

/* Tipo doc */
UPDATE
	pacientes_turnos_vera
SET
	TipoDoc = 'DNI'
WHERE
	TipoDoc = 'EC'
AND Sexo IS NULL;

DELETE FROM
	pacientes_turnos_vera
USING
	pacientes_turnos_vera
INNER JOIN
	vera_dni_duplicados
WHERE 
	pacientes_turnos_vera.DNI = vera_dni_duplicados.dni  
AND (pacientes_turnos_vera.TipoDoc = 'LE' OR pacientes_turnos_vera.TipoDoc = 'LC');

DROP VIEW IF EXISTS vera_dni_duplicados;

/* ----------------------------------- */
