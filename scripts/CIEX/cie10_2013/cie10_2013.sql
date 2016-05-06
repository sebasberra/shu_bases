DROP TABLE IF EXISTS cie10_2013;

CREATE TABLE cie10_2013(
	cod_cie10	CHAR(4) NOT NULL,
	descripcion	VARCHAR(255) NOT NULL,
	asterisco	CHAR(1) NOT NULL
)ENGINE=MyISAM;

LOAD DATA LOCAL INFILE "CIE10_2013.csv" 
	INTO TABLE cie10_2013
	FIELDS	TERMINATED BY ';'
	LINES TERMINATED BY '\n'
	IGNORE 1 LINES;


DROP TABLE IF EXISTS ciex_4;

CREATE TABLE ciex_4 (
  id_ciex_4 int(10) unsigned NOT NULL AUTO_INCREMENT,
  id_ciex_3 int(10) unsigned NOT NULL,
  cod_3dig char(3) NOT NULL,
  cod_4dig char(1) NOT NULL,
  descripcion varchar(255) NOT NULL,
  desc_red varchar(50) NOT NULL,
  informa_c2 enum('0','1','2') NOT NULL COMMENT '0 = no informa; 1 = informar inmediatamente; 2 = informar semanalmente',
  PRIMARY KEY (id_ciex_4),
  UNIQUE KEY idx_unique_cod_3dig_cod_4dig (cod_3dig,cod_4dig),
  KEY idx_descripcion (descripcion)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO
	ciex_4
SELECT 
	
	/* id_ciex_4 */
	0,
	
	/* id_ciex_3 */
	0,
	
	/* cod_3dig */
	LEFT(cod_cie10,3),
	
	/* cod_4dig */
	RIGHT(cod_cie10,1),
	
	/* descripcion */
	UCASE(descripcion),
	
	/* desc_red */
	LEFT(UCASE(descripcion),50),
	
	/* informa_c2 */
	'0'
	
FROM

	cie10_2013;
	
/* comparacion CIE10 antes y despues 2013 */
SELECT 
	
	cx13.cod_3dig AS '2013 3d',
	cx13.cod_4dig AS '2013 4d',
	c4.descripcion,
	c4.cod_3dig AS 'actual 3d',
	c4.cod_4dig AS 'actual 4d'
	
FROM

	ciex_2013.ciex_4 cx13
	
RIGHT OUTER JOIN

	ciex_0_87a.ciex_4 c4
	
ON

	cx13.cod_3dig = c4.cod_3dig
AND cx13.cod_4dig = c4.cod_4dig

WHERE

	cx13.cod_3dig IS NULL
	
UNION

	SELECT 
	
	cx13.cod_3dig,
	cx13.cod_4dig,
	cx13.descripcion,
	c4.cod_3dig,
	c4.cod_4dig
	
FROM

	ciex_2013.ciex_4 cx13
	
LEFT OUTER JOIN

	ciex_0_87a.ciex_4 c4
	
ON

	cx13.cod_3dig = c4.cod_3dig
AND cx13.cod_4dig = c4.cod_4dig

WHERE

	c4.cod_3dig IS NULL;
