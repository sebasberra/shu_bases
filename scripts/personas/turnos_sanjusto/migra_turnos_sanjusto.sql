/* DROP tabla de vuelco de datos */
DROP TABLE pacientes_turnos_sanjusto;

/* carga los pacientes de san justo */
CREATE TABLE IF NOT EXISTS pacientes_turnos_sanjusto(
	tipo_doc			CHAR(3)			NOT NULL,
	documento           INTEGER			NOT NULL,
	historia            INTEGER			NOT NULL,
	nombre              CHAR(30)		NOT NULL,
	domicilio           CHAR(30)		NOT NULL,
	mutual         		SMALLINT		NOT NULL,
	categoria      		TINYINT			NOT NULL,
	nom_madre       	CHAR(30)		NOT NULL,
	fecha_nac           VARCHAR(255)	NULL,
	adeuda				TINYINT			NOT NULL,
	marca_borrado		BOOLEAN			NOT NULL 	DEFAULT FALSE,
PRIMARY KEY (tipo_doc,documento)
)ENGINE=MyISAM;	

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'padron.txt'
	INTO TABLE pacientes_turnos_sanjusto
	CHARACTER SET 'cp850'
	FIELDS	TERMINATED BY '\t'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n';
	
/* pone null a las fechas de nacimiento vacias */
UPDATE
	pacientes_turnos_sanjusto
SET
	fecha_nac = NULL
WHERE
	TRIM(fecha_nac)='/  /';
	
/* formatea la fecha de nacimiento a formato yyyy-mm-aa */
UPDATE
	pacientes_turnos_sanjusto
SET
	fecha_nac = CONCAT( RIGHT(fecha_nac,4),'-',
						LEFT(fecha_nac,2),'-',
						LEFT( RIGHT(fecha_nac,7),2 )
						 );
						
/* elimina los pacientes con tipo de documento 9 (HC) */ 
DELETE 
FROM pacientes_turnos_sanjusto
WHERE tipo_doc = '9';                                

/* formatea los tipo de documento a los de personas */
UPDATE
	pacientes_turnos_sanjusto
SET
	tipo_doc = (CASE tipo_doc
					WHEN	'1'	THEN 'DNI'	
					WHEN	'2'	THEN 'LC'  	
					WHEN	'3'	THEN 'LE'  	
					WHEN	'4'	THEN 'DNI'  	
					WHEN	'5'	THEN 'OTR'	
				END);
				
				
/* pacientes con historias clinicas duplicadas */     
CREATE OR REPLACE VIEW 
	historias_repetidas AS
(SELECT 
	historia,COUNT(*) AS cant 
FROM 
	pacientes_turnos_sanjusto 
GROUP BY 
	historia 
HAVING cant>1
);    
			
CREATE OR REPLACE VIEW 
	historias_repetidas_docs AS
(SELECT 
	psj.historia,psj.tipo_doc,psj.documento,psj.nombre
FROM 
	pacientes_turnos_sanjusto psj
WHERE 
	historia IN 
		(SELECT 
			historia 
		FROM 
			historias_repetidas) 
ORDER BY historia
);						