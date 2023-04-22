--
-- Script was generated by Devart dbForge Studio 2020 for MySQL, Version 9.0.597.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 5/4/2022 9:43:07 PM
-- Server version: 10.4.22
-- Client version: 4.1
--

-- 
-- Disable foreign keys
-- 
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;

-- 
-- Set SQL mode
-- 
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

DROP DATABASE IF EXISTS library;

CREATE DATABASE IF NOT EXISTS library
	CHARACTER SET utf8mb4
	COLLATE utf8mb4_general_ci;

--
-- Set default database
--
USE library;

--
-- Create table `post`
--
CREATE TABLE IF NOT EXISTS post (
  PostID CHAR(36) NOT NULL DEFAULT 'UUID',
  Title VARCHAR(255) DEFAULT NULL,
  Slug VARCHAR(255) DEFAULT NULL,
  Description TEXT DEFAULT NULL,
  Content LONGTEXT DEFAULT NULL,
  Image TEXT DEFAULT NULL,
  ViewCount INT(11) DEFAULT NULL,
  Type INT(11) DEFAULT NULL,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status BIT(1) DEFAULT b'1',
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (PostID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 862,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_UpdatePost`
--
CREATE PROCEDURE Proc_UpdatePost(IN v_postid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_description TEXT, IN v_content LONGTEXT,IN v_image TEXT, IN v_viewcount INT, IN v_type INT, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE post
SET Title = v_title,
    Slug = v_slug,
    Description = v_description,
    Image = v_image,
    Content = v_content,
    ViewCount = v_viewcount,
    Type = v_type,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedby,
    Status = v_status,
    IsDeleted = v_isdeleted
WHERE PostID = v_postid
AND IsDeleted = b'0';
END
$$

--
-- Create procedure `Proc_InsertPost`
--
CREATE PROCEDURE Proc_InsertPost(IN v_postid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_description TEXT, IN v_content LONGTEXT,IN v_image TEXT, IN v_viewcount INT, IN v_type INT, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO post (PostID, Title, Slug, Description, Content, Image, ViewCount, Type, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_postid, v_title, v_slug, v_description, v_content, v_image, v_viewcount, v_type, v_createddate, v_createdby, v_modifieddate, v_modifiedby, b'1', b'0');
END
$$

--
-- Create procedure `Proc_GetPostsFilterPaging`
--
CREATE PROCEDURE Proc_GetPostsFilterPaging(IN v_filter VARCHAR(255), IN v_page_number INT, IN v_page_size INT, OUT v_total_record INT)
  SQL SECURITY INVOKER
BEGIN
 
  SET @FilterValue = ( SELECT
    v_filter);
  SET v_page_number = (v_page_number - 1) * v_page_size;
  IF v_page_size > 0 THEN
IF @FilterValue IS NULL THEN
SELECT
  *
FROM post p
WHERE p.IsDeleted = FALSE LIMIT v_page_size OFFSET v_page_number;
      SET v_total_record = ( SELECT
    COUNT(*)
  FROM post p
  WHERE p.IsDeleted = FALSE);
ELSE

SELECT
  *
FROM post p
WHERE p.IsDeleted = FALSE
AND (p.Title LIKE CONCAT('%', @FilterValue, '%')
OR p.Slug LIKE CONCAT('%', @FilterValue, '%'))
LIMIT v_page_size OFFSET v_page_number;
    SET v_total_record = ( SELECT
    COUNT(*)
  FROM post p
  WHERE p.IsDeleted = FALSE
  AND (p.Title LIKE CONCAT('%', @FilterValue, '%')
  OR p.Slug LIKE CONCAT('%', @FilterValue, '%')));
END IF;
END IF;
END
$$

--
-- Create procedure `Proc_GetPosts`
--
CREATE PROCEDURE Proc_GetPosts()
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM post
WHERE IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_GetPostById`
--
CREATE PROCEDURE Proc_GetPostById(IN v_postid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM post
WHERE PostID = v_postid
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_DeletePostById`
--
CREATE PROCEDURE Proc_DeletePostById(IN v_postid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
DELETE
  FROM post
WHERE PostID = v_postid
  AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create table `menu`
--
CREATE TABLE IF NOT EXISTS menu (
  MenuID CHAR(36) NOT NULL DEFAULT 'UUID',
  Title VARCHAR(255) DEFAULT NULL,
  Slug VARCHAR(255) DEFAULT NULL,
  ParentID CHAR(36) DEFAULT '00000000-0000-0000-0000-000000000000',
  IsShowHome BIT(1) DEFAULT b'1',
  Link TEXT DEFAULT NULL,
  DisplayOrder INT(11) DEFAULT NULL,
  Type INT(11) DEFAULT NULL,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status BIT(1) DEFAULT b'1',
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (MenuID)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_UpdateMenu`
--
CREATE PROCEDURE Proc_UpdateMenu(IN v_menuid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_parentid CHAR(36), IN v_isshowhome BIT,IN v_link TEXT, IN v_displayorder INT, IN v_type INT, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE MENU
SET Title = v_title,
    Slug = v_slug,
    ParentID = v_parentid,
    IsShowHome = v_isshowhome,
    Link = v_link,
    DisplayOrder = v_displayorder,
    Type = v_type,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedbY,
    Status = v_status,
    IsDeleted = v_isdeleteD
WHERE IsDeleted = FALSE
AND MenuID = v_menuid;
END
$$

--
-- Create procedure `Proc_InsertMenu`
--
CREATE PROCEDURE Proc_InsertMenu(IN v_menuid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_parentid CHAR(36), IN v_isshowhome BIT,IN v_link TEXT, IN v_displayorder INT, IN v_type INT, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO menu (MenuID, Title, Slug, ParentID, IsShowHome, Link, DisplayOrder, Type, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_menuid, v_title, v_slug, v_parentid, v_isshowhome, v_link, v_displayorder, v_type, v_createddate, v_createdby, v_modifieddate, v_modifiedby, b'1', b'0');
END
$$

--
-- Create procedure `Proc_GetMenusFilterPaging`
--
CREATE PROCEDURE Proc_GetMenusFilterPaging(IN v_filter VARCHAR(255), IN v_page_number INT, IN v_page_size INT, OUT v_total_record INT)
  SQL SECURITY INVOKER
BEGIN
 
  SET @FilterValue = ( SELECT
    v_filter);
  SET v_page_number = (v_page_number - 1) * v_page_size;
  IF v_page_size > 0 THEN
IF @FilterValue IS NULL THEN
SELECT
  *
FROM menu p
WHERE p.IsDeleted = FALSE LIMIT v_page_size OFFSET v_page_number;
      SET v_total_record = ( SELECT
    COUNT(*)
  FROM menu p
  WHERE p.IsDeleted = FALSE);
ELSE

SELECT
  *
FROM menu p
WHERE p.IsDeleted = FALSE
AND (p.Title LIKE CONCAT('%', @FilterValue, '%')
OR p.Slug LIKE CONCAT('%', @FilterValue, '%')
OR p.Link LIKE CONCAT('%', @FilterValue, '%'))
LIMIT v_page_size OFFSET v_page_number;
    SET v_total_record = ( SELECT
    COUNT(*)
  FROM menu p
  WHERE p.IsDeleted = FALSE
  AND (p.Title LIKE CONCAT('%', @FilterValue, '%')
  OR p.Slug LIKE CONCAT('%', @FilterValue, '%')
  OR p.Link LIKE CONCAT('%', @FilterValue, '%')));
END IF;
END IF;
END
$$

--
-- Create procedure `Proc_GetMenus`
--
CREATE PROCEDURE Proc_GetMenus()
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM menu
WHERE IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_GetMenuById`
--
CREATE PROCEDURE Proc_GetMenuById(IN v_menuid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM menu
WHERE MenuID = v_menuid
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_DeleteMenuById`
--
CREATE PROCEDURE Proc_DeleteMenuById(IN v_menuid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
DELETE
  FROM menu
WHERE MenuID = v_menuid
  AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create table `user`
--
CREATE TABLE IF NOT EXISTS user (
  id CHAR(36) NOT NULL DEFAULT '',
  user_name VARCHAR(255) NOT NULL,
  email VARCHAR(100) DEFAULT NULL,
  phone VARCHAR(100) DEFAULT NULL,
  bar_code VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  address VARCHAR(255) DEFAULT NULL,
  created_date TIMESTAMP NULL DEFAULT current_timestamp,
  created_by VARCHAR(255) DEFAULT NULL,
  modified_date TIMESTAMP NULL DEFAULT current_timestamp,
  modified_by VARCHAR(255) DEFAULT NULL,
  is_deleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `notification`
--
CREATE TABLE IF NOT EXISTS notification (
  id CHAR(36) NOT NULL DEFAULT '',
  content VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `from` CHAR(36) DEFAULT NULL,
  `to` CHAR(36) DEFAULT NULL,
  to_email VARCHAR(255) DEFAULT NULL,
  is_readed BIT(1) DEFAULT b'1',
  created_date TIMESTAMP NULL DEFAULT current_timestamp,
  created_by VARCHAR(255) DEFAULT NULL,
  modified_date TIMESTAMP NULL DEFAULT current_timestamp,
  modified_by VARCHAR(255) DEFAULT NULL,
  is_deleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `library_card`
--
CREATE TABLE IF NOT EXISTS library_card (
  id CHAR(36) NOT NULL DEFAULT '',
  card_number VARCHAR(50) NOT NULL,
  bar_code VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  active BIT(1) DEFAULT NULL,
  created_date TIMESTAMP NULL DEFAULT current_timestamp,
  created_by VARCHAR(255) DEFAULT NULL,
  modified_date TIMESTAMP NULL DEFAULT current_timestamp,
  modified_by VARCHAR(255) DEFAULT NULL,
  is_deleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `category`
--
CREATE TABLE IF NOT EXISTS category (
  id CHAR(36) NOT NULL DEFAULT '',
  name VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  meta_title VARCHAR(255) DEFAULT NULL,
  parent_id CHAR(36) DEFAULT NULL,
  show_on_home BIT(1) DEFAULT b'1',
  created_date TIMESTAMP NULL DEFAULT current_timestamp,
  created_by VARCHAR(255) DEFAULT NULL,
  modified_date TIMESTAMP NULL DEFAULT current_timestamp,
  modified_by VARCHAR(255) DEFAULT NULL,
  is_deleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `book`
--
CREATE TABLE IF NOT EXISTS book (
  id CHAR(36) NOT NULL DEFAULT '',
  book_code CHAR(20) DEFAULT NULL,
  book_name VARCHAR(255) DEFAULT NULL,
  publisher VARCHAR(100) DEFAULT NULL,
  author VARCHAR(100) DEFAULT NULL,
  language_code CHAR(10) DEFAULT NULL,
  price DECIMAL(15, 2) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  book_format INT(11) DEFAULT NULL,
  due_date TIMESTAMP NULL DEFAULT NULL,
  borrowed_date TIMESTAMP NULL DEFAULT NULL,
  date_of_purchase VARCHAR(255) DEFAULT NULL,
  isReferenceOnly BIT(1) DEFAULT b'0',
  image TEXT DEFAULT NULL,
  catalog_id CHAR(36) DEFAULT NULL,
  created_date TIMESTAMP NULL DEFAULT current_timestamp,
  created_by VARCHAR(255) DEFAULT NULL,
  modified_date TIMESTAMP NULL DEFAULT current_timestamp,
  modified_by VARCHAR(255) DEFAULT NULL,
  status BIT(1) DEFAULT b'0',
  is_deleted BIT(1) DEFAULT b'0'
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

--
-- Create table `account`
--
CREATE TABLE IF NOT EXISTS account (
  id CHAR(36) NOT NULL DEFAULT '',
  user_name VARCHAR(255) NOT NULL,
  email VARCHAR(100) DEFAULT NULL,
  full_name VARCHAR(255) DEFAULT NULL,
  password VARCHAR(255) DEFAULT '',
  avatar TEXT DEFAULT NULL,
  created_date TIMESTAMP NULL DEFAULT current_timestamp,
  created_by VARCHAR(255) DEFAULT NULL,
  modified_date TIMESTAMP NULL DEFAULT current_timestamp,
  modified_by VARCHAR(255) DEFAULT NULL,
  status INT(11) DEFAULT NULL,
  is_deleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (id)
)
ENGINE = INNODB,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

-- 
-- Dumping data for table user
--
-- Table library.user does not contain any data (it is empty)

-- 
-- Dumping data for table post
--
INSERT INTO post VALUES
('0fec1f8f-6195-460c-9dc2-974c42961892', 'tieu de mac dinh 2232334', 'tieu-de-mac-dinh-2232334', 'mo ta mac dinh', '"Type some text..."', '1649144309455_image', 200, 1, '2022-04-05 12:32:09', 'DOVANHAI', '2022-04-05 14:59:46', 'DOVANHAI', True, False),
('26c9b8a8-87c5-4294-8afc-96477778f004', 'Tiêu đề bài đăng mặc định 44', 'tieu-de-bai-dang-mac-dinh-44', 'Mô tả mặc định', '"Type some text..."', '1649168607013_image', 200, 1, '2022-04-05 21:23:27', 'DOVANHAI', '2022-04-05 21:23:27', 'DOVANHAI', True, False),
('43ec1ee5-3c4b-4a4d-a910-86a6c1e37f1b', 'Tiêu đề bài đăng mặc định2222', 'tieu-de-bai-dang-mac-dinh2222', 'Mô tả mặc định', '"Type some text..."', '1649144245727_image', 200, 1, '2022-04-05 14:37:25', 'DOVANHAI', '2022-04-05 14:37:25', 'DOVANHAI', False, False),
('491e159f-838e-4503-b5db-b55aefe84d48', 'Tiêu đề bài đăng mặc định Tiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc địnhTiêu đề bài đăng mặc định', 'tieu-de-bai-dang-mac-dinh-tieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinhtieu-de-bai-dang-mac-dinh', 'Mô tả mặc định', '"Type some text..."', '1649150482734_image', 200, 1, '2022-04-05 16:21:22', 'DOVANHAI', '2022-04-05 16:21:22', 'DOVANHAI', True, False),
('57848cb0-994c-4a77-ae6c-4a847cf8e13c', 'Tiêu đề bài đăng mặc định 122', 'tieu-de-bai-dang-mac-dinh-122', 'Mô tả mặc định', '"Type some text..."', '1649144291792_image', 200, 1, '2022-04-05 12:24:08', 'DOVANHAI', '2022-04-05 14:59:41', 'DOVANHAI', True, False),
('5ae0af3b-37b8-45ee-9aaf-e99161fd0617', 'Tiêu đề bài đăng mặc định1111', 'tieu-de-bai-dang-mac-dinh1111', 'Mô tả mặc định', '"Type some text..."', '1649144230376_image', 200, 1, '2022-04-05 14:37:10', 'DOVANHAI', '2022-04-05 14:49:44', 'DOVANHAI', True, False),
('62007a71-fc50-4626-9c6b-82a5e2e9aece', 'Tiêu đề bài đăng mặc định 88', 'tieu-de-bai-dang-mac-dinh-88', 'Mô tả mặc định', '"Type some text..."', '1649168751013_image', 200, 1, '2022-04-05 21:25:51', 'DOVANHAI', '2022-04-05 21:25:51', 'DOVANHAI', True, False),
('6a914602-74de-4610-b0ed-11716ab25593', 'Tiêu đề bài đăng mặc định 55', 'tieu-de-bai-dang-mac-dinh-55', 'Mô tả mặc định', '"Type some text..."', '1649168613941_image', 200, 1, '2022-04-05 21:23:33', 'DOVANHAI', '2022-04-05 21:23:33', 'DOVANHAI', True, False),
('820b4e31-eb8a-49e1-b805-4811913c87a8', 'Tiêu đề bài đăng mặc định 2211', 'tieu-de-bai-dang-mac-dinh-2211', 'Mô tả mặc định', '"Type some text..."', '1649168458496_image', 200, 1, '2022-04-05 21:20:58', 'DOVANHAI', '2022-04-05 21:20:58', 'DOVANHAI', True, False),
('a0661cf1-b821-418d-8dfc-d1a251ece7ac', 'Tiêu đề bài đăng mặc định 667', 'tieu-de-bai-dang-mac-dinh-667', 'Mô tả mặc định', '"Type some text..."', '1649168716438_image', 200, 1, '2022-04-05 21:23:38', 'DOVANHAI', '2022-04-05 21:25:16', 'DOVANHAI', True, False),
('e5169eca-eab1-40df-b601-bfb0df5eb013', 'Tiêu đề bài đăng mặc định22', 'tieu-de-bai-dang-mac-dinh22', 'Mô tả mặc định', '"Type some text..."', '1649143885600_image', 200, 1, '2022-04-05 14:31:25', 'DOVANHAI', '2022-04-05 14:31:25', 'DOVANHAI', True, True),
('f55e4e17-c1e6-46c3-b61c-1048383ddfc3', 'Tiêu đề bài đăng mặc định 33', 'tieu-de-bai-dang-mac-dinh-33', 'Mô tả mặc định', '"Type some text..."', '1649168478854_image', 200, 1, '2022-04-05 21:21:18', 'DOVANHAI', '2022-04-05 21:21:18', 'DOVANHAI', True, False);

-- 
-- Dumping data for table notification
--
-- Table library.notification does not contain any data (it is empty)

-- 
-- Dumping data for table menu
--
-- Table library.menu does not contain any data (it is empty)

-- 
-- Dumping data for table library_card
--
-- Table library.library_card does not contain any data (it is empty)

-- 
-- Dumping data for table category
--
-- Table library.category does not contain any data (it is empty)

-- 
-- Dumping data for table book
--
-- Table library.book does not contain any data (it is empty)

-- 
-- Dumping data for table account
--
-- Table library.account does not contain any data (it is empty)

-- 
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;