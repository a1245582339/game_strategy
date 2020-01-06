/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : game_strategy

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 06/01/2020 19:09:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `del` int(11) NOT NULL DEFAULT '0',
  `role` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
BEGIN;
INSERT INTO `admin_user` VALUES (1, 'ew', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 1);
INSERT INTO `admin_user` VALUES (2, 'editor', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 2);
INSERT INTO `admin_user` VALUES (3, 'ew7', '2', 0, 2);
INSERT INTO `admin_user` VALUES (4, 'test', '123', 1, 2);
COMMIT;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 NOT NULL,
  `cover` varchar(255) CHARACTER SET utf8 NOT NULL,
  `gameId` int(11) NOT NULL,
  `del` int(11) NOT NULL DEFAULT '0',
  `create_time` varchar(255) CHARACTER SET utf8 NOT NULL,
  `content` longtext NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_f0c0a548770631363577d0c6063` (`gameId`) USING BTREE,
  CONSTRAINT `FK_f0c0a548770631363577d0c6063` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES (1, 'tst', 'tttt', 1, 0, '1576998210452', '');
INSERT INTO `article` VALUES (2, '测试', 'www', 1, 1, '1577372109762', '');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NOT NULL,
  `l_id` int(11) NOT NULL,
  `r_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` int(11) NOT NULL COMMENT '1：游戏平台\r\n2：游戏类型\r\n3：游戏专区',
  `del` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES (1, 0, 1, 18, 'root', 0, 0);
INSERT INTO `category` VALUES (7, 1, 2, 11, '电脑游戏', 1, 0);
INSERT INTO `category` VALUES (10, 7, 3, 4, '动作游戏1', 2, 1);
INSERT INTO `category` VALUES (19, 7, 3, 4, '角色扮演', 2, 0);
INSERT INTO `category` VALUES (20, 7, 5, 6, '第一人称射击', 2, 0);
INSERT INTO `category` VALUES (21, 1, 12, 17, '手机游戏', 1, 0);
INSERT INTO `category` VALUES (22, 7, 7, 8, '策略战棋', 2, 0);
INSERT INTO `category` VALUES (23, 7, 9, 10, '赛车竞速', 2, 0);
INSERT INTO `category` VALUES (24, 21, 13, 14, '体育竞技', 2, 0);
INSERT INTO `category` VALUES (25, 21, 15, 16, '休闲益智', 2, 0);
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `articleId` int(11) NOT NULL,
  `content` varchar(255) NOT NULL,
  `replyUserId` int(11) NOT NULL DEFAULT '0',
  `read` int(11) NOT NULL DEFAULT '0',
  `del` int(11) NOT NULL DEFAULT '0',
  `create_time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_c0354a9a009d3bb45a08655ce3b` (`userId`) USING BTREE,
  KEY `FK_c20404221e5c125a581a0d90c0e` (`articleId`) USING BTREE,
  CONSTRAINT `FK_c0354a9a009d3bb45a08655ce3b` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_c20404221e5c125a581a0d90c0e` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES (5, 1, 1, 'qwe', 1, 1, 0, '1577195782561');
INSERT INTO `comment` VALUES (6, 1, 1, 'qwe', 1, 1, 0, '1577196149310');
INSERT INTO `comment` VALUES (7, 1, 1, 'qwe', 1, 0, 0, '1577196409395');
COMMIT;

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `create_time` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_a9e25be94f65c6f11f420d97bca` (`articleId`),
  KEY `FK_e747534006c6e3c2f09939da60f` (`userId`),
  CONSTRAINT `FK_a9e25be94f65c6f11f420d97bca` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_e747534006c6e3c2f09939da60f` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for favorties
-- ----------------------------
DROP TABLE IF EXISTS `favorties`;
CREATE TABLE `favorties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `create_time` varchar(255) NOT NULL,
  `articleId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_02f3409d97822c6945adf6cc743` (`userId`),
  KEY `FK_a4cbc7d4493e58508f772fc8daf` (`articleId`),
  CONSTRAINT `FK_02f3409d97822c6945adf6cc743` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_a4cbc7d4493e58508f772fc8daf` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of favorties
-- ----------------------------
BEGIN;
INSERT INTO `favorties` VALUES (1, 1, '123123123222', 1);
INSERT INTO `favorties` VALUES (2, 1, '123123123123', 2);
COMMIT;

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gameId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_82d964eacf90242048c84e5e405` (`gameId`) USING BTREE,
  KEY `FK_af9f90ce5e8f66f845ebbcc6f15` (`userId`) USING BTREE,
  CONSTRAINT `FK_82d964eacf90242048c84e5e405` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_af9f90ce5e8f66f845ebbcc6f15` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of follow
-- ----------------------------
BEGIN;
INSERT INTO `follow` VALUES (1, 1, 1);
INSERT INTO `follow` VALUES (3, 2, 1);
COMMIT;

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `desp` varchar(255) NOT NULL,
  `cover` varchar(255) NOT NULL,
  `categoryId` int(11) NOT NULL,
  `del` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_3f10804f18297163a6189353e64` (`categoryId`) USING BTREE,
  CONSTRAINT `FK_3f10804f18297163a6189353e64` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of game
-- ----------------------------
BEGIN;
INSERT INTO `game` VALUES (1, '英雄联盟', 'ss\'d撒大苏打撒旦', 'http://localhost:3000/public/img_15779345224231xtmf0l0txa.jpeg', 19, 0);
INSERT INTO `game` VALUES (2, '刺激战场', '123', 'http://localhost:3000/public/img_1577935186157qgfvmsreuz.jpeg', 19, 0);
INSERT INTO `game` VALUES (3, '尼尔机械纪元', 'adasdsadsadsad', 'sdasdsadsadsadsadsad', 10, 1);
INSERT INTO `game` VALUES (5, '使命召唤', 'rewrewr ', 'http://localhost:3000/public/img_1577934348198m8z9oem013.jpeg', 20, 0);
INSERT INTO `game` VALUES (6, '英雄联盟', 'ss\'d撒大苏打撒旦', 'http://localhost:3000/public/img_1577934364104njml4dvnrli.jpeg', 19, 1);
INSERT INTO `game` VALUES (7, 'a', 'a', 'http://localhost:3000/public/defaultCover.png', 22, 0);
INSERT INTO `game` VALUES (8, 'b', 'b', 'http://localhost:3000/public/defaultCover.png', 22, 0);
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(255) NOT NULL COMMENT '登录名',
  `nick_name` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL COMMENT '密码',
  `email` varchar(255) NOT NULL COMMENT '邮箱',
  `del` int(11) NOT NULL DEFAULT '0',
  `avatar` varchar(255) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'test', 'test', '2', '1', 0, 'qwe');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
