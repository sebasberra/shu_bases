/*
SQLyog Community v12.01 (32 bit)
MySQL - 10.0.25-MariaDB : Database - efectores0_55a
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `dependencias_administrativas` */

DROP TABLE IF EXISTS `dependencias_administrativas`;

CREATE TABLE `dependencias_administrativas` (
  `id_dependencia_adm` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `cod_dep_adm` char(1) NOT NULL,
  `nom_dep_adm` varchar(50) NOT NULL,
  `tipo_dep_adm` char(1) NOT NULL,
  PRIMARY KEY (`id_dependencia_adm`),
  UNIQUE KEY `idx_unique_cod_dep_adm` (`cod_dep_adm`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1 COMMENT='Determina la dependencia administrativa del efector';

/*Table structure for table `niveles_complejidades` */

DROP TABLE IF EXISTS `niveles_complejidades`;

CREATE TABLE `niveles_complejidades` (
  `id_nivel_complejidad` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `nivcomest` varchar(4) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  PRIMARY KEY (`id_nivel_complejidad`),
  UNIQUE KEY `idx_unique_nivcomest` (`nivcomest`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COMMENT='niveles de complejidad de los efectores';

/*Table structure for table `nodos` */

DROP TABLE IF EXISTS `nodos`;

CREATE TABLE `nodos` (
  `id_nodo` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `nom_nodo` varchar(255) NOT NULL,
  `numregion` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id_nodo`),
  UNIQUE KEY `idx_unique_numregion` (`numregion`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='nodos de la division zonal de la provincia de santa fe';

/*Table structure for table `regimenes_juridicos` */

DROP TABLE IF EXISTS `regimenes_juridicos`;

CREATE TABLE `regimenes_juridicos` (
  `id_regimen_juridico` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `regjurest` varchar(15) NOT NULL,
  `codigo` char(2) NOT NULL,
  PRIMARY KEY (`id_regimen_juridico`),
  UNIQUE KEY `idx_unique_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 COMMENT='regimenes juridicos de los efectores';

/*Table structure for table `subnodos` */

DROP TABLE IF EXISTS `subnodos`;

CREATE TABLE `subnodos` (
  `id_subnodo` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_nodo` int(10) unsigned NOT NULL,
  `nom_subnodo` varchar(255) NOT NULL,
  `numregion` tinyint(3) unsigned NOT NULL,
  `numsubregion` smallint(5) unsigned NOT NULL,
  PRIMARY KEY (`id_subnodo`),
  UNIQUE KEY `idx_unique_numregion_numsubregion` (`numregion`,`numsubregion`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1 COMMENT='subnodos de la division zonal de la provincia de santa fe';

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
