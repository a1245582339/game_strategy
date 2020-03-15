/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50720
 Source Host           : localhost:3306
 Source Schema         : game_strategy

 Target Server Type    : MySQL
 Target Server Version : 50720
 File Encoding         : 65001

 Date: 15/03/2020 18:14:20
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for admin_user
-- ----------------------------
DROP TABLE IF EXISTS `admin_user`;
CREATE TABLE `admin_user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除标识',
  `role` int(11) NOT NULL COMMENT '角色',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin_user
-- ----------------------------
INSERT INTO `admin_user` VALUES (1, 'ew', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 1);
INSERT INTO `admin_user` VALUES (2, 'editor', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', 0, 2);
INSERT INTO `admin_user` VALUES (3, 'ew7', '2', 0, 2);
INSERT INTO `admin_user` VALUES (4, 'test', '123', 1, 2);

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章标题',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '文章封面',
  `gameId` int(11) NOT NULL COMMENT '游戏id',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除标识',
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文章内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_f0c0a548770631363577d0c6063`(`gameId`) USING BTREE,
  CONSTRAINT `FK_f0c0a548770631363577d0c6063` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES (3, '《绝地求生：刺激战场》运输船介绍', '/public/img_1578406452504zr10xwqinq.jpg', 2, 0, '1578406495732', '');
