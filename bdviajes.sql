-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 02-12-2023 a las 06:40:37
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bdviajes`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarComprobante` (IN `nroviaje` VARCHAR(255), IN `nombrePasajero` VARCHAR(255), IN `pagoxviaje` DOUBLE)   BEGIN
    DECLARE nuevoBOL VARCHAR(10);
    SET nuevoBOL = CONCAT('BOL', LPAD((SELECT COUNT(*) + 1 FROM comprobante), 3, '0'));

    INSERT INTO comprobante (BOL_NRO, VIA_NRO, Nom_pas, pago_total)
    VALUES (nuevoBOL, nroviaje, nombrePasajero, pagoxviaje);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarComprobanteDetalle` (IN `via_nro` CHAR(6), IN `numeroAsiento` VARCHAR(40), IN `tipoPasajero` CHAR(1), IN `pagoxviaje` DECIMAL(8,1))   BEGIN
    DECLARE nroBoleta VARCHAR(6);
    DECLARE pagoAsiento DECIMAL(8,1); -- Declarar variable para pagoAsiento

    -- Obtener el último BOL_NRO generado en la tabla comprobante
    SELECT BOL_NRO INTO nroBoleta FROM comprobante ORDER BY BOL_NRO DESC LIMIT 1;

    CASE tipoPasajero
        WHEN 'E' THEN SET pagoAsiento = pagoxviaje * 0.7; -- Precio para estudiantes
        WHEN 'A' THEN SET pagoAsiento = pagoxviaje * 1.0; -- Precio para adultos
        WHEN 'N' THEN SET pagoAsiento = pagoxviaje * 0.5; -- Precio para niños
        ELSE SET pagoAsiento = 0; -- Otros casos
    END CASE;

    -- Insertar en la tabla comprobante_detalle con el BOL_NRO obtenido
    INSERT INTO Comprobante_detalle (BOL_NRO, VIA_NRO, nro_asi, tipo, pago)
    VALUES (nroBoleta, via_nro, numeroAsiento, tipoPasajero, pagoAsiento);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrarUsuario` (IN `p_nombres` VARCHAR(100), IN `p_apellidos` VARCHAR(100), IN `p_usuario` VARCHAR(30), IN `p_contraseña` CHAR(100))   BEGIN
    DECLARE usuario_existente INT;
    DECLARE nuevo_id CHAR(6); -- Declarar la variable aquí

    -- Verificar si el usuario ya existe en la base de datos
    SELECT COUNT(*) INTO usuario_existente FROM usuarios WHERE usuario = p_usuario;

    -- Si el usuario existe, no realizar la inserción
    IF usuario_existente > 0 THEN
        SELECT 0 AS resultado; -- Devolver 0 para indicar que no se pudo insertar
    ELSE
        -- Obtener el número total de usuarios registrados
        SELECT COUNT(*) INTO usuario_existente FROM usuarios;

        -- Generar el nuevo ID con el formato USUxxx (incremental)
        SET nuevo_id = CONCAT('USU', LPAD(usuario_existente + 1, 3, '0'));

        -- Insertar el nuevo usuario en la tabla
        INSERT INTO usuarios (id, nombre, apellido, tipo_usuario, usuario, clave) 
        VALUES (nuevo_id, p_nombres, p_apellidos, 'E', p_usuario, p_contraseña);

        -- Devolver el resultado (1 para éxito, 0 para error)
        SELECT IF(ROW_COUNT() > 0, 1, 0) AS resultado;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spbolqr` (`numbol` CHAR(6))   select c.bol_nro,c.nom_pas,c.pago_total,cd.nro_asi,cd.tipo,cd.pago from comprobante as c
inner join comprobante_detalle as cd on c.bol_nro=cd.bol_nro where c.bol_nro=numbol$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spchoferviaje` (`cod` CHAR(5))   select v.VIANRO,r.RUTNOM,v.VIAFCH,v.COSVIA from viaje v join ruta r on v.RUTCOD=r.RUTCOD where v.IDCOD=cod$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spNuevaBoleta` ()   select convert(max(BOLNRO),SIGNED)+1 as NuevaBoleta from pasajeros$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spNuevoId` ()   select convert(substr(max(IDCOD) from 2),SIGNED)+1 as numero from chofer$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spNuevoViaje` ()   select max(convert(vianro,SIGNED))+1 as NuevoViaje from viaje$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spPagoRuta` ()   select r.RUTCOD,r.RUTNOM,sum(p.pago) "Pago total" from ruta r join viaje v on v.RUTCOD=r.RUTCOD
join pasajeros p on p.VIANRO=v.VIANRO
group by r.RUTNOM$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spPagoViaje` ()   select distinct via_nro as viaje, 
(select sum(pago_total) from comprobante where via_nro=viaje) as total 
from comprobante order by viaje$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spPasRuta` ()   select distinct rutcod as codigo, rutnom as ruta, 
(select count(*) from comprobante_detalle as cd 
inner join comprobante as c on cd.bol_nro=c.bol_nro
inner join viaje as v on c.via_nro=v.vianro
inner join ruta as r on v.rutcod=r.rutcod where r.rutcod=codigo) as total 
from ruta order by ruta$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spTipoViaje` (`numVia` INT)   select distinct (select count(*) from comprobante_detalle where tipo='E' and via_nro=numVia) as estudiantes,
(select count(*) from comprobante_detalle where tipo='A' and via_nro=numVia) as adultos,
(select count(*) from comprobante_detalle where tipo='N' and via_nro=numVia) as niños
from comprobante_detalle where via_nro=numVia$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `spViajesChofer` ()   select c.IDCOD,c.CHONOM,count(*) Cantidad from chofer c join viaje v on v.IDCOD=c.IDCOD
group by c.CHONOM$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `bus`
--

CREATE TABLE `bus` (
  `BUSNRO` decimal(2,0) NOT NULL,
  `PLACA` char(10) DEFAULT NULL,
  `CAPACIDAD` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `bus`
--

INSERT INTO `bus` (`BUSNRO`, `PLACA`, `CAPACIDAD`) VALUES
(1, 'WH2145', 40),
(2, 'MN1975', 60),
(3, 'PQ5478', 50),
(4, 'RP7812', 40),
(5, 'TP3547', 40);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `calificaciones`
--

CREATE TABLE `calificaciones` (
  `id_calificacion` char(6) NOT NULL,
  `calificacion` int(1) NOT NULL,
  `fecha` varchar(15) DEFAULT NULL,
  `id_usuario` char(6) NOT NULL,
  `ViaNro` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `calificaciones`
--

INSERT INTO `calificaciones` (`id_calificacion`, `calificacion`, `fecha`, `id_usuario`, `ViaNro`) VALUES
('CAL001', 5, '2023-10-19', 'USU001', '100001'),
('CAL002', 4, '2023-12-1', 'USU002', '100008'),
('CAL003', 4, '2023-11-22', 'USU003', '100012'),
('CAL004', 5, '2023-11-1', 'USU005', '100018');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chofer`
--

