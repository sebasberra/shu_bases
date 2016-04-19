/* DROP tabla de vuelco de datos */
DROP TABLE IF EXISTS pacientes_turnos_canada_gomez;

/* carga los pacientes de cañada de gomez */
CREATE TABLE IF NOT EXISTS pacientes_turnos_canada_gomez(
	documento           INTEGER			UNSIGNED	NOT NULL,
	tipo				CHAR(2)						NOT NULL,
	nombre              CHAR(30)					NOT NULL,
	sexo	            CHAR(1)						NULL,
	num_histo			INTEGER			UNSIGNED 	NOT NULL,
	color				CHAR(1)						NOT NULL,
	direccion			VARCHAR(255)				NULL,
	cod_postal			CHAR(4)						NOT NULL,
	localidad			VARCHAR(255)				NOT NULL,
	provincia			VARCHAR(255)				NULL,
	telefono			CHAR(15)					NULL,
	f_nac				CHAR(10)					NULL,
	codigo				CHAR(6)						NOT NULL,
	obs					VARCHAR(255)				NOT NULL,
	marca_borrado		BOOLEAN						NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (documento,tipo)
)ENGINE=MyISAM;	

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'hc_hsj.txt'
	INTO TABLE pacientes_turnos_canada_gomez
	CHARACTER SET 'latin1'
	FIELDS	TERMINATED BY '\t'
			ENCLOSED BY '#'
	LINES	TERMINATED BY '\r\n';
	

/* actualiza el nro de hc "-28927" por "28927" */
UPDATE 
	pacientes_turnos_canada_gomez
SET
	num_histo =	28927
WHERE
	num_histo = 0;

/* pone null a las fechas de nacimiento vacias */
UPDATE
	pacientes_turnos_canada_gomez
SET
	f_nac = NULL
WHERE
	TRIM(f_nac)		='/  /'
OR	TRIM(f_nac)		='';

/* formatea la fecha de nacimiento a formato yyyy-mm-aa */
UPDATE
	pacientes_turnos_canada_gomez
SET
	f_nac = CONCAT( RIGHT(f_nac,4),'-',
						LEFT(f_nac,2),'-',
						LEFT( RIGHT(f_nac,7),2 )
						 );
						 
/* pone a NULL fechas no validas */						 
UPDATE
	pacientes_turnos_canada_gomez
SET
	f_nac = NULL
WHERE
	es_fecha(f_nac) = FALSE ;
	
/* valida fecha */
UPDATE
	pacientes_turnos_canada_gomez
SET
	f_nac = valida_fecha(f_nac);
	
/* quita espacios a direccion */						 
UPDATE
	pacientes_turnos_canada_gomez
SET
	direccion = TRIM(direccion);

/* pone a NULL direcciones vacias */						 
UPDATE
	pacientes_turnos_canada_gomez
SET
	direccion = NULL
WHERE
	direccion = '' ;
	
/* pone a NULL los sexos vacios */						 
UPDATE
	pacientes_turnos_canada_gomez
SET
	sexo = NULL
WHERE
	TRIM(sexo) = '' ;
	
	
/* pone null telefono y provincia vacias */
UPDATE
	pacientes_turnos_canada_gomez
SET
	provincia = TRIM(provincia);
UPDATE
	pacientes_turnos_canada_gomez
SET
	provincia = NULL
WHERE
	provincia='';
UPDATE
	pacientes_turnos_canada_gomez
SET
	telefono = NULL
WHERE
	TRIM(telefono)='';	 

/* elimina 2 pacientes que tienen documento = 5 */
DELETE FROM
	pacientes_turnos_canada_gomez
WHERE
	documento = 5;

/* actualiza los nros de documentos */
UPDATE
	pacientes_turnos_canada_gomez
SET
	tipo = 'DU'
WHERE
	tipo <> 'DU'
AND	tipo <> 'CI'
AND	tipo <> 'LC'
AND	tipo <> 'LE';

/* se elimina registro de prueba */
DELETE FROM 
	pacientes_turnos_canada_gomez 
WHERE 
	documento=18053511;
	
/* actualiza datos de provincia */
UPDATE 
	pacientes_turnos_canada_gomez
SET
	provincia = 'BUENOS AIRES'
