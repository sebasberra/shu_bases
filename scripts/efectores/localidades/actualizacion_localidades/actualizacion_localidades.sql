DROP TABLE IF EXISTS d_localidad;

CREATE TABLE d_localidad (
  claveloc varchar(5) NOT NULL default '',
  coddepto char(3) default NULL,
  codloc char(2) default NULL,
  codprov char(2) default NULL,
  codzon char(2) default NULL,
  nomloc varchar(40) default NULL,
  codposloc varchar(4) default NULL,
  agregacion int(1) default NULL,
  nomdepto1 varchar(40) NOT NULL default '',
  PRIMARY KEY  (claveloc),
  KEY codzon (codzon)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/* carga los datos */
LOAD DATA LOCAL INFILE 'bs_mod_sims_d_localidad.csv' 
	INTO TABLE d_localidad
	CHARACTER SET 'utf8'
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n';

INSERT INTO versiones VALUES ("localidades","v 0.1a",NOW());

/* crea el indice unico de codloc, coddepto, codprov y codpais */
/*CREATE UNIQUE INDEX idx_unique_cod_loc_cod_dpto_cod_prov_cod_pais ON localidades (cod_loc,cod_dpto,cod_prov,cod_pais);*/

/* inserta localidades nuevas y actualiza las existentes */
INSERT INTO localidades 
	SELECT 
		0,
		(SELECT id_dpto 
			FROM departamentos d
			WHERE	d.cod_dpto	= dl.coddepto),
		dl.nomloc,
		dl.codloc, 
		dl.coddepto,
		dl.codprov, 
		'200',
		dl.codposloc
	FROM d_localidad dl
	WHERE dl.nomloc<>'LOCALIDAD NO ESPECIFICADA'
	
	ON DUPLICATE KEY UPDATE
	
		nom_loc = dl.nomloc,
		cod_postal = dl.codposloc;