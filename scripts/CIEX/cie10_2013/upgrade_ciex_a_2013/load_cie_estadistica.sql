DROP FUNCTION IF EXISTS hmi2_quitar_acentos;

DELIMITER //
CREATE FUNCTION hmi2_quitar_acentos(str TEXT)
    RETURNS text
    LANGUAGE SQL
    DETERMINISTIC
    NO SQL
    SQL SECURITY INVOKER
    COMMENT 'Reemplaza acentos en string'

BEGIN
	SET str = REPLACE(str,'†','+');
    SET str = REPLACE(str,'Š','S');
    SET str = REPLACE(str,'š','s');
    SET str = REPLACE(str,'Ð','Dj');
    SET str = REPLACE(str,'Ž','Z');
    SET str = REPLACE(str,'ž','z');
    SET str = REPLACE(str,'À','A');
    SET str = REPLACE(str,'Á','A');
    SET str = REPLACE(str,'Â','A');
    SET str = REPLACE(str,'Ã','A');
    SET str = REPLACE(str,'Ä','A');
    SET str = REPLACE(str,'Å','A');
    SET str = REPLACE(str,'Æ','A');
    SET str = REPLACE(str,'Ç','C');
    SET str = REPLACE(str,'È','E');
    SET str = REPLACE(str,'É','E');
    SET str = REPLACE(str,'Ê','E');
    SET str = REPLACE(str,'Ë','E');
    SET str = REPLACE(str,'Ì','I');
    SET str = REPLACE(str,'Í','I');
    SET str = REPLACE(str,'Î','I');
    SET str = REPLACE(str,'Ï','I');
    SET str = REPLACE(str,'Ò','O');
    SET str = REPLACE(str,'Ó','O');
    SET str = REPLACE(str,'Ô','O');
    SET str = REPLACE(str,'Õ','O');
    SET str = REPLACE(str,'Ö','O');
    SET str = REPLACE(str,'Ø','O');
    SET str = REPLACE(str,'Ù','U');
    SET str = REPLACE(str,'Ú','U');
    SET str = REPLACE(str,'Û','U');
    SET str = REPLACE(str,'Ü','U');
    SET str = REPLACE(str,'Ý','Y');
    SET str = REPLACE(str,'Þ','B');
    SET str = REPLACE(str,'ß','Ss');
    SET str = REPLACE(str,'à','a');
    SET str = REPLACE(str,'á','a');
    SET str = REPLACE(str,'â','a');
    SET str = REPLACE(str,'ã','a');
    SET str = REPLACE(str,'ä','a');
    SET str = REPLACE(str,'å','a');
    SET str = REPLACE(str,'æ','a');
    SET str = REPLACE(str,'ç','c');
    SET str = REPLACE(str,'è','e');
    SET str = REPLACE(str,'é','e');
    SET str = REPLACE(str,'ê','e');
    SET str = REPLACE(str,'ë','e');
    SET str = REPLACE(str,'ì','i');
    SET str = REPLACE(str,'í','i');
    SET str = REPLACE(str,'î','i');
    SET str = REPLACE(str,'ï','i');
    SET str = REPLACE(str,'ð','o');
    SET str = REPLACE(str,'ò','o');
    SET str = REPLACE(str,'ó','o');
    SET str = REPLACE(str,'ô','o');
    SET str = REPLACE(str,'õ','o');
    SET str = REPLACE(str,'ö','o');
    SET str = REPLACE(str,'ø','o');
    SET str = REPLACE(str,'ù','u');
    SET str = REPLACE(str,'ú','u');
    SET str = REPLACE(str,'û','u');
    SET str = REPLACE(str,'ý','y');
    SET str = REPLACE(str,'ý','y');
    SET str = REPLACE(str,'þ','b');
    SET str = REPLACE(str,'ÿ','y');
    SET str = REPLACE(str,'ƒ','f');
    
    RETURN str;
END
//
DELIMITER ;

DROP FUNCTION IF EXISTS hmi2_quitar_espacios;

DELIMITER //
CREATE FUNCTION hmi2_quitar_espacios(str TEXT)
    RETURNS text
    LANGUAGE SQL
    DETERMINISTIC
    NO SQL
    SQL SECURITY INVOKER
    COMMENT 'Reemplaza acentos en string'

