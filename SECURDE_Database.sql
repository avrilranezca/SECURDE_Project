CREATE DATABASE  IF NOT EXISTS `securde_eshopping` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `securde_eshopping`;
-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: securde_eshopping
-- ------------------------------------------------------
-- Server version	5.7.11-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `house_no` varchar(45) NOT NULL,
  `street` varchar(255) NOT NULL,
  `subdivision` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `postal_code` varchar(45) NOT NULL,
  `country` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'1','street1','subdivision1','city1','1','country1'),(2,'1','shippingstreet1','shippingsubdivision1','shippingcity1','shipping1','shippingcountry1');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'boots'),(2,'shoes'),(3,'sandals'),(4,'slippers');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` double NOT NULL,
  `category_id` int(11) unsigned NOT NULL,
  `isActive` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `category_id_FK_idx` (`category_id`),
  CONSTRAINT `p_category_id_FK` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'yo','boot1des',1,1,0),(2,'shoe2','shoe1des',1.23,2,1),(3,'boot2','boot2des',2.34,1,1),(4,'boot3','boot3des',7,1,1),(5,'slipper1','slipper1des',2.97,4,1),(6,'slipper2','slipper2des',1.23,4,1),(7,'sandal1','sandal1des',45.9,3,1),(8,'sandal2','sandal2des',13.9,3,1);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned DEFAULT NULL,
  `user_name` varchar(255) NOT NULL,
  `product_id` int(11) unsigned NOT NULL,
  `review` text NOT NULL,
  `date` datetime NOT NULL,
  `rating` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `review_FK_idx` (`user_id`),
  KEY `product_id_FK_idx` (`product_id`),
  CONSTRAINT `r_product_id_FK` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `r_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,'user_1',1,'review of 1 of 1','2016-07-27 00:00:00',4),(2,1,'user_1',1,'review of 1 of 1','2016-07-27 23:06:48',4),(3,1,'user_1',2,'hi','2016-08-04 13:00:26',3),(4,1,'user_1',2,'hi','2016-08-04 13:00:34',2),(5,1,'user_1',1,'hi','2016-08-04 13:00:43',1),(6,2,'user_2',2,'my review 2-2','2016-08-04 22:42:01',3);
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction`
--

DROP TABLE IF EXISTS `transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id_FK_idx` (`user_id`),
  CONSTRAINT `t_user_id_FK` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,'2016-07-31 19:16:14'),(2,1,'2016-07-31 19:16:28'),(4,1,'2016-08-01 13:54:56'),(9,2,'2016-08-01 13:58:21');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transaction_entry`
--

DROP TABLE IF EXISTS `transaction_entry`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transaction_entry` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `transaction_id` int(11) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `product_id_FK_idx` (`product_id`),
  KEY `transaction_id_FK_idx` (`transaction_id`),
  CONSTRAINT `te_product_id_FK` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `te_transaction_id_FK` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_entry`
--

LOCK TABLES `transaction_entry` WRITE;
/*!40000 ALTER TABLE `transaction_entry` DISABLE KEYS */;
INSERT INTO `transaction_entry` VALUES (1,1,2,1,1),(2,2,3,1.23,1),(3,3,1,2.34,1),(4,1,2,1,2),(5,2,3,1.23,2),(6,3,1,2.34,2),(10,1,2,1,4),(11,2,3,1.23,4),(12,3,1,2.34,4),(25,1,2,1,9),(26,2,3,1.23,9),(27,3,1,2.34,9);
/*!40000 ALTER TABLE `transaction_entry` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `middle_initial` varchar(5) NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `password_permanent` tinyint(1) NOT NULL,
  `email` varchar(255) NOT NULL,
  `billing_address_id` int(11) unsigned DEFAULT NULL,
  `shipping_address_id` int(11) unsigned DEFAULT NULL,
  `account_type_enum` varchar(255) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `log_in_attempts` int(11) DEFAULT '0',
  `lockout_datetime` datetime DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_address_FK_idx` (`billing_address_id`),
  KEY `shipping_address_FK_idx` (`shipping_address_id`),
  CONSTRAINT `u_billing_address_FK` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `u_shipping_address_FK` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1','user1','u','user_1','$2a$12$BTEF7l8BayUpKgb2HweApuZ7jeXeLE8zdbP0KKcY3euK63ykZdmhy',1,'user1@securde.com',1,2,'CUSTOMER',1,'newSessionID',0,NULL,'2016-08-10 13:22:07'),(2,'user2','user2','u','user_2','$2a$12$Ml1gCI0.4VvVsRIZVSPxIeqUeqiaHk0Q3.v2ytOw3ZqnAJRELnh.q',1,'user2@securde.com',NULL,NULL,'CUSTOMER',1,NULL,0,NULL,NULL),(3,'user3','user3','u','user_3','$2a$12$WRgiH.W2FyIHyJy9YZBYjO4V4aZ4zYzgREQ9WFolVm03miLOxix2e',0,'user3@securde.com',NULL,NULL,'CUSTOMER',1,NULL,0,NULL,NULL),(4,'user4','user4','u','user_4','$2a$12$QO5/oO/MBqCpbVQleJiLkeJEmutm8YpZtgM2rWL9.ln6H0KcbxOuO',1,'user4@securde.com',NULL,NULL,'CUSTOMER',1,NULL,0,NULL,NULL),(5,'user5','user5','u','user_5','$2a$12$aYJA9GXW/CoDZM0Y2Vr38O6ZzFozV3ubBD9./BJvlGolqpWi0XngG',0,'user5@securde.com',NULL,NULL,'ACCOUNTING_MANAGER',1,NULL,0,NULL,NULL),(6,'user6','user6','u','user_6','$2a$12$q6eNNN58DG3MK2nyusq75OEAiMuYWctJ7fhq4znOaS32OVP4J9.5K',0,'user6@securde.com',NULL,NULL,'ADMIN',1,NULL,0,NULL,NULL),(7,'user7','user7','u','user_7','$2a$12$frxnKSRXQiIhe5P3eUYnQehrLX8BS9C3/UGvjNvdoWiCkNjQgSGkW',0,'user7@securde.com',NULL,NULL,'PRODUCT_MANAGER',1,NULL,0,NULL,NULL),(8,'user8','user8','u','user_8','$2a$12$iAbOaGwcrGXdfvtApjzX/uIJJRG7Wz.km9yDbeWGrFDOyQLgJ4l8e',0,'user8@securde.com',NULL,NULL,'ACCOUNTING_MANAGER',1,NULL,0,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-08-10 16:08:23
