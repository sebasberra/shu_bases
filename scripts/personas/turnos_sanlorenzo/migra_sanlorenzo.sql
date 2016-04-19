DROP TABLE IF EXISTS clinhist_sanlorenzo;

/* NOTA: Las bases fueron exportadas con el FOX para windows (File-> Export...) */

/* code page 1252 */


/* crea la tabla con los datos de pacientes del hospital de reconquista */
CREATE TABLE clinhist_sanlorenzo (
	CLINCOD                 VARCHAR(10)		NOT NULL,
	CLINNOM                 VARCHAR(35)		NOT NULL,
	CLINFCN                 VARCHAR(10)		NULL,
	CLINDOC                 INTEGER			NOT NULL,
	CLINSEX                 CHAR(1)			NOT NULL,
	ECIVCOD                 INTEGER			NOT NULL,
	CLINOCU                 VARCHAR(20)		NULL,
	CLINAFI                 INTEGER			NOT NULL,
	CLINEDA                 VARCHAR(10)		NOT NULL,
	CLINDOM                 VARCHAR(45)		NULL,
	CLINTEL                 VARCHAR(12)		NULL,
	CLINFCC                 VARCHAR(10)		NOT NULL,
	CITYCOD                 INTEGER			NOT NULL,
	OBRCOD                  VARCHAR(6)		NOT NULL,
	CLINESC                 VARCHAR(35)		NULL,
	marca_borrado			BOOLEAN			NOT NULL DEFAULT FALSE,
PRIMARY KEY (CLINCOD)
)ENGINE=MyISAM;

/* carga los datos de los archivos de texto de datos generales de pacientes */
LOAD DATA LOCAL INFILE 'dump_clinhist.txt' 
	INTO TABLE clinhist_sanlorenzo
	FIELDS	TERMINATED BY ';'
			OPTIONALLY ENCLOSED BY '"'
	LINES	TERMINATED BY '\r\n';

	
/* actualiza el formato de fechas al formato aaaa-mm-dd (formato por defecto del mysql) */	
UPDATE clinhist_sanlorenzo
	SET
		CLINFCN = CONCAT(
					/* año */
					SUBSTRING(CLINFCN,LENGTH(SUBSTRING_INDEX(CLINFCN,'/',2))+2,4),'-',
					/* mes */
					LPAD(SUBSTRING_INDEX(CLINFCN,'/',1),2,'0'),'-',
					/* dia */
					LPAD(SUBSTRING(CLINFCN,INSTR(CLINFCN,'/')+1, LENGTH(SUBSTRING_INDEX(CLINFCN,'/',2))-INSTR(CLINFCN,'/') ),2,'0')
					)
	WHERE	CLINFCN IS NOT NULL 
	AND		TRIM(CLINFCN)<>''
	AND		CLINFCN<>"/  /";

UPDATE clinhist_sanlorenzo
	SET
		CLINFCN = NULL
	WHERE	
		TRIM(CLINFCN) = '' 
	OR	CLINFCN="/  /";
	
/* actualiza el formato de fechas al formato aaaa-mm-dd (formato por defecto del mysql) */	
UPDATE clinhist_sanlorenzo
	SET
		CLINFCC = CONCAT(
					/* año */
					SUBSTRING(CLINFCC,LENGTH(SUBSTRING_INDEX(CLINFCC,'/',2))+2,4),'-',
					/* mes */
					LPAD(SUBSTRING_INDEX(CLINFCC,'/',1),2,'0'),'-',
					/* dia */
					LPAD(SUBSTRING(CLINFCC,INSTR(CLINFCC,'/')+1, LENGTH(SUBSTRING_INDEX(CLINFCC,'/',2))-INSTR(CLINFCC,'/') ),2,'0')
					)
	WHERE	CLINFCC IS NOT NULL 
	AND		TRIM(CLINFCC)<>''
	AND		CLINFCC<>"/  /";
	
/* pone NULL a los sexos incompletos */
UPDATE clinhist_sanlorenzo
	SET CLINSEX = 'I'
	WHERE 
		TRIM(CLINSEX) = '';
		
/* pone NULL a los domicilios incompletos */
UPDATE clinhist_sanlorenzo
	SET CLINDOM = NULL
	WHERE 
		TRIM(CLINDOM) = '';
		
/* pone NULL a los telefonos incompletos */
UPDATE clinhist_sanlorenzo
	SET CLINTEL = NULL
	WHERE 
		TRIM(CLINTEL) = '';
		
/* unifica el criterio de clinesc a los que se usan en personas */
UPDATE clinhist_sanlorenzo
	SET
		CLINESC = NULL
	WHERE
		TRIM(CLINESC)='';

