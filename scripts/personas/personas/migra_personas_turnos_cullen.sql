/* -------------------------------------------------------------------- */	
/* TURNOS CULLEN - carga los pacientes del sistema de turnos del cullen */
/* -------------------------------------------------------------------- */

/* deshabilita los indices de la tabla personas */
ALTER TABLE personas DISABLE KEYS;

INSERT IGNORE INTO personas
	SELECT 0,
			NULL,
			IF (pc.tipo='','DNR',pc.tipo),
			pc.documento,
			str_separa_ape(pc.nomap,true),
			str_separa_ape(pc.nomap,false),
			pc.sexo,
			pc.domicilio,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			pc.barrio,
			calle,
			NULL,
			denom_prov,
			NULL,
			pc.fechanac,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			NULL,
			false,
			NULL,
			3
			
	FROM pacientes_turnos_cullen pc;
	
/* habilita los indices para la tabla personas*/	
ALTER TABLE personas ENABLE KEYS;
