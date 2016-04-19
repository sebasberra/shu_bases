/*
SQLyog Community Edition- MySQL GUI v8.14 
MySQL - 5.1.34-community : Database - localidades
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `departamentos` */

CREATE TABLE `departamentos` (
  `id_dpto` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_prov` int(10) unsigned NOT NULL,
  `nom_dpto` varchar(50) NOT NULL,
  `cod_dpto` char(3) NOT NULL,
  PRIMARY KEY (`id_dpto`),
  KEY `departamentos_fk_id_prov` (`id_prov`),
  KEY `idx_nom_dpto` (`nom_dpto`),
  CONSTRAINT `departamentos_ibfk_1` FOREIGN KEY (`id_prov`) REFERENCES `provincias` (`id_prov`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=myisam AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Table structure for table `localidades` */

CREATE TABLE `localidades` (
  `id_localidad` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_dpto` int(10) unsigned DEFAULT NULL,
  `nom_loc` varchar(50) NOT NULL,
  `cod_loc` char(2) NOT NULL,
  `cod_dpto` char(3) NOT NULL,
  `cod_prov` char(2) NOT NULL,
  `cod_pais` char(3) NOT NULL,
  `cod_postal` varchar(4) DEFAULT NULL,
  PRIMARY KEY (`id_localidad`),
  UNIQUE KEY `idx_unique_cod_loc_cod_dpto_cod_prov_cod_pais` (`cod_loc`,`cod_dpto`,`cod_prov`,`cod_pais`),
  KEY `localidades_fk_id_dpto` (`id_dpto`),
  KEY `idx_nom_loc` (`nom_loc`),
  CONSTRAINT `localidades_ibfk_1` FOREIGN KEY (`id_dpto`) REFERENCES `departamentos` (`id_dpto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=myisam AUTO_INCREMENT=814 DEFAULT CHARSET=latin1;

/*Table structure for table `paises` */

CREATE TABLE `paises` (
  `id_pais` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_pais` varchar(50) NOT NULL,
  `cod_pais` char(3) NOT NULL,
  PRIMARY KEY (`id_pais`),
  KEY `idx_nom_pais` (`nom_pais`)
) ENGINE=myisam AUTO_INCREMENT=213 DEFAULT CHARSET=latin1;

/*Table structure for table `provincias` */

CREATE TABLE `provincias` (
  `id_prov` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `id_pais` int(10) unsigned NOT NULL,
  `nom_prov` varchar(50) NOT NULL,
  `cod_prov` char(2) NOT NULL,
  PRIMARY KEY (`id_prov`),
  KEY `provincias_fk_id_pais` (`id_pais`),
  KEY `idx_nom_prov` (`nom_prov`),
  CONSTRAINT `provincias_ibfk_1` FOREIGN KEY (`id_pais`) REFERENCES `paises` (`id_pais`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=myisam AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

/*Table structure for table `versiones` */

CREATE TABLE `versiones` (
  `base` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=myisam DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
