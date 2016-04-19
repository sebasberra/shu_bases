DROP TABLE IF EXISTS d_establecimiento;

CREATE TABLE `d_establecimiento` (
  `cbrest` varchar(8) default NULL,
  `jerarquia` char(1) NOT NULL default '0',
  `coddepest` char(3) NOT NULL default '',
  `codnroest` varchar(5) default NULL,
  `coddigest` char(1) default NULL,
  `nomest` varchar(80) default NULL,
  `nomredest` varchar(30) default NULL,
  `cabcoddepest` char(3) default NULL,
  `cabcodnroest` varchar(5) default NULL,
  `nodo` tinyint(4) NOT NULL default '0',
  `subnodo` smallint(6) NOT NULL default '0',
  `codzonest` char(2) default NULL,
  `codlocest` char(2) default NULL,
  `dcalest` varchar(40) default NULL,
  `dnroest` varchar(5) default NULL,
  `dcpest` varchar(4) default NULL,
  `telest` varchar(30) default NULL,
  `faxest` varchar(20) default NULL,
  `emailest` varchar(40) default NULL,
  `nivcomest` varchar(4) default NULL,
  `fechabest` datetime default NULL,
  `codprovest` char(2) default NULL,
  `codparbarest` char(3) default NULL,
  `regjurest` varchar(15) default NULL,
  `regimenjuridico` char(2) default NULL,
  `acadmest` varchar(15) default NULL,
  `fecadmest` datetime default NULL,
  `hpaest` smallint(6) default NULL,
  `tipogestion` varchar(40) NOT NULL default '',
  `hpainsest` varchar(10) default NULL,
  `camaguest` smallint(6) default NULL,
  `camcroest` smallint(6) default NULL,
  `fecactest` datetime default NULL,
  `marintest` smallint(1) default NULL,
  `depadmest` char(1) default NULL,
  `tipifest` char(2) default NULL,
  `directest` varchar(30) default NULL,
  `presidest` varchar(25) default NULL,
  `tesorest` varchar(25) default NULL,
  `secreest` varchar(25) default NULL,
  `repestest` varchar(25) default NULL,
  `repproest` varchar(25) default NULL,
  `repnopest` varchar(25) default NULL,
  `repcomest` varchar(25) default NULL,
  `repcooest` varchar(25) default NULL,
  `fecapeest` datetime default NULL,
  `feccieest` datetime default NULL,
  `marbasest` smallint(6) default NULL,
  `marindest` smallint(6) default NULL,
  `marurbest` smallint(6) default NULL,
  `marinfest` smallint(6) default NULL,
  `marenfest` smallint(6) default NULL,
  `rrhest` varchar(6) default NULL,
  `rendicest` varchar(6) default NULL,
  `sueldest` varchar(6) default NULL,
  `claveestd` varchar(8) NOT NULL default '',
  `clavesisa` varchar(14) default NULL,
  `agregacion` int(1) default NULL,
  `clavelocest` varchar(5) NOT NULL default '',
  `fechaoper` datetime NOT NULL default '0000-00-00 00:00:00',
  `essipes` char(1) NOT NULL default '',
  `usuario` varchar(20) default NULL,
  `id_establecimiento` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id_establecimiento`),
  UNIQUE KEY `ix_claveestd` (`claveestd`),
  INDEX idx_id_establecimiento (id_establecimiento)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/* carga los datos */
LOAD DATA LOCAL INFILE 'bs_mod_sims_d_establecimiento.csv' 
	INTO TABLE d_establecimiento
	CHARACTER SET 'utf8'
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n';

/*CREATE TABLE IF NOT EXISTS efectores (
  id_efector 			INTEGER 	UNSIGNED NOT NULL,
  id_nodo				INTEGER		UNSIGNED	NOT NULL,
  id_subnodo			INTEGER		UNSIGNED	NULL,
  id_localidad 			INTEGER 	UNSIGNED NOT NULL,
  id_dependencia_adm	INTEGER 	UNSIGNED NULL,
  id_regimen_juridico	INTEGER 	UNSIGNED NOT NULL,
  id_nivel_complejidad	TINYINT		UNSIGNED NOT NULL,
  claveestd 			VARCHAR(8) NOT NULL,
  tipo_efector	 		CHAR(1) NULL COMMENT 'tipo establecimiento para el informe de estadistica',
  nom_efector 			VARCHAR(100) NULL,
  nom_red_efector 		VARCHAR(50) NULL,
  nodo 					TINYINT(4) UNSIGNED NULL,
  subnodo 				SMALLINT(6) UNSIGNED NULL,
  internacion			BOOLEAN NOT NULL,
  baja					BOOLEAN NOT NULL,
  PRIMARY KEY(id_efector),
  UNIQUE INDEX idx_unique_claveestd (claveestd),
  FOREIGN KEY fk_id_localidad(id_localidad)
    REFERENCES localidades(id_localidad)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY fk_id_dependencia_adm(id_dependencia_adm)
    REFERENCES dependencias_administrativas(id_dependencia_adm)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY fk_id_regimen_juridico(id_regimen_juridico)
    REFERENCES regimenes_juridicos(id_regimen_juridico)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY fk_id_nodo(id_nodo)
    REFERENCES nodos(id_nodo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY fk_id_subnodo(id_subnodo)
    REFERENCES subnodos(id_subnodo)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION,
  FOREIGN KEY fk_id_nivel_complejidad(id_nivel_complejidad)
    REFERENCES niveles_complejidades(id_nivel_complejidad)
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
)ENGINE=MyISAM;*/


/* check diferencias en id_establecimiento con id_efector */
DROP TABLE IF EXISTS efectores_establecimiento_diferencias;

CREATE TABLE efectores_establecimiento_diferencias (

	d_establecimiento_claveestd 			CHAR(8) 				NOT NULL,
	efectores_claveest						CHAR(8) 				NOT NULL,
	d_establecimiento_id_establecimiento	INTEGER		UNSIGNED	NOT NULL,
	efectores_id_efector					INTEGER		UNSIGNED	NOT NULL
)ENGINE=MyISAM;
	
INSERT INTO efectores_establecimiento_diferencias
	SELECT
		est.claveestd,
		e.claveestd,
		est.id_establecimiento,
		e.id_efector
	FROM
		d_establecimiento est, efectores e
	WHERE
		(est.claveestd = e.claveestd AND
			est.id_establecimiento <> e.id_efector)
	OR
		(est.claveestd <> e.claveestd AND
			est.id_establecimiento = e.id_efector);			



/* verificar si el codigo de localidad no especificada es el 570 */
/* ver el final del IFNULL */
INSERT INTO efectores 
	SELECT 
		est.id_establecimiento,
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
		IFNULL((SELECT id_localidad 
			FROM localidades l, departamentos d 
			WHERE	l.cod_loc	= est.codlocest 
			AND		d.cod_dpto	= est.coddepest 
			AND		l.id_dpto	= d.id_dpto),570),
		(SELECT id_dependencia_adm
			FROM dependencias_administrativas da
			WHERE da.cod_dep_adm = est.depadmest),
		(SELECT id_regimen_juridico
			FROM regimenes_juridicos rj
			WHERE rj.codigo = est.regimenjuridico),
		(SELECT id_nivel_complejidad
			FROM niveles_complejidades nc
			WHERE nc.nivcomest = est.nivcomest),
		est.claveestd, 
		est.coddigest,
		nomest, 
		IFNULL(nomredest,LEFT(nomest,50)), 
		IF(est.codzonest='10','0',est.codzonest), 
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
		est.marintest,
		IF(essipes='B',1,0) 
	FROM d_establecimiento est
	
	ON DUPLICATE KEY UPDATE
	
	
		id_localidad = IFNULL(
								(SELECT id_localidad 
									FROM localidades l, departamentos d 
									WHERE l.cod_loc = est.codlocest 
									AND d.cod_dpto = est.coddepest 
									AND l.id_dpto  = d.id_dpto),
								570),
		id_nodo = IFNULL(
						(SELECT 
							id_nodo
						FROM
							nodos n
						WHERE
							n.numregion = est.codzonest
						),
						6
					),
		id_subnodo = IFNULL(
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
		id_dependencia_adm = (SELECT id_dependencia_adm
								FROM dependencias_administrativas da
								WHERE da.cod_dep_adm = est.depadmest),
		id_regimen_juridico = (SELECT id_regimen_juridico
								FROM regimenes_juridicos rj
								WHERE rj.codigo = est.regimenjuridico),
		id_nivel_complejidad = (SELECT id_nivel_complejidad
								FROM niveles_complejidades nc
								WHERE nc.nivcomest = est.nivcomest),
		tipo_efector = est.coddigest,
		nom_efector = est.nomest,
		nom_red_efector = IFNULL(nomredest,LEFT(nomest,50)),
		nodo = IF(est.codzonest='10','0',est.codzonest),
		subnodo = IFNULL(
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
		internacion = est.marintest,
		baja = IF(essipes='B',1,0)
		;
	
/* versionado */
REPLACE INTO versiones VALUES ("efectores","v 0.54a",NOW());