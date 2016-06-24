-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 22-06-2016 a las 21:15:46
-- Versión del servidor: 5.6.24
-- Versión de PHP: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ejemploabm`
--
CREATE DATABASE IF NOT EXISTS `ejemploabm` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `ejemploabm`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `BorrarPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BorrarPersona`(IN `idp` INT(18))
    NO SQL
delete from persona	WHERE id=idp$$

DROP PROCEDURE IF EXISTS `InsertarMascota`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarMascota`(IN `idd` INT, IN `nom` VARCHAR(50), IN `tipos` VARCHAR(35), IN `fotos` VARCHAR(100))
    NO SQL
INSERT into mascotas (id,nombre,tipo,foto)
values
(idd,nom,tipos,fotos)$$

DROP PROCEDURE IF EXISTS `InsertarPersona`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarPersona`(IN `pnombre` VARCHAR(50), IN `papellido` VARCHAR(50), IN `pdni` VARCHAR(50), IN `pfoto` VARCHAR(50))
    NO SQL
INSERT into persona (nombre,apellido,dni,foto)
values
(pnombre,papellido,pdni,pfoto)$$

DROP PROCEDURE IF EXISTS `ModificarMascota`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `ModificarMascota`(IN `idd` INT, IN `nom` VARCHAR(50), IN `tipoo` VARCHAR(50), IN `fotos` INT(100))
    NO SQL
update mascotas 
				set nombre=nom,
				tipo=tipoo,
				foto=fotos
				WHERE id=idd$$

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
  `nombre` varchar(55) NOT NULL,
  `tipo` varchar(55) NOT NULL,
  `foto` mediumtext NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mascotas`
--

INSERT INTO `mascotas` (`id`, `nombre`, `tipo`, `foto`) VALUES
(12, 'rocky', 'perro', '12.jpg'),
(16, 'perri', 'daada', '16'),
(23, 'jaja', 'coala', '23'),
(67, 'ooioi', 'ygygyug', '67.JPG');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

DROP TABLE IF EXISTS `persona`;
CREATE TABLE IF NOT EXISTS `persona` (
  `id` int(11) NOT NULL,
  `nombre` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `apellido` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `dni` varchar(50) COLLATE utf8_spanish2_ci NOT NULL,
  `foto` varchar(50) COLLATE utf8_spanish2_ci NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish2_ci;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`id`, `nombre`, `apellido`, `dni`, `foto`) VALUES
(4, 'Rogelio', 'Agua', '333333', '333333.jpg'),
(5, 'Bañera', 'Giratoria', '222222', '222222.jpg'),
(6, 'Julieta', 'Roberto', '888888', '888888.jpg'),
(7, 'Tomas', 'Crucero', '777777', '777777.jpg'),
(8, 'Alfredo', 'Mercurio', '999999', '999999.jpg'),
(9, 'Jaime', 'Marrón', '555555', '555555.jpg'),
(10, 'Esteban', 'Trabajos', '111111', '111111.jpg'),
(22, 'natalia', 'natalia', '12312312', '12312312.jpg'),
(23, 'natalio', 'natalio', '4555555555', '12312.jpg'),
(25, 'Sanchez', 'carolina', '3333335', '888888.jpg'),
(27, 'Hugo', 'Lopez', '5555555', '2.jpg'),
(28, 'Hugo', 'Ibañez', '5555333', '4.jpg'),
(32, 'Claudio', 'Alvarez', '12123123', '12312.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(8) NOT NULL,
  `mail` varchar(25) NOT NULL,
  `user` varchar(25) NOT NULL,
  `pass` varchar(25) NOT NULL,
  `tipo` varchar(25) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `mail`, `user`, `pass`, `tipo`) VALUES
(1, 'pablo@norauto.com', 'pablo', 'P', 'administrador'),
(6, 'DanielPerez@norauto.com', 'Daniel Perez', 'D', 'empleado'),
(7, 'CarlaOrtiz@norauto.com', 'Carla Ortiz', 'C', 'empleado'),
(8, 'HectorAreco@norauto.com', 'Hector Areco', 'H', 'empleado'),
(9, 'HugoOliva@norauto.com', 'Hugo Oliva', 'H', 'empleado'),
(10, 'SilvinaPerez@norauto.com', 'Silvina Perez', 'S', 'empleado'),
(11, 'JuanDominguez@norauto.com', 'Juan Dominguez', 'J', 'empleado'),
(12, 'MarceloDiaz@norauto.com', 'Marcelo Diaz', 'D', 'empleado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE IF NOT EXISTS `usuarios` (
  `mail` varchar(30) NOT NULL,
  `user` varchar(30) NOT NULL,
  `pass` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`mail`, `user`, `pass`) VALUES
('p@mail.com', 'pepe', '123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `mascotas`
--
ALTER TABLE `mascotas`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=68;
--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(8) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=13;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
