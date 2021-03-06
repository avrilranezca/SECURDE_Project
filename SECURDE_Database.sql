CREATE DATABASE  IF NOT EXISTS `securde_eshopping` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `securde_eshopping`;
-- MySQL dump 10.13  Distrib 5.6.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: securde_eshopping
-- ------------------------------------------------------
-- Server version	5.6.23-log

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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'1','street1','subdivision1','city1','1','country1'),(2,'1','shippingstreet1','shippingsubdivision1','shippingcity1','shipping1','shippingcountry1'),(3,'123','asdsad','sdasda','asdsad','144','asdasd'),(4,'123','asdsad','sdasda','asdsad','144','asdasd'),(5,'123','asdsad','sdasda','asdsad','144','asdasd'),(6,'123','asdas','sds','ssds','1440','sfsdf'),(7,'123','Santo Domingo','subdi','Quezon City','1440','Philippines'),(8,'123','Santo Domingo','subdi','Quezon City','1440','Philippines'),(9,'123','Santo Domingo','subdi','Quezon City','1440','Philippines'),(10,'123','Santo Domingo','subdi','Quezon City','1440','Philippines'),(11,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(12,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(13,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(14,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(15,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(16,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(17,'1','SECURDE','SECURDE','SECURDE','1','SECURDE'),(18,'1','SECURDE','SECURDE','SECURDE','1','SECURDE');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorization_matrix`
--

DROP TABLE IF EXISTS `authorization_matrix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorization_matrix` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_url` varchar(255) NOT NULL,
  `customer` tinyint(1) NOT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `accounting_manager` tinyint(1) NOT NULL,
  `product_manager` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorization_matrix`
--

LOCK TABLES `authorization_matrix` WRITE;
/*!40000 ALTER TABLE `authorization_matrix` DISABLE KEYS */;
INSERT INTO `authorization_matrix` VALUES (1,'/index.jsp',1,0,0,0),(2,'/login.jsp',1,0,0,0),(3,'/sign-up.jsp',1,0,0,0),(4,'/view-product.jsp',1,0,0,0),(5,'/view-cart.jsp',1,0,0,0),(6,'/checkout_shipping.jsp',1,0,0,0),(7,'/checkout_billing.jsp',1,0,0,0),(8,'/changePassword.jsp',0,0,1,1),(9,'/accounting_manager.jsp',0,0,1,0),(10,'/product_manager.jsp',0,0,0,1),(11,'/index_admin.jsp',0,1,0,0),(12,'/checkout_confirm.jsp',1,0,0,0),(13,'/SelectDisplayCategoryServlet',1,0,0,0),(14,'/DisplaySpecificItemServlet',1,0,0,0),(15,'/IndexDisplayProductsServlet',1,0,0,0),(16,'/DisplayProductsServlet',0,0,0,1),(17,'/DisplayFinancialRecordsServlet',0,0,1,0),(18,'/DisplayManagersServlet',0,1,0,0),(19,'/CheckoutShippingServlet',1,0,0,0),(20,'/CheckoutBillingServlet',1,0,0,0),(21,'/CheckoutConfirmServlet',1,0,0,0),(22,'/LogoutServlet',1,1,1,1),(23,'/DisplayManagersServlet',0,1,0,0),(24,'/AddManagerServlet',0,1,0,0),(25,'/AddProductServlet',0,0,0,1),(26,'/AddReviewServlet',1,0,0,0),(27,'/AddToCartQuantityServlet',1,0,0,0),(28,'/AddToCartServlet',1,0,0,0),(29,'/ChangePasswordServlet',0,0,1,1),(30,'/DeleteProductServlet',0,0,0,1),(31,'/DisplayCartServlet',1,0,0,0),(32,'/EditProductServlet',0,0,0,1),(33,'/LoginServlet',1,1,1,1),(34,'/SignUpServlet',1,0,0,0),(35,'/UpdateCartQuantityServlet',1,0,0,0),(36,'/index',1,0,0,0),(37,'/product_manager',0,0,0,1),(38,'/DeleteManagerServlet',0,1,0,0),(39,'/CheckUsernameServlet',1,1,0,0),(40,'/admin',0,1,0,0),(41,'/accounting_manager',0,0,1,0);
/*!40000 ALTER TABLE `authorization_matrix` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'yo','boot1des',1,1,0),(2,'shoe2','shoe1des',1.23,2,1),(3,'boot2','boot2des',2.34,1,1),(4,'boot3','boot3des',7,1,1),(5,'slipper1','slipper1des',2.97,4,1),(6,'slipper2','slipper2des',1.23,4,1),(7,'sandal1','sandal1des',45.9,3,1),(8,'sandal2','sandal2des',13.9,3,1),(9,'Hello','<script>alert(\'hello\')</script> asdasd ',12.34,1,1),(10,'xss','<img src=\"sdadasdas\" onerror=\"javascript:  alert(\'test\')\">sdfdsfsdfsdf',123,1,1),(11,'<script>alert(\'xss\')</script>asdasd','<script>alert(\'xss\')</script>asdasd',123,1,1),(12,'123','<script> alert(\"hello\")</script> dsdsa\n',123,3,1),(13,'name1','\' or 1=1 -- adasdsadasdsad',1,1,1);
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
INSERT INTO `review` VALUES (1,1,'user_1',1,'review of 1 of 1','2016-07-27 00:00:00',4),(2,1,'user_1',1,'review of 1 of 1','2016-07-27 23:06:48',4),(3,1,'user_1',2,'hi','2016-08-04 13:00:26',3),(4,1,'user_1',2,'hi','2016-08-04 13:00:34',2),(5,1,'user_1',1,'hi','2016-08-04 13:00:43',1),(6,2,'user_2',2,'my review 2-2','2016-08-04 22:42:01',3),(7,13,'SECURDE',2,'<script>alert(\'hello\')</script> asdasasd','2016-08-20 16:18:18',3);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction`
--

LOCK TABLES `transaction` WRITE;
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` VALUES (1,1,'2016-07-31 19:16:14'),(2,1,'2016-07-31 19:16:28'),(4,1,'2016-08-01 13:54:56'),(9,2,'2016-08-01 13:58:21'),(10,11,'2016-08-20 14:02:49'),(11,11,'2016-08-20 15:10:49'),(12,13,'2016-08-20 15:27:36');
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
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_entry`
--

LOCK TABLES `transaction_entry` WRITE;
/*!40000 ALTER TABLE `transaction_entry` DISABLE KEYS */;
INSERT INTO `transaction_entry` VALUES (1,1,2,1,1),(2,2,3,1.23,1),(3,3,1,2.34,1),(4,1,2,1,2),(5,2,3,1.23,2),(6,3,1,2.34,2),(10,1,2,1,4),(11,2,3,1.23,4),(12,3,1,2.34,4),(25,1,2,1,9),(26,2,3,1.23,9),(27,3,1,2.34,9),(28,2,1,1.23,10),(29,7,1,45.9,10),(30,2,1,1.23,11),(31,4,1,7,11),(32,3,1,2.34,11),(33,7,1,45.9,12),(34,4,1,7,12),(35,2,1,1.23,12);
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
  `date_created` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `billing_address_FK_idx` (`billing_address_id`),
  KEY `shipping_address_FK_idx` (`shipping_address_id`),
  CONSTRAINT `u_billing_address_FK` FOREIGN KEY (`billing_address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `u_shipping_address_FK` FOREIGN KEY (`shipping_address_id`) REFERENCES `address` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'user1','user1','u','user_1','$2a$12$BTEF7l8BayUpKgb2HweApuZ7jeXeLE8zdbP0KKcY3euK63ykZdmhy',1,'user1@securde.com',1,2,'CUSTOMER',1,'newSessionID',0,NULL,'2016-08-12 15:13:46','2016-08-14 16:28:44'),(2,'user2','user2','u','user_2','$2a$12$Ml1gCI0.4VvVsRIZVSPxIeqUeqiaHk0Q3.v2ytOw3ZqnAJRELnh.q',1,'user2@securde.com',NULL,NULL,'CUSTOMER',1,NULL,0,NULL,NULL,'2016-08-14 16:34:41'),(3,'user3','user3','u','user_3','$2a$12$WRgiH.W2FyIHyJy9YZBYjO4V4aZ4zYzgREQ9WFolVm03miLOxix2e',0,'user3@securde.com',NULL,NULL,'CUSTOMER',1,NULL,0,NULL,NULL,'2016-08-14 16:34:41'),(4,'user4','user4','u','user_4','$2a$12$QO5/oO/MBqCpbVQleJiLkeJEmutm8YpZtgM2rWL9.ln6H0KcbxOuO',1,'user4@securde.com',NULL,NULL,'CUSTOMER',1,NULL,0,NULL,NULL,'2016-08-14 16:34:41'),(5,'user5','user5','u','user_5','$2a$12$aYJA9GXW/CoDZM0Y2Vr38O6ZzFozV3ubBD9./BJvlGolqpWi0XngG',0,'user5@securde.com',NULL,NULL,'ACCOUNTING_MANAGER',1,NULL,0,NULL,NULL,'2016-08-14 16:34:41'),(6,'user6','user6','u','user_6','$2a$12$q6eNNN58DG3MK2nyusq75OEAiMuYWctJ7fhq4znOaS32OVP4J9.5K',0,'user6@securde.com',NULL,NULL,'ADMIN',0,'5B86BBD46196D28D8F4C45DEC049B621',1,NULL,'2016-08-20 16:41:15','2016-08-14 16:34:41'),(7,'user7','user7','u','user_7','$2a$12$qwDGD57Ld2.T4VbboqzLLuXaJJjNYzruVm2c4lN6mfSZYUsWA0vjq',1,'user7@securde.com',NULL,NULL,'PRODUCT_MANAGER',1,NULL,2,NULL,'2016-08-20 16:27:57','2016-08-14 16:34:41'),(8,'user8','user8','u','user_8','$2a$12$iAbOaGwcrGXdfvtApjzX/uIJJRG7Wz.km9yDbeWGrFDOyQLgJ4l8e',0,'user8@securde.com',NULL,NULL,'ACCOUNTING_MANAGER',1,NULL,0,NULL,NULL,'2016-08-14 16:34:41'),(9,'user9','user9','u','user_9','$2a$12$KWPl9/BizU48oOPTa32iC.1wtSoWZ6EAuxZrHdbT0KCyurYuPnRFy',1,'user9@securde.com',NULL,NULL,'ACCOUNTING_MANAGER',1,NULL,0,NULL,'2016-08-20 16:21:58','2016-08-14 16:33:11'),(10,'','','','CHENGWLANGKWENTA','$2a$12$34YwTHnlsGaP.F6x7xS7c.ni16TqmMMSERaEsIWxOwUj2c9x5t1Te',0,'',NULL,NULL,'PRODUCT_MANAGER',0,NULL,0,NULL,NULL,'2016-08-17 17:14:25'),(11,'Hello','asdasd','asdsa','rissa','$2a$12$XhTy25aBUBMrWazuid9NveqhgiDrsYSmnxf3tBNgf.EpfWzo2A4Cm',1,'shayane_tan@yahoo.com',3,4,'CUSTOMER',1,'A0AF202FC2583FC4A052803BA4A23D69',1,NULL,'2016-08-20 15:10:49','2016-08-20 14:01:57'),(12,'Juan','DelaCruz','A','david','$2a$12$8BFIeJgsYuAJ7OGFtYd2c.pF1AIfYhYNirRJ1Y3aD1wlo9oGW2dB6',1,'example@abc.com',7,7,'CUSTOMER',1,NULL,0,NULL,'2016-08-20 14:19:51','2016-08-20 14:19:51'),(13,'SECURDE','SECURDE','A','SECURDE','$2a$12$H3cEyKLzxYMNb1SBnAs7uuSufE6i4IpamVMc11SnPtYbEdfnIFpli',1,'SECURDE@SECURDE.COM',11,11,'CUSTOMER',1,NULL,1,NULL,'2016-08-20 16:28:24','2016-08-20 14:22:56'),(14,'SECURDE','SECURDE','a','SECURDE2','$2a$12$Q2KnkiKSeCYc7p3HgVcmDegaE/1RLfhtSJU0oWcR5pGMUFFoggoXG',1,'SECURDE@SECURDE.COM',11,11,'CUSTOMER',1,'335945023527D21777E72AFE390155D9',2,NULL,'2016-08-20 16:06:13','2016-08-20 14:48:09'),(15,'','','','user_10','$2a$12$UgJsWQKDKgf0FBRV.bJQJuF6dHwyhwRaqQzHlqnMb8ctwocYRLxdO',0,'',NULL,NULL,'PRODUCT_MANAGER',1,NULL,3,NULL,NULL,'2016-08-20 16:35:45'),(16,'','','','<input type=\"radio\" name=\"type\" value=\"ADMIN\" checked=\"checked\"> newAdmin ','$2a$12$muWr2RVWMQ0nkT/1jURHDeNN3vGXY4nNR35aOcIbLHPm3rbsR3Fee',0,'',NULL,NULL,'PRODUCT_MANAGER',0,NULL,0,NULL,NULL,'2016-08-20 16:39:31'),(17,'','','','\\<input type=\\\"radio\\\" name=\\\"type\\\" value=\\\"ADMIN\\\" checked=\\\"checked\\\"\\>sdsfsdf','$2a$12$D.UEMDyZBkEuO6zoJs1L9.JEcL/7LBHYXG0ja/vAH37DeljkJ70t2',0,'',NULL,NULL,'ACCOUNTING_MANAGER',0,NULL,0,NULL,NULL,'2016-08-20 16:40:55');
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

-- Dump completed on 2016-08-24 19:17:13
