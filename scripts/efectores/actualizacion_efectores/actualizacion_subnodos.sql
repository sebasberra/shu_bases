DROP TABLE IF EXISTS d_subregion;

CREATE TABLE `d_subregion` (
  `numregion` tinyint(4) NOT NULL default '0',
  `numsubregion` smallint(6) NOT NULL default '0',
  `descsubregion` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`numregion`,`numsubregion`),
  KEY `numsubregion` (`numsubregion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/* carga los datos */
LOAD DATA LOCAL INFILE 'bs_mod_sims_d_subregion.csv' 
	INTO TABLE d_subregion
	CHARACTER SET 'utf8'
	FIELDS	TERMINATED BY ';'
			ENCLOSED BY '"'
	LINES TERMINATED BY '\r\n';
	
INSERT IGNORE 
	INTO subnodos 
	VALUES (0,6,'NO DEFINIDO (NODO NO DEFINIDO)',0,0);
	
INSERT INTO subnodos

	SELECT
		0,
		IFNULL(
			(SELECT 
					id_nodo
				FROM
					nodos nn
				WHERE
					nn.numregion = sr.numregion
			),
			6),
		sr.descsubregion,
		sr.numregion,
		sr.numsubregion
	FROM
		d_subregion sr
		
	ON DUPLICATE KEY UPDATE
	
		id_nodo 		= IFNULL(
							(SELECT 
								id_nodo
							FROM
								nodos nn
							WHERE
								nn.numregion = sr.numregion
							),
							6),
					
		nom_subnodo 	= IF(sr.numsubregion=1,subnodos.nom_subnodo,sr.descsubregion),
		numregion 		= sr.numregion,
		numsubregion 	= sr.numsubregion;
		
		