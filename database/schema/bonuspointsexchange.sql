# MySQL-Front 5.1  (Build 4.2)




# Host: 127.0.0.1    Database: bonuspointsexchange
# ------------------------------------------------------
# Server version 8.0.15

#
# Source for table order
#
DROP USER IF EXISTS 'bonusbit'@'%';

CREATE USER 'bonusbit'@'%' IDENTIFIED BY '12345678';

grant all PRIVILEGES on bonusbitExchange.*  to 'bonusbit'@'%';


USE bonusbitExchange;
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL DEFAULT '',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `point` int(11) NOT NULL DEFAULT '0',
  `wantedShop` varchar(50) NOT NULL DEFAULT '',
  `wantedPoint` int(11) NOT NULL DEFAULT '0',
  `exchangeUserName` varchar(50) DEFAULT NULL,
  `untilDate` datetime NOT NULL DEFAULT '1000-01-01 00:00:00',
  `orderDate` datetime DEFAULT '1000-01-01 00:00:00',
  `orderStatus` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`orderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table order
#

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table point
#

DROP TABLE IF EXISTS `point`;
CREATE TABLE `point` (
  `pointID` int(11) NOT NULL AUTO_INCREMENT,
  `userName` varchar(50) NOT NULL DEFAULT '',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `platformPoint` int(11) NOT NULL DEFAULT '0',
  `bindtime` date DEFAULT '1000-01-01',
  PRIMARY KEY (`pointID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

#
# Dumping data for table point
#

LOCK TABLES `point` WRITE;
/*!40000 ALTER TABLE `point` DISABLE KEYS */;
INSERT INTO `point` VALUES (3,'Bob','Air China',100000,'2017-02-27');
INSERT INTO `point` VALUES (2,'Bob','Changan Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (4,'Bob','Eastern Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (5,'Bob','Northern Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (6,'Bob','Shanghai Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (7,'Bob','Shenzhen Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (8,'Bob','Sichuan Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (9,'Bob','Wuhan Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (10,'Bob','Xiamen Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (11,'John','Air China',100000,'2017-02-27');
INSERT INTO `point` VALUES (12,'John','Changan Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (13,'John','Eastern Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (14,'John','Northern Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (15,'John','Shanghai Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (16,'John','Shenzhen Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (17,'John','Sichuan Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (18,'John','Wuhan Airlines',100000,'2017-02-27');
INSERT INTO `point` VALUES (19,'John','Xiamen Airlines',100000,'2017-02-27');
/*!40000 ALTER TABLE `point` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table shop
#

DROP TABLE IF EXISTS `shop`;
CREATE TABLE `shop` (
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `imageURL` varchar(200) DEFAULT NULL,
  `password` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `number` varchar(50) NOT NULL DEFAULT '',
  `shopProperty` varchar(50) NOT NULL DEFAULT '',
  `shopDec` varchar(500) DEFAULT NULL,
  `telephone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shopName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table shop
#

LOCK TABLES `shop` WRITE;
/*!40000 ALTER TABLE `shop` DISABLE KEYS */;
INSERT INTO `shop` VALUES ('Air China','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6658789','Airlines','Air China ','13260665620');
INSERT INTO `shop` VALUES ('Changan Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659784','Airlines','Changan Airlines','13260665620');
INSERT INTO `shop` VALUES ('Eastern Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659685','Airlines','Eastern Airlines','13260665620');
INSERT INTO `shop` VALUES ('Northern Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659897','Airlines','Northern Airlines','13260665620');
INSERT INTO `shop` VALUES ('Shanghai Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659235','Airlines','Shanghai Airlines','13260665620');
INSERT INTO `shop` VALUES ('Shenzhen Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659365','Airlines','Shenzhen Airlines','13260665620');
INSERT INTO `shop` VALUES ('Sichuan Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659243','Airlines','Sichuan Airlines','13260665620');
INSERT INTO `shop` VALUES ('Wuhan Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659725','Airlines','Wuhan Airlines','13260665620');
INSERT INTO `shop` VALUES ('Xiamen Airlines','defaultIcon.jpg','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','6659878','Airlines','Xiamen Airlines','13260665620');
/*!40000 ALTER TABLE `shop` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table transfer
#

DROP TABLE IF EXISTS `transfer`;
CREATE TABLE `transfer` (
  `transferID` int(11) NOT NULL AUTO_INCREMENT,
  `pointID` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '0',
  `point` int(11) NOT NULL DEFAULT '0',
  `transferTime` date NOT NULL DEFAULT '1000-01-01',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`transferID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table transfer
#

LOCK TABLES `transfer` WRITE;
/*!40000 ALTER TABLE `transfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `transfer` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table user
#

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userName` varchar(50) NOT NULL DEFAULT '',
  `passwd` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `fullName` varchar(50) NOT NULL DEFAULT '',
  `phone` varchar(50) NOT NULL DEFAULT '',
  `imageURL` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`userName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table user
#

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('Bob','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','Bob','13260665620',NULL);
INSERT INTO `user` VALUES ('John','96E79218965EB72C92A549DD5A330112','1255826318@qq.com','John','13260665620',NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

#
# Source for table userpoint
#

DROP TABLE IF EXISTS `userpoint`;
CREATE TABLE `userpoint` (
  `userName` varchar(50) NOT NULL DEFAULT '',
  `shopName` varchar(50) NOT NULL DEFAULT '',
  `userPoint` int(11) DEFAULT '0',
  `password` varchar(50) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

#
# Dumping data for table userpoint
#

LOCK TABLES `userpoint` WRITE;
/*!40000 ALTER TABLE `userpoint` DISABLE KEYS */;
INSERT INTO `userpoint` VALUES ('Bob','Air China',20000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Changan Airlines',20000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Eastern Airlines',50000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Northern Airlines',60000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Shanghai Airlines',30000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Shenzhen Airlines',10000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Sichuan Airlines',50000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Wuhan Airlines',60000,'111111');
INSERT INTO `userpoint` VALUES ('Bob','Xiamen Airlines',30000,'111111');
INSERT INTO `userpoint` VALUES ('John','Air China',80000,'111111');
INSERT INTO `userpoint` VALUES ('John','Changan Airlines',70000,'111111');
INSERT INTO `userpoint` VALUES ('John','Eastern Airlines',60000,'111111');
INSERT INTO `userpoint` VALUES ('John','Northern Airlines',40000,'111111');
INSERT INTO `userpoint` VALUES ('John','Shanghai Airlines',50000,'111111');
INSERT INTO `userpoint` VALUES ('John','Shenzhen Airlines',40000,'111111');
INSERT INTO `userpoint` VALUES ('John','Sichuan Airlines',60000,'111111');
INSERT INTO `userpoint` VALUES ('John','Wuhan Airlines',20000,'111111');
INSERT INTO `userpoint` VALUES ('John','Xiamen Airlines',60000,'111111');
/*!40000 ALTER TABLE `userpoint` ENABLE KEYS */;
UNLOCK TABLES;
