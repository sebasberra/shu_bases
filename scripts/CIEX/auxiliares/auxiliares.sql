/* drops */
DROP TABLE IF EXISTS catego;
DROP TABLE IF EXISTS ciex3car;
DROP TABLE IF EXISTS tx307;
DROP TABLE IF EXISTS restric;

/* carga la tabla "catego" que tiene las patologias de 4 digitos */
/* NOTA: previamente se le quitaron arreglaron las "Ñ" */
CREATE TABLE catego(
	cod3dig				CHAR(3)				NOT NULL,
	cod4dig				CHAR(1)				NOT NULL,
	descripcion			VARCHAR(255)		NOT NULL
)ENGINE=MyISAM;

LOAD DATA INFILE 'D:/sebas/proyectos/hospitales/shu_inicio/scripts/CIEX/auxiliares/catego.txt' 
	INTO TABLE catego
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
/* carga la tabla "ciex3car" que tiene las patologias de 3 digitos */
CREATE TABLE ciex3car(
	cod3dig				CHAR(3)				NOT NULL,
	descripcion			VARCHAR(255)		NOT NULL
)ENGINE=MyISAM;

LOAD DATA INFILE 'D:/sebas/proyectos/hospitales/shu_inicio/scripts/CIEX/auxiliares/ciex3car.txt' 
	INTO TABLE ciex3car
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
/* carga la tabla tx307 que tiene los capitulos, grupos y subgrupos */
CREATE TABLE tx307(
	capitulo			CHAR(2)				NOT NULL,
	grupo				CHAR(2)				NOT NULL,
	subgrupo			CHAR(2)				NOT NULL,
	cod3dig_desde		CHAR(3)				NOT NULL,
	cod3dig_hasta		CHAR(3)				NOT NULL,
	descripcion			VARCHAR(255)		NOT NULL
)ENGINE=MyISAM;

LOAD DATA INFILE 'D:/sebas/proyectos/hospitales/shu_inicio/scripts/CIEX/auxiliares/tx307.txt' 
	INTO TABLE tx307
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
	
/* carga la tabla restric que tiene las restricciones */
CREATE TABLE restric(
	cod3dig				CHAR(3)				NOT NULL,
	cod4dig				CHAR(3)				NULL,
	sexo				CHAR(1)				NOT NULL COMMENT '0=no tiene restriccion; 1=solo masculino; 2=solo femenino',
	frecuencia			CHAR(1)				NOT NULL COMMENT '0=no tiene restriccion; 1=poco frecuente; 2=no puede aparecer',
	tipoedad_min		CHAR(1)				NOT NULL COMMENT '0=no tiene restriccion; 1=años; 2=meses; 3=dias; 4=horas; 5=100 y+',
	edad_min			CHAR(2)				NOT NULL,
	tipoedad_max		CHAR(1)				NOT NULL COMMENT '1=años; 2=meses; 3=dias; 4=horas; 5=100 y+; 9=no tiene restriccion maxima',
	edad_max			CHAR(2)				NOT NULL,
	restriccion_edad	CHAR(1)				NOT NULL COMMENT '0=no tiene; 1=puede pasar; 2=no puede pasar'
)ENGINE=MyISAM;

LOAD DATA INFILE 'D:/sebas/proyectos/hospitales/shu_inicio/scripts/CIEX/auxiliares/restric.txt' 
	INTO TABLE restric
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\r\n';
	
UPDATE restric SET cod4dig=NULL WHERE cod4dig="";

/* elimina de "catego" los codigos de 4 digitos que referencian un codigo de 3 digitos que no este en 
	la tabla ciexcar 
	NOTA: esto es porque se encontraron datos de patologias de 4 digitos cuyos titulos de 3
	digitos no existe 
*/
/*DELETE FROM catego WHERE cod3dig NOT IN (SELECT ci.cod3dig FROM ciex3car ci);*/

/* elimina de "tx307" (titulos) los codigos de 3 digitos desde y hasta que referencian un codigo de 3 digitos que no 
	este en la tabla ciexcar 
 */
/*DELETE FROM tx307 WHERE cod3dig_desde NOT IN (SELECT ci.cod3dig FROM ciex3car ci);
DELETE FROM tx307 WHERE cod3dig_hasta NOT IN (SELECT ci.cod3dig FROM ciex3car ci);*/
	