INSERT INTO `article` VALUES (4, '《绝地求生：刺激战场》8大热门载具盘点介绍', '/public/img_15784065206576plntf4m1kg.jpg', 2, 0, '1578406535173', '');
INSERT INTO `article` VALUES (5, '《绝地求生：刺激战场》海岛图易防守建筑介绍', '/public/img_157840656367996ht7fvfunv.jpg', 2, 0, '1578406577277', '');
INSERT INTO `article` VALUES (6, '《绝地求生：刺激战场》握把搭配推荐介绍', '/public/img_1578406634015n9n2k8x2yc.jpg', 2, 0, '1578406646465', '');
INSERT INTO `article` VALUES (7, '《绝地求生：刺激战场》新手跳伞不推荐地点介绍', '/public/img_15784066821030apv8wna4ohi.jpg', 2, 0, '1578406691859', '');
INSERT INTO `article` VALUES (8, 'LOL也出狗牌功能了？永恒星碑功能即将上线', '/public/img_1578407114178o9mnm951wam.jpg', 1, 0, '1578407115377', '');
INSERT INTO `article` VALUES (9, '【云顶之弈·装备合成篇】斯塔缇克电刃的合成、效果和应用', '/public/img_15785347115556podggxnnbo.jpg', 1, 0, '1578534751910', '');
INSERT INTO `article` VALUES (10, '王者阿卡丽都不曾注意的细节！阿卡丽拉圈竟不需要移动！烟雾移动居然有规律，干货满满的阿卡丽技巧分析！', '/public/img_1578536689991rp6qzelqjud.png', 1, 0, '1578536751605', '');
INSERT INTO `article` VALUES (11, '王者阿卡丽都不曾注意的细节！阿卡丽拉圈竟不需要移动！烟雾移动居然有规律，干货满满的阿卡丽技巧分析！', '/public/img_1578536805014snhzfp1a47n.png', 1, 0, '1578536807323', '');
INSERT INTO `article` VALUES (12, '王者阿卡丽都不曾注意的细节！阿卡丽拉圈竟不需要移动！烟雾移动居然有规律，干货满满的阿卡丽技巧分析！', '/public/img_1578536827394vpyc57hypwi.png', 1, 0, '1578536848248', '');
INSERT INTO `article` VALUES (13, '王者阿卡丽都不曾注意的细节！阿卡丽拉圈竟不需要移动！烟雾移动居然有规律，干货满满的阿卡丽技巧分析！', '/public/img_1578537101689j2nodfzh2r.png', 1, 0, '1578537139222', '');
INSERT INTO `article` VALUES (14, '云顶：山脉、水晶羁绊加强 法海阵容依然强势', '/public/img_1580209412553s6yexbrsbxb.png', 1, 0, '1580209454570', '<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">云顶之弈S2赛季已经上线好久了，大家是不是也都在匹配中玩腻了呢?疯子这几周玩下来最大的感触就是，现在玩云顶之弈就只有两套阵容。一套是有劫的，一套是没有劫的。有劫的阵容容易吃鸡，没有劫的最多就吃烂分。</span></p>\n<p></p>\n<img src=\"/public/img_1580209424507nqzx6gf7a5.jpg\" alt=\"undefined\" style=\"height: auto;width: 100%\"/>\n<img src=\"blob:http://lol.17173.com/fbd5d57f-199e-4971-9ffc-ba7ec48e9703\" alt=\"云顶之弈：山脉、水晶羁绊9.23大获加强，法海阵容依然强势\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">云顶之弈9.23版本终于有更新的计划了，大家可以从图中看到，这次调整的内容如下：</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">加强-海洋、守护神、岩雀、蝎子、EZ、寒冰、锤石、石头人、宝石</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">削弱-极地、影、复活甲、离子火花、冰拳、艾翁、大树、吸血鬼、马尔扎哈、奥拉夫、约里克、炼金</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">BUG修复-森林、吸血鬼、婕拉、小法、寒冰。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">加强导向</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">这次加强中，海洋羁绊被加强，虽然现在法海阵容很流行，但真要凑到6海洋6魔法师还是非常困难的。海洋加强应该是在回复蓝量上进行增加，等9.23上线后，法海可能就真的不懂爱了，双倍施法还快速回蓝，怎么玩?</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">单个英雄上，山脉二人组同时加强。山脉二人组本就是魔法师阵容里不可或缺的重要组成部分。现在1500点护盾的山脉羁绊就已经非常好用，在对两个独立英雄加强，可以想象，下个版本将会是人人山脉的版本。</span></p>\n<p></p>\n<img src=\"/public/img_1580209437151ny7jvhya6j.jpg\" alt=\"undefined\" style=\"height: auto;width: 100%\"/>\n<img src=\"blob:http://lol.17173.com/687cf67e-801c-45bb-9e38-926b7effddf5\" alt=\"云顶之弈：山脉、水晶羁绊9.23大获加强，法海阵容依然强势\" style=\"height: ;width: \"/>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">还有一个羁绊下全体英雄加强的就是水晶。蝎子只能出现在掠食者阵容中，艾希也因为机制问题只能当个后期挂件，宝石虽然很强，但到了大后期优质英雄太多，反而显得不这么强。9.23对这三个英雄进行了加强，大大提高了水晶的出场率，至少2水晶是一个非常不错的羁绊。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">削弱导向</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">这次有三件装备得到了削弱，复活甲、离子火花、冰拳。冰拳这一刀挨得有点不明不白，至少疯子很少会去合这件装备。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">奥拉夫被砍，说实话，有装备成型的奥拉夫真的很强。但狂战士中，真的也就只有奥拉夫能当大哥了，如今大哥一被砍，狂战士就拉了裤了。</span></p>\n<p></p>\n<img src=\"/public/img_1580209450527aja4nv34e24.jpg\" alt=\"undefined\" style=\"height: auto;width: 100%\"/>\n<p></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">马尔扎哈、约里克被砍了说真的，有一种大快人心的感觉。6召唤师中，真正强的就这两个。一个放虫子速度特别快，还能触发影的提成，打人还痛。一个能把队友并小傀儡，连着要杀2遍，太恶心了。</span></p>\n<p style=\"text-align:start;\"><span style=\"color: rgb(51,51,51);background-color: rgb(255,255,255);font-size: 16px;font-family: Microsoft Yahei;\">最后影这么强被砍还在情理之中，极地被砍一刀是怎么了呢?现在谁还在玩极地呢?</span>&nbsp;</p>\n');
INSERT INTO `article` VALUES (15, '涛涛涛涛', '/public/defaultCover.png', 1, 0, '1580444111749', '<p></p>\n');
INSERT INTO `article` VALUES (16, '123123123213', '/public/defaultCover.png', 1, 0, '1580444118681', '<p></p>\n');
INSERT INTO `article` VALUES (17, '额为全额', '/public/defaultCover.png', 1, 0, '1580444123880', '<p></p>\n');
INSERT INTO `article` VALUES (18, '去问我去饿我去饿', '/public/img_1583068794937m3in303ijp.jpg', 1, 0, '1583068825435', '<h2>去问我去<strong>饿我去饿我去饿我去</strong></h2>\n');

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) NOT NULL COMMENT '父id',
  `l_id` int(11) NOT NULL COMMENT '左id',
  `r_id` int(11) NOT NULL COMMENT '右id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名称',
  `type` int(11) NOT NULL COMMENT '1：游戏平台\r\n2：游戏类型\r\n3：游戏专区',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, 0, 1, 20, 'root', 0, 0);