UPDATE clinhist_sanlorenzo

	SET CLINESC = 'nunca asistio'
	
	WHERE
		CLINESC LIKE '%ANALFA%'
	OR	CLINESC = 'NADA'
	OR	CLINESC = 'NINGUNA'
	OR	CLINESC LIKE '%NO %'
	OR	CLINESC LIKE '%SIN %'
	OR	CLINESC = 'NO'
	OR	CLINESC LIKE '%NUNCA%';
				
UPDATE clinhist_sanlorenzo

	SET CLINESC = 'PRIMARIO'
	
	WHERE
		CLINESC LIKE '%primari%'
	OR	CLINESC LIKE '%RIMARIO%'
	OR	CLINESC LIKE '%primerio%'
	OR	CLINESC LIKE '%RIMARIA%'
	OR	CLINESC LIKE '%IMARIA%'
	OR	CLINESC LIKE '%IMARIO%'
	OR	CLINESC LIKE '%PEIMARIA%'
	OR	CLINESC LIKE '%PRIAMARI%'
	OR	CLINESC LIKE '%PRIAMRI%'
	OR	CLINESC LIKE '%PRIMAR%'
	OR	CLINESC LIKE '%PRIMAI%'
	OR	CLINESC LIKE '%PRIMAT%'
	OR	CLINESC LIKE '%PRMARI%'
	OR	CLINESC LIKE '%PRIMRI%';
		
UPDATE clinhist_sanlorenzo

	SET CLINESC = 'SECUNDARIO'
	
	WHERE
		CLINESC LIKE '%SECUNDARI%'
	OR	CLINESC LIKE '%SECUN%'
	OR	CLINESC LIKE '%SECUM%'
	OR	CLINESC LIKE '%2ria%';
		
UPDATE clinhist_sanlorenzo

	SET CLINESC = 'TERCIARIO'
	
	WHERE
		CLINESC LIKE '%terciari%'
	OR	CLINESC LIKE '%terceari%'
	OR	CLINESC LIKE '%terceri%'
	OR	CLINESC LIKE '%terciri%'
	OR	CLINESC LIKE '%trercia%';
	
UPDATE clinhist_sanlorenzo

	SET CLINESC = 'UNIVERSITARIO'
	
	WHERE
		CLINESC LIKE '%univer%'
	OR	CLINESC LIKE '%univar%'
	OR	CLINESC LIKE '%unier%'
	OR	CLINESC LIKE '%facultad%';
	
UPDATE clinhist_sanlorenzo

	SET CLINESC = 'POLIMODAL'
	
	WHERE
		CLINESC LIKE '%polimodal%';
		
UPDATE clinhist_sanlorenzo

	SET CLINESC = 'EGB'
	
	WHERE
		CLINESC LIKE '%EGB%';		
		
UPDATE clinhist_sanlorenzo
	
	SET CLINESC = NULL
	
	WHERE
		CLINESC <> 'nunca asistio'
	AND CLINESC <> 'PRIMARIO'
	AND CLINESC <> 'SECUNDARIO'
	AND CLINESC <> 'TERCIARIO'
	AND CLINESC <> 'UNIVERSITARIO'
	AND CLINESC <> 'POLIMODAL'
	AND CLINESC <> 'EGB';
	
/* acomoda las ocupaciones */
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = TRIM(CLINOCU);
		
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = NULL
	
	WHERE
		TRIM(CLINOCU)=''
	OR	CLINOCU LIKE '%+%'
	OR	CLINOCU LIKE '%0%'
	OR	CLINOCU LIKE '%4%'
	OR	CLINOCU LIKE '%.%'
	OR	CLINOCU = 'D';
	
		
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'EMPLEADO'
	
	WHERE
		CLINOCU LIKE '%EMPL%';
		
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'AMA DE CASA'
	
	WHERE
		CLINOCU LIKE '%AMM%'
	OR	CLINOCU LIKE '% CASA%';
	
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'ALBAÑIL'
	
	WHERE
		CLINOCU LIKE '%ÑIL%'
	OR	CLINOCU LIKE '%ALB%';
	
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'AMA DE CASA'
	
	WHERE
		CLINOCU LIKE '%AMM%'
	OR	CLINOCU LIKE '% CASA%'
	OR	CLINOCU LIKE '%AMA DE%';
	
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'ESTUDIANTE'
	
	WHERE
		CLINOCU LIKE '%ESTUD%'
	OR	CLINOCU LIKE '%ESTD%';
	
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'DESOCUPADO/A'
	
	WHERE
		CLINOCU LIKE '%DESOC%';
		
UPDATE clinhist_sanlorenzo
	
	SET
		CLINOCU = 'CHOFER'
	
	WHERE
		CLINOCU LIKE 'CHO%';