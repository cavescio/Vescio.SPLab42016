-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 19-05-2016 a las 00:51:18
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `primerparcial`
--
CREATE DATABASE IF NOT EXISTS `primerparcial` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `primerparcial`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `BorrarPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarPersona`(IN `idp` INT(18))
    NO SQL
delete from persona	WHERE id=idp$$

DROP PROCEDURE IF EXISTS `InsertarPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPersona`(IN `pnombre` VARCHAR(50), IN `papellido` VARCHAR(50), IN `pdni` VARCHAR(50), IN `pfoto` VARCHAR(50))
    NO SQL
INSERT into persona (nombre,apellido,dni,foto)
values
(pnombre,papellido,pdni,pfoto)$$

DROP PROCEDURE IF EXISTS `ModificarPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarPersona`(IN `pid` INT, IN `pnombre` VARCHAR(50), IN `papellido` VARCHAR(50), IN `pfoto` VARCHAR(50))
    NO SQL
update persona 
				set nombre=pnombre,
				apellido=papellido,
				foto=pfoto
				WHERE id=pid$$

DROP PROCEDURE IF EXISTS `TraerTodasLasPersonas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerTodasLasPersonas`()
    NO SQL
select * from persona$$

DROP PROCEDURE IF EXISTS `TraerUnaPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `TraerUnaPersona`(IN `idp` INT(18))
    NO SQL
select * from persona where id =idp$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mascotas`
--

DROP TABLE IF EXISTS `mascotas`;
CREATE TABLE IF NOT EXISTS `mascotas` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `especie` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `edad` int(50) NOT NULL,
  `foto` varchar(50) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `mascotas`
--

INSERT INTO `mascotas` (`id`, `nombre`, `especie`, `edad`, `foto`) VALUES
(13, 'Raúl', 'Perro', 4, '13.jpg'),
(21, 'Rodolfo', 'Koala', 2, '21.jpg'),
(24, 'Por defecto', 'Por defecto', 5, '24.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mascotas2`
--

DROP TABLE IF EXISTS `mascotas2`;
CREATE TABLE IF NOT EXISTS `mascotas2` (
  `id` int(8) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `fecha_nac` date NOT NULL,
  `edad` int(8) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `sexo` varchar(50) NOT NULL,
  `foto` varchar(50) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mascotas2`
--

INSERT INTO `mascotas2` (`id`, `nombre`, `fecha_nac`, `edad`, `tipo`, `sexo`, `foto`) VALUES
(1, 'mica', '2016-05-18', 2, 'Gato', 'Femenino', 'pordefecto.png'),
(2, 'Mascotita', '0000-00-00', 2, 'Perro', 'Masculino', '2.jpg'),
(4, 'michi', '0000-00-00', 6, 'Gato', 'Masculino', '4.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(10) unsigned NOT NULL,
  `mail` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `user` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `pass` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `tipo` varchar(10) COLLATE utf8_spanish_ci NOT NULL DEFAULT 'user'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `mail`, `user`, `pass`, `tipo`) VALUES
(1, 'asd@fgh.com', 'Asd', 'Asd123', 'user'),
(3, 'fgh@jkl.com', 'Fgh', 'Fgh789', 'user'),
(4, 'hola@hotmail.com', 'pablo', 'pablo', 'admin'),
(5, 'vicky@vicky.com', 'vicky', 'vicky', 'user'),
(6, 'lolol@lolol.com', 'ayyyyy', 'lmaooo', 'user'),
(7, 'usuario@mail.com', 'usuario', 'pass123', 'user');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `mascotas`
--
ALTER TABLE `mascotas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `mascotas2`
--
ALTER TABLE `mascotas2`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `mascotas`
--
ALTER TABLE `mascotas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT de la tabla `mascotas2`
--
ALTER TABLE `mascotas2`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=8;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