INSERT INTO `category` VALUES (7, 1, 2, 11, '电脑游戏', 1, 0);
INSERT INTO `category` VALUES (10, 7, 3, 4, '动作游戏1', 2, 1);
INSERT INTO `category` VALUES (19, 7, 3, 4, '角色扮演', 2, 0);
INSERT INTO `category` VALUES (20, 7, 5, 6, '第一人称射击', 2, 0);
INSERT INTO `category` VALUES (21, 1, 12, 19, '手机游戏', 1, 0);
INSERT INTO `category` VALUES (22, 7, 7, 8, '策略战棋', 2, 0);
INSERT INTO `category` VALUES (23, 7, 9, 10, '赛车竞速', 2, 0);
INSERT INTO `category` VALUES (24, 21, 13, 14, '体育竞技', 2, 0);
INSERT INTO `category` VALUES (25, 21, 15, 16, '休闲益智', 2, 0);
INSERT INTO `category` VALUES (26, 21, 17, 18, '生存冒险', 2, 0);
INSERT INTO `category` VALUES (27, 7, 11, 12, '123', 2, 1);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL COMMENT '用户id',
  `articleId` int(11) NOT NULL COMMENT '文章id',
  `replyUserId` int(11) NOT NULL DEFAULT 0 COMMENT '回复用户的id',
  `read` int(11) NOT NULL DEFAULT 0 COMMENT '已读的标识',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除标识',
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '评论内容',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_c0354a9a009d3bb45a08655ce3b`(`userId`) USING BTREE,
  INDEX `FK_c20404221e5c125a581a0d90c0e`(`articleId`) USING BTREE,
  CONSTRAINT `FK_c0354a9a009d3bb45a08655ce3b` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_c20404221e5c125a581a0d90c0e` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 33 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 2, 13, 1, 1, 0, '1580201430937', '4121212121445');
INSERT INTO `comment` VALUES (2, 2, 13, 1, 1, 0, '1580201586555', '4121212121445');
INSERT INTO `comment` VALUES (3, 2, 13, 1, 1, 0, '1580201586833', '4121212121445');
INSERT INTO `comment` VALUES (4, 2, 13, 1, 1, 0, '1580201687342', '4121212121445');
INSERT INTO `comment` VALUES (5, 2, 14, 1, 1, 0, '1580209505153', '4121212121445');
INSERT INTO `comment` VALUES (6, 2, 14, 1, 1, 0, '1580209507699', '4121212121445');
INSERT INTO `comment` VALUES (7, 2, 14, 1, 1, 0, '1580209510093', '4121212121445');
INSERT INTO `comment` VALUES (8, 2, 14, 1, 1, 0, '1580209534671', '4121212121445');
INSERT INTO `comment` VALUES (9, 2, 14, 1, 1, 0, '1580211036367', '4121212121445');
INSERT INTO `comment` VALUES (10, 2, 14, 1, 1, 0, '1580269881355', '4121212121445');
INSERT INTO `comment` VALUES (11, 2, 14, 1, 1, 0, '1580270947453', '4121212121445');
INSERT INTO `comment` VALUES (12, 2, 14, 1, 1, 0, '1580270977303', '4121212121445');
INSERT INTO `comment` VALUES (13, 2, 14, 1, 1, 0, '1580271051733', '4121212121445');
INSERT INTO `comment` VALUES (14, 2, 14, 1, 1, 0, '1580271188252', '4121212121445');
INSERT INTO `comment` VALUES (15, 2, 14, 1, 1, 0, '1580271368041', '4121212121445');
INSERT INTO `comment` VALUES (16, 1, 14, 1, 1, 0, '1580271543752', '4121212121445');
INSERT INTO `comment` VALUES (17, 3, 14, 1, 1, 0, '1580271838457', '4121212121445');
INSERT INTO `comment` VALUES (18, 3, 14, 1, 1, 0, '1580271866652', '4121212121445');
INSERT INTO `comment` VALUES (19, 3, 14, 1, 1, 0, '1580271899498', '4121212121445');
INSERT INTO `comment` VALUES (20, 3, 14, 1, 1, 0, '1580271920891', '4121212121445');
INSERT INTO `comment` VALUES (21, 3, 14, 1, 1, 0, '1580272140418', '4121212121445');
INSERT INTO `comment` VALUES (22, 3, 14, 1, 1, 0, '1580272215713', '4121212121445');
INSERT INTO `comment` VALUES (23, 3, 14, 1, 1, 0, '1580272475142', '4121212121445');
INSERT INTO `comment` VALUES (24, 3, 14, 1, 1, 0, '1580272513444', 'v火炬计划v计划v计划v计划v');
INSERT INTO `comment` VALUES (25, 1, 14, 1, 1, 0, '1580527905759', '古古怪怪发发发');
INSERT INTO `comment` VALUES (26, 1, 14, 1, 1, 0, '1580527911196', '滚滚滚滚滚滚');
INSERT INTO `comment` VALUES (27, 1, 14, 1, 1, 0, '1580527989644', '让人');
INSERT INTO `comment` VALUES (28, 1, 14, 1, 1, 0, '1580528354152', '是是是');
INSERT INTO `comment` VALUES (29, 1, 14, 1, 1, 0, '1580531296580', '吞吞吐吐');
INSERT INTO `comment` VALUES (30, 1, 14, 1, 1, 0, '1580541191208', '应该会哈哈哈');
INSERT INTO `comment` VALUES (31, 1, 14, 2, 0, 0, '1583069502284', '555555');
INSERT INTO `comment` VALUES (32, 1, 14, 1, 1, 0, '1583069541203', '古古怪怪个');