WHERE
	provincia = 'BS AS'
OR	provincia = 'BS.AS';

UPDATE 
	pacientes_turnos_canada_gomez
SET
	provincia = 'SANTA FE'
WHERE
	provincia = 'STA FE'
OR	provincia = 'ETA FE'
OR	provincia = 'S.FE'
OR	provincia = 'S-FE'
OR	provincia = 'S.F'
OR	provincia = 'S.E'
OR	provincia = 'S,F'
OR	provincia = 'S,FE';

/* actualiza localidades */
UPDATE 
	pacientes_turnos_canada_gomez
SET
	localidad = 'CAÑADA DE GOMEZ'
WHERE
	localidad = 'C.DE GOMEZ'
OR	LEFT(localidad,4) = 'CAÑA'
OR	localidad = 'CAÐADA DE GOMEZ'
OR	localidad = 'CA DE GOMEZ'
OR	localidad = 'C.GOMEZ'
OR	LEFT(localidad,3)='CDA';


/* agrega campo id_localidad y id_prov */
ALTER TABLE
	pacientes_turnos_canada_gomez
ADD COLUMN
	id_localidad	INTEGER		NULL
AFTER
	obs;
	
ALTER TABLE
	pacientes_turnos_canada_gomez
ADD COLUMN
	id_prov	INTEGER		NULL
AFTER
	id_localidad;
	
/* carga los id de localidad */
UPDATE
	pacientes_turnos_canada_gomez pcg
SET
	pcg.id_localidad = 
					(SELECT 
						l.id_localidad
					FROM
						localidades l
					WHERE
						pcg.localidad = l.nom_loc
					AND l.id_dpto IS NOT NULL);

/* carga los id_prov */
UPDATE
	pacientes_turnos_canada_gomez pcg
SET
	pcg.id_prov = 
				(SELECT 
					p.id_prov
				FROM
					provincias p
				WHERE
					pcg.provincia = p.nom_prov);
					
UPDATE
	pacientes_turnos_canada_gomez pcg
SET
	pcg.id_prov = 
				(SELECT 
					p.id_prov
				FROM
					provincias p
				WHERE
					p.id_prov =
						(SELECT
							d.id_prov
						FROM
							departamentos d
						WHERE
							d.id_dpto =
								(SELECT
									l.id_dpto
								FROM
									localidades l
								WHERE
									l.nom_loc = pcg.localidad
								AND	l.id_dpto IS NOT NULL)
						)
				)
WHERE
	pcg.id_prov IS NULL ;
	
/* pacientes con historias clinicas duplicadas */     
CREATE OR REPLACE VIEW 
	historias_repetidas AS
(SELECT 
	num_histo,COUNT(*) AS cant,GROUP_CONCAT( CONCAT(tipo,';',documento,';',nombre) ) AS info
FROM 
	pacientes_turnos_canada_gomez 
GROUP BY 
	num_histo 
HAVING cant>1
);    
			
CREATE OR REPLACE VIEW 
	historias_repetidas_docs AS
(SELECT 
	pcg.num_histo,pcg.tipo,pcg.documento,pcg.nombre
FROM 
	pacientes_turnos_canada_gomez pcg
WHERE 
	num_histo IN 
		(SELECT 
			num_histo 
		FROM 
			historias_repetidas) 
ORDER BY num_histo
);

CREATE OR REPLACE VIEW 
	historias_repetidas_docs_act AS
SELECT 
	num_histo,
	SUBSTRING_INDEX(
		SUBSTRING_INDEX(info,',',1)
			,';',1
			) AS tipo1, 
	SUBSTRING_INDEX(
		SUBSTRING_INDEX(
			SUBSTRING_INDEX(info,',',1)
				,';',2),
			';',-1
			) AS documento1,
	SUBSTRING_INDEX(info,',',1) AS info1,
	
	SUBSTRING_INDEX(info,',',-1) AS info2
FROM
	historias_repetidas;
	
	
/* modifica el tipo de documento DU a DNI */
ALTER TABLE
	pacientes_turnos_canada_gomez
MODIFY COLUMN
	tipo		CHAR(3)			NOT NULL;
UPDATE
	pacientes_turnos_canada_gomez
SET
	tipo = 'DNI'
WHERE
	tipo = 'DU';
	