BEGIN

	SET str = REPLACE(str,'  ,',',');
	SET str = REPLACE(str,' ,',',');
	SET str = REPLACE(str,'    ',' ');
    SET str = REPLACE(str,'   ',' ');
	SET str = REPLACE(str,'  ',' ');
	
    RETURN str;
END

//
DELIMITER ;

/* levanta cie 2013 (codigos 3 digitos) del excel exportado a csv */	
DROP TABLE IF EXISTS ciex_3_2013;

CREATE TABLE ciex_3_2013(
	cod_3dig	CHAR(3) NOT NULL,
	descripcion	VARCHAR(255) NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE "cie_estadistica_cat.csv" 
	INTO TABLE ciex_3_2013
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';

UPDATE

	ciex_3_2013
	
SET

	descripcion = TRIM(UCASE(hmi2_quitar_acentos(hmi2_quitar_espacios(descripcion))));


/* levanta cie 2013 (codigos 4 digitos) del excel exportado a csv */	
DROP TEMPORARY TABLE IF EXISTS ciex_4_2013_aux;

CREATE TEMPORARY TABLE ciex_4_2013_aux(
	codigo		CHAR(4) NOT NULL,
	descripcion	VARCHAR(255) NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE "cie_estadistica_subcat.csv" 
	INTO TABLE ciex_4_2013_aux
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n';
		
DROP TABLE IF EXISTS ciex_4_2013;


/* carga la cie 2013 y actualiza la descripcion sacando acentos */
CREATE TABLE ciex_4_2013(
	cod_3dig	CHAR(3) NOT NULL,
	cod_4dig	CHAR(1) NOT NULL,
	descripcion	VARCHAR(255) NOT NULL
)ENGINE=MyISAM;

INSERT INTO

	ciex_4_2013

SELECT

	LEFT(codigo,3),
	RIGHT(codigo,1),
	TRIM(UCASE(hmi2_quitar_acentos(hmi2_quitar_espacios(descripcion))))
	
FROM

	ciex_4_2013_aux;



/* ------------------------------------------ */
/* codigos viejos que no estan en la cie 2013 */
/* ------------------------------------------ */
DROP TABLE IF EXISTS ciex_4_2013_outs;

CREATE TABLE
	
	ciex_4_2013_outs
	
SELECT

	c4.id_ciex_4,
	c4.cod_3dig,
	c4.cod_4dig,
	c4.descripcion
	
FROM

	ciex_4 c4
	
LEFT JOIN

	ciex_4_2013 c4_2013
	
ON

	c4.cod_3dig = c4_2013.cod_3dig
AND	c4.cod_4dig = c4_2013.cod_4dig

WHERE

	c4_2013.cod_3dig IS NULL;


DROP TABLE IF EXISTS ciex_3_2013_outs;

CREATE TABLE
	
	ciex_3_2013_outs
	
SELECT 

	c3.id_ciex_3,
	c3.cod_3dig,
	c3.descripcion
	
FROM

	ciex_3 c3
	
LEFT JOIN

	ciex_3_2013 c3_2013
	
ON

	c3.cod_3dig = c3_2013.cod_3dig

WHERE

	c3_2013.cod_3dig IS NULL;


/* baja codigos viejos 3 digitos */
DROP TABLE IF EXISTS ciex_3_2013_bajas;

CREATE TABLE
	
	ciex_3_2013_bajas

SELECT 

	cr.id_ciex_3,
	cr.cod_3dig,
	(CASE cr.frecuencia
		WHEN '0' THEN 'habilitado'
		WHEN '1' THEN 'poco frecuente'
		WHEN '2' THEN 'no habilitado'
		WHEN '3' THEN 'asterisco'
		WHEN '4' THEN 'daga'
		WHEN '5' THEN 'CE'
		ELSE 'se ignora'
	END) AS frecuencia,
	cr.fecha_vigencia_desde,
	cr.fecha_vigencia_hasta 
	
FROM
 
	ciex_restricciones cr 
	
INNER JOIN 

	ciex_3_2013_outs c3_2013 
	
ON cr.id_ciex_3 = c3_2013.id_ciex_3;


/* checks baja de codigos viejos (4 digitos) */
DROP TABLE IF EXISTS ciex_4_2013_bajas;

CREATE TABLE
	
	ciex_4_2013_bajas
	
SELECT 

	c4.id_ciex_4,
	c4_outs.cod_3dig,
	c4_outs.cod_4dig, 
	(CASE (ciex_get_frecuencia(c4_outs.cod_3dig,c4_outs.cod_4dig,'2017-01-01'))
		WHEN '0' THEN 'habilitado'
		WHEN '1' THEN 'poco frecuente'
		WHEN '2' THEN 'no habilitado'
		WHEN '3' THEN 'asterisco'
		WHEN '4' THEN 'daga'
		WHEN '5' THEN 'CE'
		ELSE 'se ignora'
	END) AS frecuencia,
	'2017-01-01' AS 'fecha_test'
	
FROM 

	ciex_4_2013_outs c4_outs 
	
INNER JOIN 

	ciex_4 c4 
	
ON  c4_outs.cod_4dig = c4.cod_4dig 
AND c4_outs.cod_3dig = c4.cod_3dig

UNION

	SELECT 

	c4.id_ciex_4,
	c4_outs.cod_3dig,
	c4_outs.cod_4dig, 
	(CASE (ciex_get_frecuencia(c4_outs.cod_3dig,c4_outs.cod_4dig,'2016-12-31'))
	WHEN '0' THEN 'habilitado'
	WHEN '1' THEN 'poco frecuente'
	WHEN '2' THEN 'no habilitado'
	WHEN '3' THEN 'asterisco'
	WHEN '4' THEN 'daga'
	WHEN '5' THEN 'CE'
	ELSE 'se ignora'
	END) AS frecuencia,
	'2016-12-31' AS 'fecha_test'
	
FROM 

	ciex_4_2013_outs c4_outs 
	
INNER JOIN 

	ciex_4 c4 
	
ON  c4_outs.cod_4dig = c4.cod_4dig 
AND c4_outs.cod_3dig = c4.cod_3dig;


/* filtro que controla si los todos los codigos 3 digitos de la */
/* cie 2013 estan en la cie actualizada */
DROP TABLE IF EXISTS ciex_3_2013_ins;

CREATE TABLE
	
	ciex_3_2013_ins
	
SELECT 

	c3_2013.cod_3dig,
	c3_2013.descripcion
	
FROM

	ciex_3 c3
	
RIGHT JOIN

	ciex_3_2013 c3_2013
	
ON

	c3.cod_3dig = c3_2013.cod_3dig

WHERE

	c3.cod_3dig IS NULL;
	
	
	
/* filtro que controla si los todos los codigos 4 digitos de la */
/* cie 2013 estan en la cie actualizada */
DROP TABLE IF EXISTS ciex_4_2013_ins;

CREATE TABLE
	
	ciex_4_2013_ins	
	
SELECT 

	c4_2013.cod_3dig,
	c4_2013.cod_4dig,
	c4_2013.descripcion
	
FROM

	ciex_4 c4
	
RIGHT JOIN

	ciex_4_2013 c4_2013
	
ON

	c4.cod_3dig = c4_2013.cod_3dig
AND	c4.cod_4dig = c4_2013.cod_4dig

WHERE

	c4.cod_3dig IS NULL;


/* filtro que controla todas las modificaciones de descripcion de */
/* en los codigos 4 digitos entre la cie 2013 y la actualizada */
DROP TABLE IF EXISTS ciex_4_2013_modif;

CREATE TABLE
	
	ciex_4_2013_modif
	
SELECT

	c4.cod_3dig,
	c4.cod_4dig,
	c4.descripcion AS descripcion_c4,
	c4_2013.descripcion AS descripcion_c4_2013
	
FROM

	ciex_4 c4
	
INNER JOIN

	ciex_4_2013 c4_2013
	
ON (c4.cod_3dig = c4_2013.cod_3dig AND c4.cod_4dig = c4_2013.cod_4dig)

WHERE

	TRIM(c4.descripcion) <> TRIM(c4_2013.descripcion);
	
	
/* filtro que controla todas las modificaciones de descripcion de */
/* en los codigos 3 digitos entre la cie 2013 y la actualizada */
DROP TABLE IF EXISTS ciex_3_2013_modif;

CREATE TABLE
	
	ciex_3_2013_modif
	
SELECT

	c3.cod_3dig,
	c3.descripcion AS descripcion_c3,
	c3_2013.descripcion AS descripcion_c3_2013
	
FROM

	ciex_3 c3
	
INNER JOIN

	ciex_3_2013 c3_2013
	
ON c3.cod_3dig = c3_2013.cod_3dig

WHERE

	TRIM(c3.descripcion) <> TRIM(c3_2013.descripcion);