CREATE TABLE `chofer` (
  `IDCOD` char(4) NOT NULL,
  `CHONOM` varchar(30) DEFAULT NULL,
  `CHOFIN` varchar(15) DEFAULT NULL,
  `CHOCAT` varchar(1) DEFAULT NULL,
  `CHOSBA` decimal(8,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `chofer`
--

INSERT INTO `chofer` (`IDCOD`, `CHONOM`, `CHOFIN`, `CHOCAT`, `CHOSBA`) VALUES
('C001', 'PABLO ALCAZAR', '2023-03-10', 'C', 450.0),
('C002', 'JORGE QUISPE', '2001-04-07', 'C', 200.0),
('C003', 'EDWARD TEMPLE', '2005-04-11', 'F', 450.0),
('C004', 'CHRISTINA MELGAR', '1998-04-10', 'F', 550.0),
('C005', 'MARCOS GARECA', '1995-04-12', 'F', 650.0),
('C006', 'LUIS PRIETO', '1998-04-12', 'F', 350.0),
('C007', 'MARIO CASTANEDA', '2004-04-12', 'F', 350.0),
('C008', 'JAIME BENAVIDEZ', '2005-04-12', 'F', 350.0),
('C009', 'LAURA GARCÍA', '2022-09-10', 'D', 200.0),
('C010', 'PEDRO SANCHEZ', '2023-02-28', 'E', 320.0),
('C011', 'ANA MARTINEZ', '2022-12-12', 'A', 150.0),
('C012', 'JAVIER PEREZ', '2023-01-03', 'B', 430.0),
('C013', 'ISABEL RODRIGUEZ', '2023-04-15', 'C', 1400.0),
('C014', 'MIGUEL TORRES', '2022-08-05', 'D', 900.0),
('C015', 'LUISA RODRIGUEZ', '2022-11-12', 'E', 750.0),
('C016', 'SERGIO GONZALES', '2023-03-18', 'A', 600.0),
('C017', 'ELENA PEREZ', '2023-02-09', 'B', 950.0),
('C018', 'ROSA MARTINEZ', '2023-01-20', 'C', 800.0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chofer2`
--

CREATE TABLE `chofer2` (
  `IDCOD` int(4) NOT NULL,
  `CHONOM` varchar(30) NOT NULL,
  `CHOFIN` varchar(15) NOT NULL,
  `CHOCAT` varchar(1) NOT NULL,
  `CHOSBA` decimal(8,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `chofer2`
--

INSERT INTO `chofer2` (`IDCOD`, `CHONOM`, `CHOFIN`, `CHOCAT`, `CHOSBA`) VALUES
(1, 'PABLO ALCAZAR', '2023-03-10', 'C', 450.0),
(2, 'JORGE QUISPE', '2001-04-07', 'C', 200.0),
(3, 'EDWARD TEMPLE', '2005-04-11', 'F', 450.0),
(4, 'CHRISTINA MELGAR', '1998-04-10', 'F', 550.0),
(5, 'MARCOS GARECA', '1995-04-12', 'F', 650.0),
(6, 'LUIS PRIETO', '1998-04-12', 'F', 350.0),
(7, 'MARIO CASTANEDA', '2004-04-12', 'F', 350.0),
(8, 'JAIME BENAVIDEZ', '2005-04-12', 'F', 350.0),
(9, 'LAURA GARCÍA', '2022-09-10', 'D', 200.0),
(10, 'PEDRO SANCHEZ', '2023-02-28', 'E', 320.0),
(11, 'ANA MARTINEZ', '2022-12-12', 'A', 150.0),
(12, 'JAVIER PEREZ', '2023-01-03', 'B', 430.0),
(13, 'ISABEL RODRIGUEZ', '2023-04-15', 'C', 1400.0),
(14, 'MIGUEL TORRES', '2022-08-05', 'D', 900.0),
(15, 'LUISA RODRIGUEZ', '2022-11-12', 'E', 750.0),
(16, 'SERGIO GONZALES', '2023-03-18', 'A', 600.0),
(17, 'ELENA PEREZ', '2023-02-09', 'B', 950.0),
(18, 'ROSA ALBERTA', '2023-01-20', 'C', 800.0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante`
--

CREATE TABLE `comprobante` (
  `BOL_NRO` char(6) NOT NULL,
  `VIA_NRO` char(6) NOT NULL,
  `Nom_pas` varchar(700) NOT NULL,
  `pago_total` decimal(8,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comprobante`
--

INSERT INTO `comprobante` (`BOL_NRO`, `VIA_NRO`, `Nom_pas`, `pago_total`) VALUES
('BOL001', '100001', 'Luis Haro', 35.0),
('BOL002', '100017', 'Luis Haro', 105.0),
('BOL003', '100017', 'Francisco Perez', 280.0),
('BOL004', '100014', 'Nilson Huancollo', 240.0),
('BOL005', '100009', 'Mathias Brivio', 336.0),
('BOL006', '100003', 'Pablo Villanueva', 200.0),
('BOL007', '100013', 'Carlos Miranda', 270.0),
('BOL008', '100020', 'Pedro Caceres', 567.0),
('BOL009', '100009', 'Paulina Rubio', 1050.0),
('BOL010', '100017', 'Jose Cayhualla', 217.0),
('BOL011', '100007', 'Manuel Alberto', 250.0),
('BOL012', '100005', 'Federico Quino', 330.0),
('BOL013', '100001', 'Paola Castillo', 532.0),
('BOL014', '100014', 'Polo Echevarria', 141.0),
('BOL015', '100014', 'Julio Maldonado', 420.0),
('BOL016', '100010', 'Jose Casillas', 175.0),
('BOL017', '100022', 'Mauricio Jimenez', 210.0),
('BOL018', '100004', 'Paolo Hurtado', 279.0),
('BOL019', '100011', 'Federico Musqueti', 520.0),
('BOL020', '100016', 'Xavier Hernandez', 770.0),
('BOL021', '100023', 'Luis Miranda', 240.0),
('BOL022', '100008', 'Carlos Morante', 720.0),
('BOL023', '100006', 'Alberto Caceres', 100.0),
('BOL024', '100012', 'Hugo Albertiz', 210.0),
('BOL025', '100002', 'Naomi Castillo', 720.0),
('BOL026', '100015', 'Carlos Quintana', 100.0),
('BOL027', '100018', 'Ramon Garcia', 480.0),
('BOL028', '100019', 'Tyler Rodriguez', 270.0),
('BOL029', '100021', 'Mateo Albitez', 270.0),
('BOL030', '100017', 'Pepe Parker', 154.0),
('BOL031', '100024', 'Mauricio Zegarra', 210.0),
('BOL032', '100025', 'Mauricio Jimenez', 280.0),
('BOL033', '100026', 'Polo Echevarria', 594.0),
('BOL034', '100027', 'Mateo Zegarra', 384.0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprobante_detalle`
--

CREATE TABLE `comprobante_detalle` (
  `indice` int(5) NOT NULL,
  `BOL_NRO` char(6) NOT NULL,
  `VIA_NRO` char(6) NOT NULL,
  `nro_asi` varchar(40) NOT NULL,
  `tipo` char(1) NOT NULL,
  `pago` decimal(8,1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comprobante_detalle`
--

INSERT INTO `comprobante_detalle` (`indice`, `BOL_NRO`, `VIA_NRO`, `nro_asi`, `tipo`, `pago`) VALUES
(1, 'BOL001', '100001', '1', 'A', 70.0),
(2, 'BOL002', '100017', '1', 'A', 70.0),
(3, 'BOL002', '100017', '2', 'N', 35.0),
(4, 'BOL003', '100017', '5', 'A', 70.0),
(5, 'BOL003', '100017', '6', 'A', 70.0),
(6, 'BOL003', '100017', '7', 'A', 70.0),
(7, 'BOL003', '100017', '8', 'N', 35.0),
(8, 'BOL003', '100017', '4', 'N', 35.0),
(9, 'BOL004', '100014', '1', 'A', 30.0),
(10, 'BOL004', '100014', '5', 'A', 30.0),
(11, 'BOL004', '100014', '2', 'A', 30.0),
(12, 'BOL004', '100014', '6', 'A', 30.0),
(13, 'BOL004', '100014', '3', 'A', 30.0),
(14, 'BOL004', '100014', '7', 'A', 30.0),
(15, 'BOL004', '100014', '4', 'A', 30.0),
(16, 'BOL004', '100014', '8', 'A', 30.0),
(17, 'BOL005', '100009', '1', 'E', 49.0),
(18, 'BOL005', '100009', '2', 'E', 49.0),
(19, 'BOL005', '100009', '3', 'E', 49.0),
(20, 'BOL005', '100009', '4', 'E', 49.0),
(21, 'BOL005', '100009', '5', 'A', 70.0),
(22, 'BOL005', '100009', '6', 'A', 70.0),
(23, 'BOL006', '100003', '13', 'A', 80.0),
(24, 'BOL006', '100003', '14', 'N', 40.0),
(25, 'BOL006', '100003', '17', 'N', 40.0),
(26, 'BOL006', '100003', '18', 'N', 40.0),
(27, 'BOL007', '100013', '19', 'A', 90.0),
(28, 'BOL007', '100013', '20', 'A', 90.0),
(29, 'BOL007', '100013', '18', 'A', 90.0),
(30, 'BOL008', '100020', '1', 'E', 49.0),
(31, 'BOL008', '100020', '2', 'E', 49.0),
(32, 'BOL008', '100020', '5', 'E', 49.0),
(33, 'BOL008', '100020', '6', 'A', 70.0),
(34, 'BOL008', '100020', '9', 'A', 70.0),
(35, 'BOL008', '100020', '10', 'A', 70.0),
(36, 'BOL008', '100020', '13', 'A', 70.0),
(37, 'BOL008', '100020', '14', 'A', 70.0),
(38, 'BOL008', '100020', '17', 'N', 35.0),
(39, 'BOL008', '100020', '18', 'N', 35.0),
(40, 'BOL009', '100009', '9', 'E', 49.0),
(41, 'BOL009', '100009', '10', 'E', 49.0),
(42, 'BOL009', '100009', '13', 'E', 49.0),
(43, 'BOL009', '100009', '14', 'E', 49.0),
(44, 'BOL009', '100009', '17', 'E', 49.0),
(45, 'BOL009', '100009', '18', 'A', 70.0),
(46, 'BOL009', '100009', '21', 'A', 70.0),
(47, 'BOL009', '100009', '22', 'A', 70.0),
(48, 'BOL009', '100009', '25', 'A', 70.0),
(49, 'BOL009', '100009', '26', 'A', 70.0),
(50, 'BOL009', '100009', '11', 'A', 70.0),
(51, 'BOL009', '100009', '12', 'A', 70.0),
(52, 'BOL009', '100009', '15', 'A', 70.0),
(53, 'BOL009', '100009', '16', 'A', 70.0),
(54, 'BOL009', '100009', '19', 'A', 70.0),
(55, 'BOL009', '100009', '20', 'N', 35.0),
(56, 'BOL009', '100009', '23', 'N', 35.0),
(57, 'BOL009', '100009', '24', 'N', 35.0),
(58, 'BOL010', '100017', '13', 'E', 49.0),
(59, 'BOL010', '100017', '14', 'E', 49.0),
(60, 'BOL010', '100017', '15', 'E', 49.0),
(61, 'BOL010', '100017', '16', 'A', 70.0),
(62, 'BOL011', '100007', '1', 'A', 50.0),
(63, 'BOL011', '100007', '2', 'A', 50.0),
(64, 'BOL011', '100007', '3', 'A', 50.0),
(65, 'BOL011', '100007', '4', 'A', 50.0),
(66, 'BOL011', '100007', '5', 'A', 50.0),
(67, 'BOL012', '100005', '13', 'A', 60.0),
(68, 'BOL012', '100005', '14', 'A', 60.0),
(69, 'BOL012', '100005', '15', 'A', 60.0),
(70, 'BOL012', '100005', '16', 'A', 60.0),
(71, 'BOL012', '100005', '17', 'N', 30.0),
(72, 'BOL012', '100005', '18', 'N', 30.0),
(73, 'BOL012', '100005', '19', 'N', 30.0),
(74, 'BOL013', '100001', '29', 'E', 49.0),
(75, 'BOL013', '100001', '30', 'E', 49.0),
(76, 'BOL013', '100001', '25', 'E', 49.0),
(77, 'BOL013', '100001', '26', 'E', 49.0),
(78, 'BOL013', '100001', '31', 'E', 49.0),
(79, 'BOL013', '100001', '32', 'E', 49.0),
(80, 'BOL013', '100001', '27', 'E', 49.0),
(81, 'BOL013', '100001', '28', 'E', 49.0),
(82, 'BOL013', '100001', '21', 'A', 70.0),
(83, 'BOL013', '100001', '22', 'A', 70.0),
(84, 'BOL014', '100014', '21', 'E', 21.0),
(85, 'BOL014', '100014', '22', 'A', 30.0),
(86, 'BOL014', '100014', '26', 'A', 30.0),
(87, 'BOL014', '100014', '25', 'A', 30.0),
(88, 'BOL014', '100014', '29', 'N', 15.0),
(89, 'BOL014', '100014', '30', 'N', 15.0),
(90, 'BOL015', '100014', '9', 'A', 30.0),
(91, 'BOL015', '100014', '10', 'A', 30.0),
(92, 'BOL015', '100014', '13', 'A', 30.0),
(93, 'BOL015', '100014', '14', 'A', 30.0),
(94, 'BOL015', '100014', '17', 'A', 30.0),
(95, 'BOL015', '100014', '18', 'A', 30.0),
(96, 'BOL015', '100014', '11', 'A', 30.0),
(97, 'BOL015', '100014', '12', 'A', 30.0),
(98, 'BOL015', '100014', '15', 'A', 30.0),
(99, 'BOL015', '100014', '16', 'A', 30.0),
(100, 'BOL015', '100014', '19', 'N', 15.0),
(101, 'BOL015', '100014', '20', 'N', 15.0),
(102, 'BOL015', '100014', '23', 'N', 15.0),
(103, 'BOL015', '100014', '24', 'N', 15.0),
(104, 'BOL015', '100014', '27', 'N', 15.0),
(105, 'BOL015', '100014', '28', 'N', 15.0),
(106, 'BOL015', '100014', '31', 'N', 15.0),
(107, 'BOL015', '100014', '32', 'N', 15.0),
(112, 'BOL016', '100010', '1', 'A', 70.0),
(113, 'BOL016', '100010', '2', 'A', 70.0),
(114, 'BOL016', '100010', '3', 'N', 35.0),
(115, 'BOL017', '100022', '1', 'A', 70.0),
(116, 'BOL017', '100022', '2', 'A', 70.0),
(117, 'BOL017', '100022', '3', 'N', 35.0),
(118, 'BOL017', '100022', '4', 'N', 35.0),
(119, 'BOL018', '100004', '1', 'E', 63.0),
(120, 'BOL018', '100004', '2', 'E', 63.0),
(121, 'BOL018', '100004', '5', 'E', 63.0),
(122, 'BOL018', '100004', '6', 'A', 90.0),
(123, 'BOL019', '100011', '1', 'A', 80.0),
(124, 'BOL019', '100011', '2', 'A', 80.0),
(125, 'BOL019', '100011', '3', 'A', 80.0),
(126, 'BOL019', '100011', '4', 'A', 80.0),
(127, 'BOL019', '100011', '5', 'N', 40.0),
(128, 'BOL019', '100011', '6', 'N', 40.0),
(129, 'BOL019', '100011', '7', 'N', 40.0),
(130, 'BOL019', '100011', '8', 'N', 40.0),
(131, 'BOL019', '100011', '9', 'N', 40.0),
(132, 'BOL020', '100016', '13', 'A', 70.0),
(133, 'BOL020', '100016', '14', 'A', 70.0),
(134, 'BOL020', '100016', '15', 'A', 70.0),
(135, 'BOL020', '100016', '16', 'A', 70.0),
(136, 'BOL020', '100016', '17', 'A', 70.0),
(137, 'BOL020', '100016', '18', 'A', 70.0),
(138, 'BOL020', '100016', '19', 'A', 70.0),
(139, 'BOL020', '100016', '20', 'A', 70.0),
(140, 'BOL020', '100016', '21', 'A', 70.0),
(141, 'BOL020', '100016', '22', 'A', 70.0),
(142, 'BOL020', '100016', '23', 'N', 35.0),
(143, 'BOL020', '100016', '24', 'N', 35.0),
(144, 'BOL021', '100023', '13', 'A', 60.0),
(145, 'BOL021', '100023', '14', 'A', 60.0),
(146, 'BOL021', '100023', '17', 'A', 60.0),
(147, 'BOL021', '100023', '18', 'A', 60.0),
(148, 'BOL022', '100008', '1', 'A', 60.0),
(149, 'BOL022', '100008', '5', 'A', 60.0),
(150, 'BOL022', '100008', '9', 'A', 60.0),
(151, 'BOL022', '100008', '13', 'A', 60.0),
(152, 'BOL022', '100008', '17', 'A', 60.0),
(153, 'BOL022', '100008', '21', 'A', 60.0),
(154, 'BOL022', '100008', '25', 'A', 60.0),
(155, 'BOL022', '100008', '29', 'A', 60.0),
(156, 'BOL022', '100008', '2', 'N', 30.0),
(157, 'BOL022', '100008', '6', 'N', 30.0),
(158, 'BOL022', '100008', '10', 'N', 30.0),
(159, 'BOL022', '100008', '14', 'N', 30.0),
(160, 'BOL022', '100008', '18', 'N', 30.0),
(161, 'BOL022', '100008', '22', 'N', 30.0),
(162, 'BOL022', '100008', '26', 'N', 30.0),
(163, 'BOL022', '100008', '30', 'N', 30.0),
(164, 'BOL023', '100006', '9', 'A', 50.0),
(165, 'BOL023', '100006', '10', 'A', 50.0),
(166, 'BOL024', '100012', '5', 'A', 70.0),
(167, 'BOL024', '100012', '6', 'A', 70.0),
(168, 'BOL024', '100012', '7', 'A', 70.0),
(169, 'BOL025', '100002', '1', 'E', 42.0),
(170, 'BOL025', '100002', '2', 'E', 42.0),
(171, 'BOL025', '100002', '3', 'E', 42.0),
(172, 'BOL025', '100002', '4', 'E', 42.0),
(173, 'BOL025', '100002', '5', 'E', 42.0),
(174, 'BOL025', '100002', '6', 'E', 42.0),
(175, 'BOL025', '100002', '7', 'E', 42.0),
(176, 'BOL025', '100002', '8', 'E', 42.0),
(177, 'BOL025', '100002', '9', 'E', 42.0),
(178, 'BOL025', '100002', '10', 'E', 42.0),
(179, 'BOL025', '100002', '11', 'A', 60.0),
(180, 'BOL025', '100002', '12', 'A', 60.0),
(181, 'BOL025', '100002', '13', 'A', 60.0),
(182, 'BOL025', '100002', '14', 'A', 60.0),
(183, 'BOL025', '100002', '15', 'A', 60.0),
(184, 'BOL026', '100015', '29', 'A', 40.0),
(185, 'BOL026', '100015', '30', 'A', 40.0),
(186, 'BOL026', '100015', '31', 'N', 20.0),
(187, 'BOL027', '100018', '1', 'E', 42.0),
(188, 'BOL027', '100018', '2', 'E', 42.0),
(189, 'BOL027', '100018', '5', 'E', 42.0),
(190, 'BOL027', '100018', '6', 'E', 42.0),
(191, 'BOL027', '100018', '9', 'E', 42.0),
(192, 'BOL027', '100018', '10', 'E', 42.0),
(193, 'BOL027', '100018', '13', 'E', 42.0),
(194, 'BOL027', '100018', '14', 'E', 42.0),
(195, 'BOL027', '100018', '18', 'E', 42.0),
(196, 'BOL027', '100018', '17', 'E', 42.0),
(197, 'BOL027', '100018', '21', 'A', 60.0),
(198, 'BOL028', '100019', '1', 'E', 42.0),
(199, 'BOL028', '100019', '2', 'E', 42.0),
(200, 'BOL028', '100019', '3', 'E', 42.0),
(201, 'BOL028', '100019', '4', 'E', 42.0),
(202, 'BOL028', '100019', '5', 'E', 42.0),
(203, 'BOL028', '100019', '6', 'A', 60.0),
(204, 'BOL029', '100021', '1', 'A', 60.0),
(205, 'BOL029', '100021', '2', 'A', 60.0),
(206, 'BOL029', '100021', '5', 'A', 60.0),
(207, 'BOL029', '100021', '6', 'A', 60.0),
(208, 'BOL029', '100021', '9', 'N', 30.0),
(209, 'BOL030', '100017', '21', 'E', 49.0),
(210, 'BOL030', '100017', '17', 'A', 70.0),
(211, 'BOL030', '100017', '18', 'N', 35.0),
(212, 'BOL031', '100024', '5', 'A', 70.0),
(213, 'BOL031', '100024', '6', 'A', 70.0),
(214, 'BOL031', '100024', '9', 'A', 70.0),
(215, 'BOL032', '100025', '1', 'A', 70.0),
(216, 'BOL032', '100025', '2', 'A', 70.0),
(217, 'BOL032', '100025', '3', 'A', 70.0),
(218, 'BOL032', '100025', '4', 'A', 70.0),
(219, 'BOL033', '100026', '1', 'E', 63.0),
(220, 'BOL033', '100026', '2', 'E', 63.0),
(221, 'BOL033', '100026', '5', 'E', 63.0),
(222, 'BOL033', '100026', '6', 'E', 63.0),
(223, 'BOL033', '100026', '9', 'E', 63.0),
(224, 'BOL033', '100026', '10', 'E', 63.0),
(225, 'BOL033', '100026', '13', 'E', 63.0),
(226, 'BOL033', '100026', '14', 'E', 63.0),
(227, 'BOL033', '100026', '3', 'A', 90.0),
(228, 'BOL034', '100027', '6', 'E', 42.0),
(229, 'BOL034', '100027', '7', 'E', 42.0),
(230, 'BOL034', '100027', '10', 'A', 60.0),
(231, 'BOL034', '100027', '11', 'A', 60.0),
(232, 'BOL034', '100027', '5', 'A', 60.0),
(233, 'BOL034', '100027', '9', 'A', 60.0),
(234, 'BOL034', '100027', '8', 'N', 30.0),
(235, 'BOL034', '100027', '12', 'N', 30.0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `incidencia`
--

CREATE TABLE `incidencia` (
  `cod_incidencia` char(6) NOT NULL,
  `descripcion` varchar(800) NOT NULL,
  `fecha` varchar(15) NOT NULL,
  `via_nro` char(6) NOT NULL,
  `id_usuario` char(6) NOT NULL,
  `id_chofer` char(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `incidencia`
--

INSERT INTO `incidencia` (`cod_incidencia`, `descripcion`, `fecha`, `via_nro`, `id_usuario`, `id_chofer`) VALUES
('INC001', 'Hubo un retraso debido a trafico de 1 hora.', '2023-11-22', '100007', 'USU006', 'C001'),
('INC002', 'Se pincho la llanta en la carretera, hubo una demora de 2 horas.', '2023-11-14', '100006', 'USU006', 'C002'),
('INC003', 'Manifestaciones hicieron demorar la llegada al destino en 3 horas.', '2023-11-18', '100015', 'USU005', 'C007');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reclamaciones`
--

CREATE TABLE `reclamaciones` (
  `cod_reclamo` char(6) NOT NULL,
  `descripcion` varchar(800) NOT NULL,
  `fecha` varchar(15) NOT NULL,
  `id_usuario` char(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reclamaciones`
--

INSERT INTO `reclamaciones` (`cod_reclamo`, `descripcion`, `fecha`, `id_usuario`) VALUES
('RC0001', 'No funciona el wifi en el bus.', '2023-11-18', 'USU005'),
('RC0002', 'No funcionaba la calefacción en el bus.', '2023-11-1', 'USU006'),
('RC0003', 'Se pincho una llanta antes de salir de la terminal, no puede pasar eso, llegue tarde a mi destino.', '2023-11-17', 'USU004'),
('RC0004', 'La señal de cable no funcionaba bien.', '2023-11-16', 'USU002');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ruta`
--

CREATE TABLE `ruta` (
  `RUTCOD` varchar(4) NOT NULL,
  `RUTNOM` varchar(20) DEFAULT NULL,
  `pago_cho` decimal(8,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ruta`
--

INSERT INTO `ruta` (`RUTCOD`, `RUTNOM`, `pago_cho`) VALUES
('LMAR', 'AREQUIPA', 35.0),
('LMAY', 'AYACUCHO', 170.0),
('LMCH', 'CHICLAYO', 80.0),
('LMCZ', 'CUZCO', 50.0),
('LMHA', 'HUANCAVELICA', 200.0),
('LMHC', 'HUANUCO', 120.0),
('LMHZ', 'HUARAZ', 70.0),
('LMIC', 'ICA', 50.0),
('LMTA', 'TACNA', 300.0),
('LMTR', 'TRUJILLO', 15.0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` char(6) NOT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `tipo_usuario` varchar(1) NOT NULL,
  `usuario` varchar(30) NOT NULL,
  `clave` char(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `nombre`, `apellido`, `tipo_usuario`, `usuario`, `clave`) VALUES
('USU001', 'Luis Angel', 'Haro Garcia', 'E', 'luis', '$2a$10$uS0YxroohWDq5u2.sQN1de.GmXcgtpRcilnqRkd9TETJ6UG0UpF1a'),
('USU002', 'Zegarra Ramos', 'Mateo Sthepano', 'E', 'matthew', '$2a$10$U4cZ33.XQ5v3s8Kn6VEmw.DuQjfQuJKjT0L4Sf56AvsfILwXr7M0K'),
('USU003', 'Cayhualla Lopez', 'Jose Carlos', 'E', 'jose', '$2a$10$uzvbNw5kNLk1RMElMP08B.mTkteDkab4ZfDDL62wq7PUoxVhlmJYa'),
('USU004', 'Renato', 'Medina Ortega', 'E', 'renato', '$2a$10$n7XSEFx5kM/LeaKpwoPS4.hlaeqWk2gPoGdCcDuLgk5FUjAqQGsRe'),
('USU005', 'Pablo ', 'Villanueva', 'E', 'pablov12', '$2a$10$eXcPruQ8wgfABWOOqNybtOJQ13gJuCxhWXeZ2c/cWAGwg1ZFPlJyO'),
('USU006', 'Lopez', 'Marin', 'E', 'marin12', '$2a$10$zPJQAR2.YdHBeGzzf67tIeEWL/xkdtJKSFPtBKkdeWpdf04vbBc/2');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `viaje`
--

CREATE TABLE `viaje` (
  `VIANRO` char(6) NOT NULL,
  `BUSNRO` decimal(2,0) DEFAULT NULL,
  `RUTCOD` varchar(4) DEFAULT NULL,
  `IDCOD` char(4) DEFAULT NULL,
  `VIAHRS` char(6) DEFAULT NULL,
  `VIAFCH` varchar(15) DEFAULT NULL,
  `COSVIA` decimal(8,1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `viaje`
--

INSERT INTO `viaje` (`VIANRO`, `BUSNRO`, `RUTCOD`, `IDCOD`, `VIAHRS`, `VIAFCH`, `COSVIA`) VALUES
('100001', 1, 'LMTA', 'C001', '10:30', '2023-10-15', 70.0),
('100002', 2, 'LMTA', 'C002', '09:30', '2023-10-15', 60.0),
('100003', 3, 'LMCZ', 'C003', '11:30', '2023-10-15', 80.0),
('100004', 2, 'LMCZ', 'C002', '08:00', '2023-10-10', 90.0),
('100005', 1, 'LMIC', 'C007', '13:30', '2023-09-10', 60.0),
('100006', 4, 'LMIC', 'C003', '15:00', '2023-10-16', 50.0),
('100007', 5, 'LMHZ', 'C002', '21:30', '2023-10-16', 50.0),
('100008', 1, 'LMHZ', 'C001', '12:30', '2023-10-14', 60.0),
('100009', 3, 'LMCH', 'C004', '18:30', '2023-10-14', 70.0),
('100010', 4, 'LMTR', 'C003', '19:00', '2023-10-10', 70.0),
('100011', 2, 'LMCZ', 'C005', '19:40', '2023-10-08', 80.0),
('100012', 3, 'LMIC', 'C003', '17:00', '2023-10-08', 70.0),
('100013', 3, 'LMHA', 'C002', '18:40', '2023-10-07', 90.0),
('100014', 4, 'LMAY', 'C003', '19:00', '2023-10-07', 30.0),
('100015', 1, 'LMTA', 'C002', '19:00', '2023-10-07', 40.0),
('100016', 1, 'LMCZ', 'C001', '17:00', '2023-10-06', 70.0),
('100017', 4, 'LMAR', 'C002', '19:00', '2023-10-06', 70.0),
('100018', 2, 'LMTR', 'C005', '15:00', '2023-10-06', 60.0),
('100019', 3, 'LMTR', 'C004', '18:30', '2021-04-19', 60.0),
('100020', 4, 'LMAY', 'C005', '19:00', '2021-04-18', 70.0),
('100021', 3, 'LMTR', 'C007', '19:00', '2021-04-19', 60.0),
('100022', 4, 'LMAY', 'C007', '19:00', '2021-04-19', 70.0),
('100023', 1, 'LMHC', 'C007', '14:00', '2023-11-24', 60.0),
('100024', 1, 'LMAR', 'C008', '13:00', '2023-12-02', 70.0),
('100025', 2, 'LMCH', 'C009', '15:00', '2023-11-28', 70.0),
('100026', 3, 'LMHA', 'C010', '15:00', '2023-11-26', 90.0),
('100027', 4, 'LMHC', 'C011', '13:00', '2023-11-22', 60.0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `bus`
--
ALTER TABLE `bus`
  ADD PRIMARY KEY (`BUSNRO`);

--
-- Indices de la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD PRIMARY KEY (`id_calificacion`),
  ADD KEY `Nom_pas` (`id_usuario`),
  ADD KEY `ViaNro` (`ViaNro`);

--
-- Indices de la tabla `chofer`
--
ALTER TABLE `chofer`
  ADD PRIMARY KEY (`IDCOD`);

--
-- Indices de la tabla `chofer2`
--
ALTER TABLE `chofer2`
  ADD PRIMARY KEY (`IDCOD`);

--
-- Indices de la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD PRIMARY KEY (`BOL_NRO`),
  ADD KEY `VIA_NRO` (`VIA_NRO`);

--
-- Indices de la tabla `comprobante_detalle`
--
ALTER TABLE `comprobante_detalle`
  ADD PRIMARY KEY (`indice`),
  ADD KEY `VIA_NRO` (`VIA_NRO`);

--
-- Indices de la tabla `incidencia`
--
ALTER TABLE `incidencia`
  ADD PRIMARY KEY (`cod_incidencia`),
  ADD KEY `via_nro` (`via_nro`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_chofer` (`id_chofer`);

--
-- Indices de la tabla `reclamaciones`
--
ALTER TABLE `reclamaciones`
  ADD PRIMARY KEY (`cod_reclamo`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `ruta`
--
ALTER TABLE `ruta`
  ADD PRIMARY KEY (`RUTCOD`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD PRIMARY KEY (`VIANRO`),
  ADD KEY `IDCOD` (`IDCOD`),
  ADD KEY `BUSNRO` (`BUSNRO`),
  ADD KEY `RUTCOD` (`RUTCOD`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `chofer2`
--
ALTER TABLE `chofer2`
  MODIFY `IDCOD` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `comprobante_detalle`
--
ALTER TABLE `comprobante_detalle`
  MODIFY `indice` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=236;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `calificaciones`
--
ALTER TABLE `calificaciones`
  ADD CONSTRAINT `calificaciones_ibfk_1` FOREIGN KEY (`ViaNro`) REFERENCES `viaje` (`VIANRO`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `calificaciones_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `comprobante`
--
ALTER TABLE `comprobante`
  ADD CONSTRAINT `comprobante_ibfk_1` FOREIGN KEY (`VIA_NRO`) REFERENCES `viaje` (`VIANRO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `comprobante_detalle`
--
ALTER TABLE `comprobante_detalle`
  ADD CONSTRAINT `comprobante_detalle_ibfk_2` FOREIGN KEY (`VIA_NRO`) REFERENCES `viaje` (`VIANRO`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `incidencia`
--
ALTER TABLE `incidencia`
  ADD CONSTRAINT `incidencia_ibfk_1` FOREIGN KEY (`via_nro`) REFERENCES `viaje` (`VIANRO`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `incidencia_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `incidencia_ibfk_3` FOREIGN KEY (`id_chofer`) REFERENCES `chofer` (`IDCOD`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `reclamaciones`
--
ALTER TABLE `reclamaciones`
  ADD CONSTRAINT `reclamaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `viaje`
--
ALTER TABLE `viaje`
  ADD CONSTRAINT `viaje_ibfk_1` FOREIGN KEY (`IDCOD`) REFERENCES `chofer` (`IDCOD`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `viaje_ibfk_2` FOREIGN KEY (`BUSNRO`) REFERENCES `bus` (`BUSNRO`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `viaje_ibfk_3` FOREIGN KEY (`RUTCOD`) REFERENCES `ruta` (`RUTCOD`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
