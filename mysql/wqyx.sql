/*
Navicat MySQL Data Transfer

Source Server         : 本地
Source Server Version : 50621
Source Host           : localhost:3306
Source Database       : wqyx

Target Server Type    : MYSQL
Target Server Version : 50621
File Encoding         : 65001

Date: 2017-10-20 16:59:46
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `equip1`
-- ----------------------------
DROP TABLE IF EXISTS `equip1`;
CREATE TABLE `equip1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `playerTag` varchar(255) DEFAULT NULL,
  `equipId` char(255) DEFAULT NULL,
  `equipType` smallint(6) unsigned DEFAULT NULL,
  `equipNumber` int(6) unsigned DEFAULT NULL,
  `equipStar` smallint(5) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of equip1
-- ----------------------------
INSERT INTO `equip1` VALUES ('1', '888888-1', '80109', '2', '1', '1');
INSERT INTO `equip1` VALUES ('2', '888888-1', '80109', '1', '2', '2');
INSERT INTO `equip1` VALUES ('3', '888888-1', '80109', '1', '2', '1');

-- ----------------------------
-- Table structure for `hero1`
-- ----------------------------
DROP TABLE IF EXISTS `hero1`;
CREATE TABLE `hero1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playerTag` varchar(255) DEFAULT NULL,
  `recruited` varchar(255) DEFAULT NULL,
  `lv` varchar(255) DEFAULT NULL,
  `qiangHuaLv` varchar(255) DEFAULT NULL,
  `jinjieLv` varchar(255) DEFAULT NULL,
  `freeJieJiaoTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hero1
-- ----------------------------
INSERT INTO `hero1` VALUES ('10', '888888-1', '4003;4002;5003;5002;6003;5006;6003', '1;1;1;1;1;1;1', '1;4;11;0;0;0;0', '1;1;1;0;0;0;0', '2017-10-16 17:56:08');

-- ----------------------------
-- Table structure for `heroequip1`
-- ----------------------------
DROP TABLE IF EXISTS `heroequip1`;
CREATE TABLE `heroequip1` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `playerTag` varchar(255) DEFAULT NULL,
  `equipID` char(255) DEFAULT NULL,
  `start` smallint(6) DEFAULT NULL,
  `equipType` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of heroequip1
-- ----------------------------

-- ----------------------------
-- Table structure for `itemtime1`
-- ----------------------------
DROP TABLE IF EXISTS `itemtime1`;
CREATE TABLE `itemtime1` (
  `id` bigint(20) NOT NULL DEFAULT '0',
  `playerTag` varchar(255) DEFAULT NULL,
  `itemID` char(255) DEFAULT NULL,
  `expirationTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `itemTag` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of itemtime1
-- ----------------------------

-- ----------------------------
-- Table structure for `itemuntime1`
-- ----------------------------
DROP TABLE IF EXISTS `itemuntime1`;
CREATE TABLE `itemuntime1` (
  `id` bigint(11) NOT NULL DEFAULT '0',
  `playerTag` varchar(255) DEFAULT NULL,
  `itemID` char(255) DEFAULT NULL,
  `itemNumber` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of itemuntime1
-- ----------------------------
INSERT INTO `itemuntime1` VALUES ('1', '888888-1', '100', '74');

-- ----------------------------
-- Table structure for `playerinfo1`
-- ----------------------------
DROP TABLE IF EXISTS `playerinfo1`;
CREATE TABLE `playerinfo1` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `playerTag` varchar(255) DEFAULT NULL,
  `lv` int(11) DEFAULT NULL,
  `sex` tinyint(4) DEFAULT NULL,
  `playerName` char(255) DEFAULT NULL,
  `headTag` tinyint(4) DEFAULT NULL,
  `diamond` int(11) DEFAULT NULL,
  `gold` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of playerinfo1
-- ----------------------------
INSERT INTO `playerinfo1` VALUES ('6', '888888-1', '1', '2', 'DG123456', '1', '121512', '137094980');
INSERT INTO `playerinfo1` VALUES ('7', '888888129-1', '1', '2', 'DG834656', '1', '0', '0');

-- ----------------------------
-- Table structure for `test`
-- ----------------------------
DROP TABLE IF EXISTS `test`;
CREATE TABLE `test` (
  `id` int(11) NOT NULL DEFAULT '0',
  `std` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test
-- ----------------------------
INSERT INTO `test` VALUES ('1', '2');

-- ----------------------------
-- Table structure for `userinfo`
-- ----------------------------
DROP TABLE IF EXISTS `userinfo`;
CREATE TABLE `userinfo` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userName` char(255) DEFAULT NULL,
  `playerTag` char(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of userinfo
-- ----------------------------
INSERT INTO `userinfo` VALUES ('8', '888888', '888888-1');
INSERT INTO `userinfo` VALUES ('9', '88888842', '88888842-1');
INSERT INTO `userinfo` VALUES ('10', '888888156', '888888156-1');
INSERT INTO `userinfo` VALUES ('11', '88888837', '88888837-1');
INSERT INTO `userinfo` VALUES ('12', '888888312', '888888312-1');
INSERT INTO `userinfo` VALUES ('13', '888888129', '888888129-1');
