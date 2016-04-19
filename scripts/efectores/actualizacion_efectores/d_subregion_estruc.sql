-- phpMyAdmin SQL Dump
-- version 2.6.0-pl2
-- http://www.phpmyadmin.net
-- 
-- Servidor: localhost
-- Tiempo de generación: 11-05-2011 a las 09:02:59
-- Versión del servidor: 4.1.10
-- Versión de PHP: 4.3.10
-- 
-- Base de datos: `bs_mod_sims`
-- 

-- --------------------------------------------------------

-- 
-- Estructura de tabla para la tabla `d_subregion`
-- 

CREATE TABLE `d_subregion` (
  `numregion` tinyint(4) NOT NULL default '0',
  `numsubregion` smallint(6) NOT NULL default '0',
  `descsubregion` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`numregion`,`numsubregion`),
  KEY `numsubregion` (`numsubregion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
