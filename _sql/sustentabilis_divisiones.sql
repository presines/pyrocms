# Sequel Pro dump
# Version 2492
# http://code.google.com/p/sequel-pro
#
# Host: 127.0.0.1 (MySQL 5.1.37)
# Database: sustentabilis
# Generation Time: 2011-05-11 02:44:09 -0500
# ************************************************************

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table divisiones
# ------------------------------------------------------------

DROP TABLE IF EXISTS `divisiones`;

CREATE TABLE `divisiones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `title` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `thumbnail` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `header_image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `description` text CHARACTER SET latin1,
  `status` enum('draft','live') CHARACTER SET latin1 NOT NULL DEFAULT 'draft',
  `position` int(5) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

LOCK TABLES `divisiones` WRITE;
/*!40000 ALTER TABLE `divisiones` DISABLE KEYS */;
INSERT INTO `divisiones` (`id`,`slug`,`title`,`thumbnail`,`header_image`,`description`,`status`,`position`)
VALUES
	(1,'agua','División Agua','divagua.jpg','agua.jpg','<img src=\"/addons/themes/sustentabilis/miraambiental.png\">\n              <hr>\n<p>\n				<strong>NOTAS IMPORTANTES</strong></p>\n			<ul>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n				<li>\n					Lorem ipsum dolor sit amet, consectu</li>\n			</ul>\n			<p>\n				&nbsp;</p>','live',1),
	(2,'aire','División Aire','divaire.jpg',NULL,NULL,'live',2),
	(3,'energia','División Energía','divenergia.jpg',NULL,NULL,'live',3);

/*!40000 ALTER TABLE `divisiones` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table divisiones_categorias
# ------------------------------------------------------------

DROP TABLE IF EXISTS `divisiones_categorias`;

CREATE TABLE `divisiones_categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `title` varchar(100) CHARACTER SET latin1 NOT NULL DEFAULT '',
  `division_id` int(11) NOT NULL,
  `category_type` enum('product','industry') CHARACTER SET latin1 NOT NULL DEFAULT 'product',
  `parent_id` int(11) DEFAULT NULL,
  `thumbnail` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `header_image` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `description` text CHARACTER SET latin1,
  `status` enum('draft','live') CHARACTER SET latin1 NOT NULL DEFAULT 'draft',
  `position` int(5) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table divisiones_productos
# ------------------------------------------------------------

DROP TABLE IF EXISTS `divisiones_productos`;

CREATE TABLE `divisiones_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(100) CHARACTER SET latin1 NOT NULL,
  `title` varchar(100) CHARACTER SET latin1 NOT NULL,
  `intro` text CHARACTER SET latin1,
  `body` text CHARACTER SET latin1,
  `status` enum('draft','live') CHARACTER SET latin1 DEFAULT 'draft',
  `position` int(5) NOT NULL DEFAULT '999',
  `created_on` int(11) NOT NULL DEFAULT '0',
  `updated_on` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table divisiones_productos_categorias
# ------------------------------------------------------------

DROP TABLE IF EXISTS `divisiones_productos_categorias`;

CREATE TABLE `divisiones_productos_categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `categoria_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`),
  KEY `categoria_id` (`categoria_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



# Dump of table divisiones_productos_imagenes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `divisiones_productos_imagenes`;

CREATE TABLE `divisiones_productos_imagenes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `producto_id` int(11) NOT NULL,
  `filename` varchar(255) CHARACTER SET latin1 NOT NULL,
  `title` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `position` int(5) NOT NULL DEFAULT '999',
  PRIMARY KEY (`id`),
  KEY `producto_id` (`producto_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;






/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
