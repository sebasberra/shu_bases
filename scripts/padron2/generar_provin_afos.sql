/* dump para el afos */
/* provin.txt */

/* drops */
DROP TABLE IF EXISTS afos;


CREATE TABLE afos
(
	id 			BIGINT(11) 	NOT NULL auto_increment,
	codigo			CHAR(6) 	NOT NULL,	/* Código de rnos de la obra social*/
	tipodoc			CHAR(2)		NOT NULL,
	nrodoc			CHAR(8)		NOT NULL,
	apenom			CHAR(25)	NOT NULL,
	fechanac		CHAR(8) 	NOT NULL,
	condicion		CHAR(1)		NOT NULL,
	codipostal		CHAR(4) 	NOT NULL,
	codpro			CHAR(2)		NOT NULL,
	sexo			CHAR(1)		NOT NULL,
	peapor			CHAR(4) 	NOT NULL,
	cuiltit			CHAR(11)	NOT NULL,
    PRIMARY KEY  (id),
	INDEX (nrodoc),
	INDEX (apenom),
	INDEX (codigo)
) TYPE=MyISAM;

/* carga la info en afos */
INSERT INTO afos
	SELECT	0,
			RPAD( 
				(SELECT rnos
				FROM	coberturas_sociales cs
				WHERE	cs.id_cobertura_social = a.id_cobertura_social),
				6,
				' '
			),
			RPAD(a.id_tipo_doc,2,' '),
			LPAD(a.nro_doc,8,' '),
			RPAD(CONCAT(a.apellido,' ',a.nombre),25,' '),
			CONCAT(
				LPAD(DAY(a.fecha_nac),2,' '),
				LPAD(MONTH(a.fecha_nac),2,' '),
				LPAD(YEAR(a.fecha_nac),4,' ')
			),
			IF(a.id_condicion=1,'T','A'),
			RPAD(RIGHT(a.codigo_postal,4),4,' '),
			RPAD(
				(SELECT ps.codprov
				FROM	provincias_superintendencia ps
				WHERE	ps.id_prov = a.id_prov),
				2,
				' '
			),
			a.sexo,
			CONCAT( 
				RPAD(RIGHT(LEFT(a.periodo_aporte,4),2),2,' '),
				RPAD(RIGHT(a.periodo_aporte,2),2,' ')
			),
			RPAD(IF(a.cuil_titular IS NULL,'00000000000',a.cuil_titular),11,' ')
		
		FROM 	afiliados a
		
		WHERE	
				/* Cordoba */
				a.id_prov = 7
				/* Corrientes */ 
		OR		a.id_prov = 8
				/* Entre Rios */ 
		OR		a.id_prov = 9 
				/* Santa Fe */
		OR		a.id_prov = 1 
				/* Santiago del Estero */
		OR		a.id_prov = 22 
				/* Chaco */
		OR		a.id_prov = 5 
				/* Formosa */
		OR		a.id_prov = 10;
		
/* dump */
SELECT	codigo,
		tipodoc,
		nrodoc,
		apenom,
		fechanac,
		condicion,
		codipostal,
		codpro,
		sexo,
		peapor,
		LPAD(cuiltit,11,'0')
	INTO OUTFILE 'provin.txt' 
		FIELDS TERMINATED BY ''  
		LINES TERMINATED BY '\r\n'
	FROM afos;