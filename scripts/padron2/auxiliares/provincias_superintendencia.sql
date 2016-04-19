/*
SQLyog Community Edition- MySQL GUI v8.14 
MySQL - 5.1.34-community : Database - padron
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `provincias` */

CREATE TABLE `provincias` (
  `codprov` char(2) NOT NULL DEFAULT '"',
  `NomProv` char(20) DEFAULT '',
  PRIMARY KEY (`codprov`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Data for the table `provincias` */

insert  into `provincias`(`codprov`,`NomProv`) values ('01','CAPITAL FEDERAL');
insert  into `provincias`(`codprov`,`NomProv`) values ('02','BUENOS AIRES');
insert  into `provincias`(`codprov`,`NomProv`) values ('03','CATAMARCA');
insert  into `provincias`(`codprov`,`NomProv`) values ('04','CORDOBA');
insert  into `provincias`(`codprov`,`NomProv`) values ('05','CORRIENTES');
insert  into `provincias`(`codprov`,`NomProv`) values ('06','ENTRE RIOS');
insert  into `provincias`(`codprov`,`NomProv`) values ('07','JUJUY');
insert  into `provincias`(`codprov`,`NomProv`) values ('08','LA RIOJA');
insert  into `provincias`(`codprov`,`NomProv`) values ('09','MENDOZA');
insert  into `provincias`(`codprov`,`NomProv`) values ('10','SALTA');
insert  into `provincias`(`codprov`,`NomProv`) values ('11','SAN JUAN');
insert  into `provincias`(`codprov`,`NomProv`) values ('12','SAN LUIS');
insert  into `provincias`(`codprov`,`NomProv`) values ('13','SANTA FE');
insert  into `provincias`(`codprov`,`NomProv`) values ('14','SANTIAGO DEL ESTERO');
insert  into `provincias`(`codprov`,`NomProv`) values ('15','TUCUMAN');
insert  into `provincias`(`codprov`,`NomProv`) values ('16','CHACO');
insert  into `provincias`(`codprov`,`NomProv`) values ('17','CHUBUT');
insert  into `provincias`(`codprov`,`NomProv`) values ('18','FORMOSA');
insert  into `provincias`(`codprov`,`NomProv`) values ('19','LA PAMPA');
insert  into `provincias`(`codprov`,`NomProv`) values ('20','MISIONES');
insert  into `provincias`(`codprov`,`NomProv`) values ('21','NEUQUEN');
insert  into `provincias`(`codprov`,`NomProv`) values ('22','RIO NEGRO');
insert  into `provincias`(`codprov`,`NomProv`) values ('23','SANTA CRUZ');
insert  into `provincias`(`codprov`,`NomProv`) values ('24','TIERRA DEL FUEGO');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
