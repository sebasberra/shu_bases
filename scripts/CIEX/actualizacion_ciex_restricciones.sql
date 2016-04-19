/* actualizacion de la base de la ciex */


/* drop tabla temporal de migracion (no deberia ser necesario) */
DROP TEMPORARY TABLE IF EXISTS
	ciex_restricciones_tablarestric;


/* crea tabla temporal para hacer migracion */
CREATE TEMPORARY TABLE
	ciex_restricciones_tablarestric
(
	id_ciex_4			INTEGER UNSIGNED NULL COMMENT 'NULL => la restriccion es del codigo de 3 digitos',
	id_ciex_3			INTEGER UNSIGNED NULL COMMENT 'NULL => la restriccion es del codigo de 4 digitos',
	cod_3dig			CHAR(3) NOT NULL,
	cod_4dig			CHAR(1) NULL,
	sexo 				TINYINT(3) UNSIGNED NOT NULL COMMENT '0=no tiene restriccion; 1=solo masculino; 2=solo femenino',
  	frecuencia 			TINYINT(3) UNSIGNED NOT NULL COMMENT '0=no tiene restriccion; 1=poco frecuente; 2=no puede aparecer',
	tipoedad_min 		TINYINT(3) UNSIGNED NOT NULL COMMENT '0=no tiene restriccion; 1=años; 2=meses; 3=dias; 4=horas; 5=minutos',
	edad_min 			TINYINT(3) UNSIGNED NOT NULL,
	tipoedad_max		TINYINT(3) UNSIGNED NOT NULL COMMENT '1=años; 2=meses; 3=dias; 4=horas; 5=minutos; 9=no tiene restriccion maxima',
	edad_max			TINYINT(3) UNSIGNED NOT NULL,
	restriccion_edad 	TINYINT(3) UNSIGNED NOT NULL COMMENT '0=no tiene; 1=puede pasar; 2=no puede pasar',
	
	UNIQUE KEY 
			idx_unique_tmp_cod_3dig_cod_4dig (cod_3dig,cod_4dig),
	UNIQUE KEY 
			idx_fk_tmp_ciex_3_id_ciex_3 (id_ciex_3),
	UNIQUE KEY 
			idx_fk_tmp_ciex_4_id_ciex_4 (id_ciex_4)
		
) ENGINE=InnoDB DEFAULT CHARSET=latin1;




/* carga la tabla temporal de restricciones con la tabla "tablarestric" de "infhospitalizacion" */
INSERT INTO
	ciex_restricciones_tablarestric
	SELECT 
	
		/* id_ciex_4 */
		IF(LENGTH(RESTRIC_CODCAUSA)=3,
			NULL,
			(SELECT 
				id_ciex_4
			FROM
				ciex_4
			WHERE
				cod_3dig=LEFT(RESTRIC_CODCAUSA,3)
			AND cod_4dig=RIGHT(RESTRIC_CODCAUSA,1)
			)
		),
		
		/* id_ciex_3 */
		IF(LENGTH(RESTRIC_CODCAUSA)=4,
			NULL,
			(SELECT 
				id_ciex_3
			FROM
				ciex_3
			WHERE
				cod_3dig=LEFT(RESTRIC_CODCAUSA,3)
			)
		),
		
		/* cod_3dig */
		LEFT(RESTRIC_CODCAUSA,3),
		
		/* cod_4dig */
		IF(LENGTH(RESTRIC_CODCAUSA)=3,
			NULL,
			RIGHT(RESTRIC_CODCAUSA,1)
		),
		
		/* sexo */
		RESTRIC_SEXO,
		
		/* frecuencia */
		RESTRIC_FRECUENCIA,
		
		/* tipoedad_min */
		RESTRIC_TIPOEDADMIN,
		
		/* edad_min */
		RESTRIC_EDADMIN,
		
		/* tipoedad_max */
		RESTRIC_TIPOEDADMAX,
		
		/* edadmax */
		RESTRIC_EDADMAX,
		
		/* frecuencia_edad */
		RESTRIC_FRECDEEDAD
		
	FROM
		tablarestric tr;
	
		
/* agrega o actualiza la tabla ciex_restricciones */	
INSERT INTO

	ciex_restricciones
	
	SELECT
	
		/* id_ciex_restriccion */
		0,
		
		/* id_ciex_4 */
		crt.id_ciex_4,
		
		/* id_ciex_3 */
		crt.id_ciex_3,
		
		/* cod_3dig */
		crt.cod_3dig,
		
		/* cod_4dig */
		crt.cod_4dig,
		
		/* sexo */
		crt.sexo,
		
		/* frecuencia */
		crt.frecuencia,
		
		/* tipoedad_min */
		crt.tipoedad_min,
		
		/* edad_min */
		crt.edad_min,
		
		/* tipoedad_max */
		crt.tipoedad_max,
		
		/* edad_max */
		crt.edad_max,
		
		/* restriccion_edad */
		crt.restriccion_edad,
		
		/* obstetricia */
		0
		
	FROM
	
		ciex_restricciones_tablarestric crt
		
	ON DUPLICATE KEY UPDATE
	
		/* sexo */
		sexo = crt.sexo,
		
		/* frecuencia */
		frecuencia = crt.frecuencia,
		
		/* tipoedad_min */
		tipoedad_min = crt.tipoedad_min,
		
		/* edad_min */
		edad_min = crt.edad_min,
		
		/* tipoedad_max */
		tipoedad_max = crt.tipoedad_max,
		
		/* edad_max */
		edad_max = crt.edad_max,
		
		/* restriccion_edad */
		restriccion_edad = crt.restriccion_edad;
		
	
		
		
		