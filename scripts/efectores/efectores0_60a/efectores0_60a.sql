DROP DATABASE IF EXISTS efectores0_60a;

CREATE DATABASE efectores0_60a;
USE efectores0_60a;

/* localidades 0.11b */
source ../localidades/localidades_0_11b.sql


/* tablas del mod sims */

/* d_establecimiento */
source mod_sims/d_establecimiento.sql;

/* d_region */
source mod_sims/d_region.sql

/* d_subregion */
source mod_sims/d_subregion.sql

/* d_nivel_complejidad */
source mod_sims/d_nivel_complejidad.sql

/* d_regimen_juridico */
source mod_sims/d_regimen_juridico.sql

/* d_dependencia_administrativa */
source mod_sims/d_depenadm.sql





/* dependencias_administrativas */
DROP TABLE IF EXISTS dependencias_administrativas;

CREATE TABLE dependencias_administrativas (
	id_dependencia_adm TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	cod_dep_adm CHAR(1) NOT NULL,
	nom_dep_adm VARCHAR(50) NOT NULL,
	tipo_dep_adm CHAR(1) NOT NULL,
	PRIMARY KEY (id_dependencia_adm),
	UNIQUE KEY idx_unique_cod_dep_adm (cod_dep_adm)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='Determina la dependencia administrativa del efector';

INSERT INTO
	
	dependencias_administrativas
	
SELECT
	
	/* id_dependencia_adm */
	0,
	
	/* cod_dep_adm */
	dda.coddepadm,
	
	/* nom_dep_adm */
	dda.nomdepadm,
	
	/* tipo_dep_adm */
	dda.tipdepadm
	
FROM

	d_depenadm dda;
	
	
/* niveles_complejidades */
DROP TABLE IF EXISTS niveles_complejidades;

CREATE TABLE niveles_complejidades (
	id_nivel_complejidad TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	nivcomest VARCHAR(4) NOT NULL,
	descripcion VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_nivel_complejidad),
	UNIQUE KEY idx_unique_nivcomest (nivcomest)
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1 
COMMENT='niveles de complejidad de los efectores';

INSERT INTO

	niveles_complejidades
	
SELECT
	
	/* id_nivel_complejidad */
	0,
	
	/* nivcomest */
	dnc.nivcomest,
	
	/* descripcion */
	dnc.descripcion
	
FROM

	d_nivel_complejidad dnc;
	

/* nodos */
DROP TABLE IF EXISTS nodos;

CREATE TABLE nodos (
	id_nodo SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
	nom_nodo VARCHAR(255) NOT NULL,
	numregion TINYINT(3) UNSIGNED NOT NULL,
	PRIMARY KEY (id_nodo),
	UNIQUE KEY idx_unique_numregion (numregion)
) 
ENGINE=InnoDB
DEFAULT CHARSET=latin1 
COMMENT='nodos de la division zonal de la provincia de santa fe';

INSERT INTO
	
	nodos
	
SELECT

	/* id_nodo */
	0,
	
	/* nom_nodo */
	dr.nomregion,
	
	/* numregion */
	dr.numregion
	
FROM

	d_region dr;
	

/* table regimenes_juridicos */
DROP TABLE IF EXISTS regimenes_juridicos;

CREATE TABLE regimenes_juridicos (
	id_regimen_juridico TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
	regjurest VARCHAR(15) NOT NULL,
	codigo CHAR(2) NOT NULL,
	PRIMARY KEY (id_regimen_juridico),
	UNIQUE KEY idx_unique_codigo (codigo)
) 
ENGINE=InnoDB AUTO_INCREMENT=9
DEFAULT CHARSET=latin1 
COMMENT='regimenes juridicos de los efectores';

INSERT INTO

	regimenes_juridicos
	
SELECT
	
	/* id_regimen_juridico */
	0,
	
	/* regjurest */
	drj.regjurest,
	
	/* codigo */
	drj.codigo
	
FROM

	d_regimen_juridico drj;



/* subnodos */
DROP TABLE IF EXISTS subnodos;

CREATE TABLE subnodos (
	id_subnodo INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
	id_nodo INT(10) UNSIGNED NOT NULL,
	nom_subnodo VARCHAR(255) NOT NULL,
	numregion TINYINT(3) UNSIGNED NOT NULL,
	numsubregion SMALLINT(5) UNSIGNED NOT NULL,
	PRIMARY KEY (id_subnodo),
	UNIQUE KEY idx_unique_numregion_numsubregion (numregion,numsubregion)
) 
ENGINE=InnoDB
DEFAULT CHARSET=latin1 
COMMENT='subnodos de la division zonal de la provincia de santa fe';

INSERT INTO

	subnodos
	
SELECT

	/* id_subnodo */
	0,
	
	/* id_nodo */
	(SELECT
		n.id_nodo
	FROM
		nodos n
	WHERE
		n.numregion = dsn.numregion
	),
	
	/* nom_subnodo */
	dsn.descsubregion,
	
	/* numregion */
	dsn.numregion,
	
	/* numsubregion */
	dsn.numsubregion
	
FROM

	d_subregion dsn;


/* table efectores */
CREATE TABLE IF NOT EXISTS efectores (
	id_efector INT UNSIGNED NOT NULL,
	id_nodo SMALLINT UNSIGNED NOT NULL,
	id_subnodo INT UNSIGNED NOT NULL,
	id_localidad INT UNSIGNED NOT NULL,
	id_dependencia_adm TINYINT UNSIGNED NULL DEFAULT NULL,
	id_regimen_juridico TINYINT UNSIGNED NOT NULL,
	id_nivel_complejidad TINYINT UNSIGNED NOT NULL COMMENT 'Nivel de complejidad del ejector. Ver tabla niveles_complejidades',
	claveestd VARCHAR(8) NOT NULL,
	clavesisa CHAR(14) NULL COMMENT 'clave SISA (Sistema Integrado de Informacion Argentino)',
	tipo_efector CHAR(1) NULL DEFAULT NULL COMMENT 'tipo establecimiento para el informe de estadistica',
	nom_efector VARCHAR(255) NOT NULL,
	nom_red_efector VARCHAR(50) NOT NULL,
	nodo TINYINT(4) UNSIGNED NOT NULL,
	subnodo SMALLINT(6) UNSIGNED NOT NULL,
	internacion TINYINT(1) NOT NULL COMMENT 'Indica si el efector tiene internacion o no',
	baja TINYINT(1) NOT NULL COMMENT 'Indica si el efector esta activo o fue dado de baja',
	PRIMARY KEY (id_efector),
	UNIQUE INDEX idx_unique_claveestd (claveestd ASC),
	INDEX idx_fk_efectores_id_localidad (id_localidad ASC),
	INDEX idx_fk_efectores_id_dependencia_adm (id_dependencia_adm ASC),
	INDEX idx_fk_efectores_id_regimen_juridico (id_regimen_juridico ASC),
	INDEX idx_fk_efectores_id_nodo (id_nodo ASC),
	INDEX idx_fk_efectores_id_subnodo (id_subnodo ASC),
	INDEX idx_fk_efectores_id_nivel_complejidad (id_nivel_complejidad ASC),
	INDEX idx_clavesisa (clavesisa ASC),
	INDEX idx_nom_efector (nom_efector ASC),
	CONSTRAINT fk_efectores_id_localidad
		FOREIGN KEY (id_localidad)
		REFERENCES localidades (id_localidad)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_efectores_id_dependencia_adm
		FOREIGN KEY (id_dependencia_adm)
		REFERENCES dependencias_administrativas (id_dependencia_adm)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_efectores_id_regimen_juridica
		FOREIGN KEY (id_regimen_juridico)
		REFERENCES regimenes_juridicos (id_regimen_juridico)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_efectores_id_nodo
		FOREIGN KEY (id_nodo)
		REFERENCES nodos (id_nodo)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_efectores_id_subnodo
		FOREIGN KEY (id_subnodo)
		REFERENCES subnodos (id_subnodo)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION,
	CONSTRAINT fk_efectores_id_nivel_complejidad
		FOREIGN KEY (id_nivel_complejidad)
		REFERENCES niveles_complejidades (id_nivel_complejidad)
			ON DELETE NO ACTION
			ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1
COMMENT = 'efectores publicos y privados de la provincia de santa fe';


/* carga los efectores desde la tabla mod_sims.d_establecimiento */
INSERT INTO
	
	efectores
	
SELECT 

	/* id_efector */
	est.id_establecimiento,
	
	/* id_nodo */
	IFNULL(
		(SELECT 
			id_nodo
		FROM
			nodos n
		WHERE
			n.numregion = est.codzonest
		),
		6
	),
	
	/* id_subnodo */
	IFNULL(
		(SELECT 
			id_subnodo
		FROM
			subnodos sn
		WHERE
			sn.numregion = est.codzonest
		AND	sn.numsubregion = est.subnodo
		),
		IFNULL(
			(SELECT 
				id_subnodo
			FROM
				subnodos sn
			WHERE
				sn.numregion = est.codzonest
			AND	sn.numsubregion = 1),
			29
		)
	),
	
	/* id_localidad */
	IFNULL((SELECT id_localidad 
		FROM localidades l, departamentos d 
		WHERE	l.cod_loc	= est.codlocest 
		AND		d.cod_dpto	= est.coddepest 
		AND		l.id_dpto	= d.id_dpto),570),
		
	/* id_dependencia_adm */
	(SELECT id_dependencia_adm
		FROM dependencias_administrativas da
		WHERE da.cod_dep_adm = est.depadmest),
		
	/* id_regimen_juridico */
	(SELECT id_regimen_juridico
		FROM regimenes_juridicos rj
		WHERE rj.codigo = est.regimenjuridico),
		
	/* id_nivel_complejidad */
	IFNULL(
		(SELECT id_nivel_complejidad
			FROM niveles_complejidades nc
			WHERE nc.nivcomest = est.nivcomest),
			1
			),
		
	/* claveestd */
	est.claveestd, 
	
	/* clavesisa */
	est.clavesisa,
	
	/* tipo_efector */
	est.coddigest,
	
	/* nom_efector */
	UCASE(nomest), 
	
	/* nom_red_efector */
	IFNULL(nomredest,LEFT(nomest,50)), 
	
	/* nodo */
	IF(est.codzonest='10','0',est.codzonest), 
	
	/* subnodo */
	IFNULL(
			(SELECT 
				numsubregion
			FROM
				subnodos sn
			WHERE
				sn.numregion = est.codzonest
			AND	sn.numsubregion = est.subnodo
			),
			IFNULL(
				(SELECT 
					numsubregion
				FROM
					subnodos sn
				WHERE
					sn.numregion = est.codzonest
				AND	sn.numsubregion = 1),
				0
			)
	),
	
	/* internacion */
	est.marintest,
	
	/* baja */
	IF(essipes='B',1,0) 
	
FROM 
	d_establecimiento est;
