-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 29-04-2026 a las 02:52:07
-- Versión del servidor: 9.1.0
-- Versión de PHP: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `empresa_ropa`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

DROP TABLE IF EXISTS `clientes`;
CREATE TABLE IF NOT EXISTS `clientes` (
  `id_cliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id_cliente`, `nombre`, `telefono`, `direccion`) VALUES
(1, 'Juan Pérez', '3001234567', 'Calle 10 # 5-20'),
(8, 'duvan ', '3102417014', '153b 73 c bogota'),
(9, 'edder', '3122134282828', 'asngqol'),
(10, 'edder', '3122134282828', 'asngqol'),
(11, 'edder', '3122134282828', 'asngqol'),
(12, 'edder', '3122134282828', 'asngqol'),
(13, 'edder', '3122134282828', 'asngqol'),
(14, 'edder', '3122134282828', 'asngqol'),
(15, 'edder', '3122134282828', 'asngqol'),
(16, 'edder', '3122134282828', 'asngqol'),
(17, 'edder', '3122134282828', 'asngqol'),
(18, 'edder', '3122134282828', 'asngqol'),
(19, 'edder', '3122134282828', 'asngqol'),
(20, 'aura', '31010101', 'calle54'),
(21, 'hola', '23456', 'q456y'),
(22, 'edder', '1234', 'cale'),
(23, 'edder', '1234', 'cale'),
(24, 'jose', '23456789o0', 'calle'),
(25, 'logan', '34567890', 'calle jukianala´pa+\'\''),
(26, 'jose', '4567890', 'calle'),
(27, 'jose', '12345678', 'calle'),
(28, 'luaura', '23456789', 'calle 12 x'),
(29, 'eder', '77162', 'calle'),
(30, 'eder', '123456789', 'caleee'),
(31, 'edder', '12345678', 'calle'),
(32, 'edder', '234567890', 'cale rodufues'),
(33, 'NESTOR', '234567890', 'CLAE 4 -78192'),
(34, 'SARA', '3456789', 'CALLE'),
(35, 'José Rodriguez', '30056199282', 'calle 2 casa 1 localidad suba Bogotá'),
(36, 'sara', '300561992672', 'calle 13 casa 123  localidad bosa Bogotá'),
(37, 'daniel', '3005619926', 'calle 13 casa 123  localidad bosa Bogotá'),
(38, 'juan duarte', '300565678', 'bogota calle 123- 47-22'),
(39, 'eder yadir duarte', '3456789', 'calle 12'),
(40, 'eder yadir duarte', '3456789', 'calle 12'),
(41, 'eder yadir duarte', '3456789', 'calle 12');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `detalle_ventas`
--

DROP TABLE IF EXISTS `detalle_ventas`;
CREATE TABLE IF NOT EXISTS `detalle_ventas` (
  `id_detalle` int NOT NULL AUTO_INCREMENT,
  `id_venta` int NOT NULL,
  `id_producto` int NOT NULL,
  `cantidad` int NOT NULL,
  `precio_unitario` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detalle`),
  KEY `id_venta` (`id_venta`),
  KEY `id_producto` (`id_producto`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE IF NOT EXISTS `productos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `precio` int DEFAULT NULL,
  `imagen` text COLLATE utf8mb3_spanish2_ci,
  `categoria` varchar(50) COLLATE utf8mb3_spanish2_ci DEFAULT NULL,
  `descripcion` text CHARACTER SET utf8mb3 COLLATE utf8mb3_spanish2_ci,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_spanish2_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `precio`, `imagen`, `categoria`, `descripcion`) VALUES
(20, 'camisa', 40000, 'https://johnpaolo.com.co/wp-content/uploads/2023/08/050670DELROJO.jpg', 'camisa', 'roja talla L, XL,XXL'),
(19, 'camiseta', 19999, 'https://marinaracewear.com/storage/media/attributes/9/0/8/6/6/90866/2.png', 'camiseta', 'producto'),
(21, 'BUSO', 55000, 'https://tse3.mm.bing.net/th/id/OIP.66QOEvrAPVWouu9OTNr21gHaIJ?pid=Api&P=0&h=180', 'BUSO', 'BUSO ROJO TALLA, XL,L'),
(22, 'BUSO', 80000, 'https://www.moov.com.ar/on/demandware.static/-/Sites-365-dabra-catalog/default/dw6806dbac/products/NIDQ5836-010/NIDQ5836-010-2.JPG', 'BUSO', 'DEPORTIVO'),
(23, 'camista blanca', 50000, 'https://camisetascopyone.com/wp-content/uploads/2019/12/front-1536x1536.jpg', 'camiseta', 'disponibilidad talla L');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE IF NOT EXISTS `ventas` (
  `id_venta` int NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `id_cliente` int DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id_venta`),
  KEY `id_cliente` (`id_cliente`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