-- ----------------------------
-- Table structure for favorites
-- ----------------------------
DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `articleId` int(11) NOT NULL COMMENT '文章id',
  `userId` int(11) NOT NULL COMMENT '用户id',
  `create_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_a9e25be94f65c6f11f420d97bca`(`articleId`) USING BTREE,
  INDEX `FK_e747534006c6e3c2f09939da60f`(`userId`) USING BTREE,
  CONSTRAINT `FK_a9e25be94f65c6f11f420d97bca` FOREIGN KEY (`articleId`) REFERENCES `article` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_e747534006c6e3c2f09939da60f` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorites
-- ----------------------------
INSERT INTO `favorites` VALUES (3, 14, 3, '1580356503349');
INSERT INTO `favorites` VALUES (7, 18, 1, '1583069475105');

-- ----------------------------
-- Table structure for follow
-- ----------------------------
DROP TABLE IF EXISTS `follow`;
CREATE TABLE `follow`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gameId` int(11) NOT NULL COMMENT '游戏id',
  `userId` int(11) NOT NULL COMMENT '用户id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_82d964eacf90242048c84e5e405`(`gameId`) USING BTREE,
  INDEX `FK_af9f90ce5e8f66f845ebbcc6f15`(`userId`) USING BTREE,
  CONSTRAINT `FK_82d964eacf90242048c84e5e405` FOREIGN KEY (`gameId`) REFERENCES `game` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_af9f90ce5e8f66f845ebbcc6f15` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of follow
-- ----------------------------
INSERT INTO `follow` VALUES (1, 1, 1);
INSERT INTO `follow` VALUES (3, 2, 1);

-- ----------------------------
-- Table structure for game
-- ----------------------------
DROP TABLE IF EXISTS `game`;
CREATE TABLE `game`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏名称',
  `desp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏简介',
  `cover` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '游戏封面',
  `categoryId` int(11) NOT NULL COMMENT '游戏分类id',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_3f10804f18297163a6189353e64`(`categoryId`) USING BTREE,
  CONSTRAINT `FK_3f10804f18297163a6189353e64` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of game
-- ----------------------------
INSERT INTO `game` VALUES (1, '英雄联盟', 'ss\'d撒大苏打撒旦', '/public/img_15779345224231xtmf0l0txa.jpeg', 19, 0);
INSERT INTO `game` VALUES (2, '刺激战场', '123', '/public/img_157840656367996ht7fvfunv.jpg', 26, 0);
INSERT INTO `game` VALUES (5, '使命召唤', 'rewrewr ', '/public/img_1577934348198m8z9oem013.jpeg', 20, 0);
INSERT INTO `game` VALUES (6, '英雄联盟', 'ss\'d撒大苏打撒旦', '/public/img_1577934364104njml4dvnrli.jpeg', 19, 1);
INSERT INTO `game` VALUES (7, 'wewqewqe', 'wqewqewqe', '/public/img_1583068682925sre1n9pzt5.jpeg', 25, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `login_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '登录名',
  `nick_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '昵称',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '邮箱',
  `del` int(11) NOT NULL DEFAULT 0 COMMENT '删除标识',
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '头像图片',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'test', 'test', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', '111111@ee.com', 0, 'http://192.168.43.135:3000/public/img_1578407114178o9mnm951wam.jpg');
INSERT INTO `user` VALUES (2, 't', '额', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', '122222@qq.com', 0, '/public/img_1580180533521j2skkr1j969.jpg');
INSERT INTO `user` VALUES (3, 't2', 'q', '0b4e7a0e5fe84ad35fb5f95b9ceeac79', '4@qq.com', 0, '/public/img_15801861816911k7r65qhoam.jpg');

SET FOREIGN_KEY_CHECKS = 1;
