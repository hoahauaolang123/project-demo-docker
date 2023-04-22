--
-- Script was generated by Devart dbForge Studio 2020 for MySQL, Version 9.0.597.0
-- Product home page: http://www.devart.com/dbforge/mysql/studio
-- Script date 6/6/2022 6:25:13 PM
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
-- Create table `category`
--
CREATE TABLE IF NOT EXISTS category (
  CategoryID CHAR(36) NOT NULL DEFAULT '',
  Title VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  ParentID CHAR(36) DEFAULT NULL,
  Note VARCHAR(255) DEFAULT NULL,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status BIT(1) DEFAULT b'1',
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (CategoryID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 4096,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_InsertCategory`
--
CREATE PROCEDURE Proc_InsertCategory(IN v_categoryid CHAR(36), IN v_title varchar(255), IN v_parentid CHAR(36), IN v_note varchar(255),IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO category
  VALUES (v_categoryid, v_title, v_parentid, v_note, v_createddate, v_createdby, v_modifieddate, v_modifiedby, v_status, v_isdeleted);
END
$$

DELIMITER ;

--
-- Create table `safe_address`
--
CREATE TABLE IF NOT EXISTS safe_address (
  SafeAddressID CHAR(36) NOT NULL DEFAULT 'UUID',
  SafeAddressValue VARCHAR(255) DEFAULT NULL,
  Type INT(11) DEFAULT NULL,
  DeviceName VARCHAR(255) DEFAULT NULL,
  DeviceCode VARCHAR(255) DEFAULT NULL,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status BIT(1) DEFAULT b'1',
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (SafeAddressID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 2730,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_UpdateSafeAddress`
--
CREATE PROCEDURE Proc_UpdateSafeAddress(IN v_safeaddressid CHAR(36), IN v_safeaddressvalue VARCHAR(255), IN v_devicename VARCHAR(255),IN v_devicecode VARCHAR(255), IN v_type int, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE safe_address
SET SafeAddressID = v_safeaddressid,
    SafeAddressValue = v_safeaddressvalue,
    Type = v_type,
    DeviceName = v_devicename,
    DeviceCode = v_devicecode,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedbY,
    Status = v_status,
    IsDeleted = v_isdeleteD
WHERE IsDeleted = FALSE
AND SafeAddressID = v_safeaddressid;
END
$$

--
-- Create procedure `Proc_InsertSafeAddress`
--
CREATE PROCEDURE Proc_InsertSafeAddress(IN v_safeaddressid CHAR(36), IN v_safeaddressvalue VARCHAR(255), IN v_devicename VARCHAR(255),IN v_devicecode VARCHAR(255), IN v_type int, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO safe_address (SafeAddressID, SafeAddressValue, DeviceName, DeviceCode, Type, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_safeaddressid, v_safeaddressvalue, v_devicename, v_devicecode, v_type, v_createddate, v_createdby, v_modifieddate, v_modifiedby, b'1', b'0');
END
$$

--
-- Create procedure `Proc_GetSafeAddresss`
--
CREATE PROCEDURE Proc_GetSafeAddresss()
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM safe_address
WHERE IsDeleted = FALSE
AND Status = TRUE;
END
$$

--
-- Create procedure `Proc_GetSafeAddressById`
--
CREATE PROCEDURE Proc_GetSafeAddressById(IN v_safeaddressid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM safe_address
WHERE SafeAddressID = v_safeaddressid
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_DeleteSafeAddressById`
--
CREATE PROCEDURE Proc_DeleteSafeAddressById(IN v_safeaddressid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
UPDATE safe_address
SET IsDeleted = TRUE
WHERE SafeAddressID = v_safeaddressid
AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create table `post`
--
CREATE TABLE IF NOT EXISTS post (
  PostID CHAR(36) NOT NULL DEFAULT 'UUID',
  MenuID CHAR(36) NOT NULL DEFAULT '',
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
CREATE PROCEDURE Proc_UpdatePost(IN v_postid CHAR(36), IN v_menuid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_description TEXT, IN v_content LONGTEXT, IN v_image TEXT, IN v_viewcount INT, IN v_type INT, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE post
SET Title = v_title,
    MenuID = v_menuid,
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
CREATE PROCEDURE Proc_InsertPost(IN v_postid CHAR(36),IN v_menuid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_description TEXT, IN v_content LONGTEXT,IN v_image TEXT, IN v_viewcount INT, IN v_type INT, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO post (PostID, MenuID, Title, Slug, Description, Content, Image, ViewCount, Type, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_postid, v_menuid, v_title, v_slug, v_description, v_content, v_image, v_viewcount, v_type, v_createddate, v_createdby, v_modifieddate, v_modifiedby, v_status, b'0');
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
UPDATE post
SET IsDeleted = TRUE
WHERE PostID = v_postid
AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create table `notification`
--
CREATE TABLE IF NOT EXISTS notification (
  NotificationID CHAR(36) NOT NULL DEFAULT '',
  Content VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `From` CHAR(36) DEFAULT NULL,
  `To` CHAR(36) DEFAULT NULL,
  ToEmail VARCHAR(255) DEFAULT NULL,
  IsReaded BIT(1) DEFAULT b'1',
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  IsDeleted BIT(1) DEFAULT b'0',
  Status BIT(1) DEFAULT b'1',
  PRIMARY KEY (NotificationID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 334,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_InsertNotification`
--
CREATE PROCEDURE Proc_InsertNotification(IN v_notificationid CHAR(36), IN v_content VARCHAR(255), IN v_from CHAR(36), IN v_to CHAR(36), IN v_toemail VARCHAR(255),in v_isreaded bit, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO notification (NotificationID, Content, `From`, `To`, ToEmail, IsReaded, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_notificationid, v_content, v_from, v_to, v_toemail, v_isreaded, v_createddate, v_createdby, v_modifieddate, v_modifiedby, b'1', b'0');
END
$$

--
-- Create procedure `Proc_GetNotificaitonById`
--
CREATE PROCEDURE Proc_GetNotificaitonById(IN v_notificationid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM notification
WHERE NotificationID = v_notificationid
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_DeleteNotificationById`
--
CREATE PROCEDURE Proc_DeleteNotificationById(IN v_notificationid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
UPDATE notification
SET IsDeleted = TRUE
WHERE NotificationID = v_notificationid
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
  IsPrivate BIT(1) DEFAULT NULL,
  PRIMARY KEY (MenuID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 1560,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_UpdateMenu`
--
CREATE PROCEDURE Proc_UpdateMenu(IN v_menuid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_isprivate BIT, IN v_parentid CHAR(36), IN v_isshowhome BIT,IN v_link TEXT, IN v_displayorder INT, IN v_type INT, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
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
    IsDeleted = v_isdeleted,
    IsPrivate = v_isprivate
WHERE IsDeleted = FALSE
AND MenuID = v_menuid;
END
$$

--
-- Create procedure `Proc_InsertMenu`
--
CREATE PROCEDURE Proc_InsertMenu(IN v_menuid CHAR(36), IN v_title VARCHAR(255), IN v_slug VARCHAR(255), IN v_isprivate BIT,IN v_parentid CHAR(36), IN v_isshowhome BIT,IN v_link TEXT, IN v_displayorder INT, IN v_type INT, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO menu (MenuID, Title, Slug, IsPrivate, ParentID, IsShowHome, Link, DisplayOrder, Type, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_menuid, v_title, v_slug, v_isprivate, v_parentid, v_isshowhome, v_link, v_displayorder, v_type, v_createddate, v_createdby, v_modifieddate, v_modifiedby, v_status, b'0');
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
WHERE IsDeleted = FALSE
AND Status = TRUE;
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
UPDATE menu
SET IsDeleted = TRUE
WHERE MenuID = v_menuid
AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create view `view_countpostbymenuid`
--
CREATE 
	DEFINER = 'root'@'localhost'
	SQL SECURITY INVOKER
VIEW IF NOT EXISTS view_countpostbymenuid
AS
SELECT
  `m`.`MenuID` AS `MenuID`,
  `m`.`Title` AS `Title`,
  `m`.`ParentID` AS `ParentID`,
  (SELECT
      COUNT(0)
    FROM `post` `p`
    WHERE `p`.`MenuID` = `m`.`MenuID`
    AND `p`.`IsDeleted` = 0
    AND `p`.`Status` = 1) AS `Amount`
FROM `menu` `m`;

--
-- Create table `book_order`
--
CREATE TABLE IF NOT EXISTS book_order (
  BookOrderID CHAR(36) NOT NULL DEFAULT '',
  BookOrderCode CHAR(20) DEFAULT NULL,
  AccountID CHAR(36) DEFAULT NULL,
  BookOrderInformation LONGTEXT DEFAULT NULL,
  Note VARCHAR(255) DEFAULT NULL,
  OrderStatus INT(11) DEFAULT NULL,
  FromDate TIMESTAMP NULL DEFAULT current_timestamp,
  DueDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status BIT(1) DEFAULT b'0',
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (BookOrderID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 3640,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create trigger `Trigger_AfterLendingBook`
--
CREATE 
	DEFINER = 'root'@'localhost'
TRIGGER IF NOT EXISTS Trigger_AfterLendingBook
	AFTER INSERT
	ON book_order
	FOR EACH ROW
BEGIN

END
$$

--
-- Create procedure `Proc_UpdateBookOrder`
--
CREATE PROCEDURE Proc_UpdateBookOrder(IN v_bookorderid CHAR(36), IN v_accountid CHAR(36), IN v_bookordercode CHAR(20), IN v_orderstatus int,IN v_bookorderinformation text, IN v_note VARCHAR(255), IN v_fromdate TIMESTAMP, IN v_duedate TIMESTAMP, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE book_order
SET AccountID = v_accountid,
    OrderStatus = v_orderstatus,
    BookOrderInformation = v_bookorderinformation,
    Note = v_note,
    FromDate = v_fromdate,
    DueDate = v_duedate,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedby,
    Status = v_status
WHERE IsDeleted = FALSE
AND BookOrderID = v_bookorderid;
END
$$

--
-- Create procedure `Proc_NextBookOrderCode`
--
CREATE PROCEDURE Proc_NextBookOrderCode()
  SQL SECURITY INVOKER
BEGIN
SELECT
  MAX(B.BookOrderCode)
FROM book_order B;
END
$$

--
-- Create procedure `Proc_InsertBookOrder`
--
CREATE PROCEDURE Proc_InsertBookOrder(IN v_bookorderid CHAR(36), IN v_accountid CHAR(36), IN v_bookordercode CHAR(20), IN v_orderstatus int,IN v_bookorderinformation text, IN v_note VARCHAR(255), IN v_fromdate TIMESTAMP, IN v_duedate TIMESTAMP,IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO book_order (BookOrderID, AccountID, BookOrderCode, OrderStatus, BookOrderInformation, Note, FromDate, DueDate, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_bookorderid, v_accountid, v_bookordercode, v_orderstatus, v_bookorderinformation, v_note, v_fromdate, v_duedate, v_createddate, v_createdby, v_modifieddate, v_modifiedby, v_status, b'0');
END
$$

--
-- Create procedure `Proc_DeleteBookOrderById`
--
CREATE PROCEDURE Proc_DeleteBookOrderById(IN v_bookorderid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
UPDATE book_order
SET IsDeleted = TRUE
WHERE BookOrderID = v_bookorderid
AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create table `book`
--
CREATE TABLE IF NOT EXISTS book (
  BookID CHAR(36) NOT NULL DEFAULT '',
  BookCode CHAR(20) DEFAULT NULL,
  BookName VARCHAR(255) DEFAULT NULL,
  Publisher VARCHAR(100) DEFAULT NULL,
  IsPrivate BIT(1) DEFAULT NULL,
  Author VARCHAR(100) DEFAULT NULL,
  LanguageCode CHAR(10) DEFAULT NULL,
  Price DECIMAL(15, 2) DEFAULT NULL,
  Description TEXT DEFAULT NULL,
  BookFormat INT(11) DEFAULT NULL,
  DueDate TIMESTAMP NULL DEFAULT NULL,
  BorrowedDate TIMESTAMP NULL DEFAULT NULL,
  DateOfPurchase VARCHAR(255) DEFAULT NULL,
  IsReferenceOnly BIT(1) DEFAULT b'0',
  Image TEXT DEFAULT NULL,
  File TEXT DEFAULT NULL,
  CategoryID CHAR(36) DEFAULT NULL,
  Lost INT(11) DEFAULT 0,
  Available INT(11) DEFAULT 0,
  Loaned INT(11) DEFAULT 0,
  Reserved INT(11) DEFAULT 0,
  Amount INT(11) DEFAULT 0,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status BIT(1) DEFAULT b'0',
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (BookID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 10922,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_UpdateBook`
--
CREATE PROCEDURE Proc_UpdateBook(IN v_bookid CHAR(36), IN v_bookcode char(20), IN v_isprivate BIT,IN v_bookname VARCHAR(255), IN v_publisher VARCHAR(100), IN v_author VARCHAR(100), IN v_languagecode char(10), IN v_price decimal, IN v_description text, IN v_bookformat int, IN v_duedate TIMESTAMP, v_borroweddate timestamp,IN v_dateofpurchase timestamp, IN v_isreferenceonly BIT, IN v_image text,v_categoryid char(36),IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE book
SET BookCode = v_bookcode,
    IsPrivate = v_isprivate,
    BookName = v_bookname,
    Publisher = v_publisher,
    Author = v_author,
    LanguageCode = v_languagecode,
    Price = v_price,
    Description = v_description,
    BookFormat = v_bookformat,
    DueDate = v_duedate,
    BorrowedDate = v_borroweddate,
    DateOfPurchase = v_dateofpurchase,
    IsReferenceOnly = v_isreferenceonly,
    Image = v_image,
    CategoryID = v_categoryid,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedby,
    Status = v_status
WHERE IsDeleted = FALSE
AND BookID = v_bookid;
END
$$

--
-- Create procedure `Proc_NextBookCode`
--
CREATE PROCEDURE Proc_NextBookCode()
  SQL SECURITY INVOKER
BEGIN
SELECT
  MAX(B.BookCode)
FROM book B;
END
$$

--
-- Create procedure `Proc_InsertBook`
--
CREATE PROCEDURE Proc_InsertBook(IN v_bookid CHAR(36), IN v_bookcode char(20), IN v_isprivate BIT, IN v_amount int,IN v_bookname VARCHAR(255), IN v_publisher VARCHAR(100), IN v_author VARCHAR(100), IN v_languagecode char(10), IN v_price decimal, IN v_description text, IN v_bookformat int, IN v_duedate TIMESTAMP, v_borroweddate timestamp,IN v_dateofpurchase timestamp, IN v_isreferenceonly BIT, IN v_image text,  IN v_file text,v_categoryid char(36),IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO book (BookID, BookCode, IsPrivate, Amount, Available, BookName, File, Publisher, Author, LanguageCode, Price, Description, BookFormat, DueDate, BorrowedDate, DateOfPurchase, IsReferenceOnly, Image, CategoryID, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_bookid, v_bookcode, v_isprivate, v_amount, v_amount, v_bookname, v_file, v_publisher, v_author, v_languagecode, v_price, v_description, v_bookformat, v_duedate, v_borroweddate, v_dateofpurchase, v_isreferenceonly, v_image, v_categoryid, v_createddate, v_createdby, v_modifieddate, v_modifiedby, v_status, v_isdeleted);
END
$$

--
-- Create procedure `Proc_GetBooks`
--
CREATE PROCEDURE Proc_GetBooks()
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM book
WHERE IsDeleted = FALSE
AND Status = TRUE;
END
$$

--
-- Create procedure `Proc_GetBookById`
--
CREATE PROCEDURE Proc_GetBookById(IN v_bookid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM book
WHERE BookID = v_bookid
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_DeleteBookById`
--
CREATE PROCEDURE Proc_DeleteBookById(IN v_bookid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
UPDATE book
SET IsDeleted = TRUE
WHERE BookID = v_bookid
AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create table `account`
--
CREATE TABLE IF NOT EXISTS account (
  AccountID CHAR(36) NOT NULL DEFAULT '',
  UserName VARCHAR(255) NOT NULL,
  Email VARCHAR(100) DEFAULT NULL,
  Address VARCHAR(255) DEFAULT NULL,
  PhoneNumber VARCHAR(100) DEFAULT NULL,
  FullName VARCHAR(255) DEFAULT NULL,
  Password VARCHAR(255) DEFAULT '',
  Avatar TEXT DEFAULT NULL,
  TotalBookCheckedOut INT(11) DEFAULT 0,
  TotalBookCheckingOut INT(11) DEFAULT 0,
  CreatedDate TIMESTAMP NULL DEFAULT current_timestamp,
  CreatedBy VARCHAR(255) DEFAULT NULL,
  ModifiedDate TIMESTAMP NULL DEFAULT current_timestamp,
  ModifiedBy VARCHAR(255) DEFAULT NULL,
  Status INT(11) DEFAULT NULL,
  IsDeleted BIT(1) DEFAULT b'0',
  PRIMARY KEY (AccountID)
)
ENGINE = INNODB,
AVG_ROW_LENGTH = 3276,
CHARACTER SET utf8mb4,
COLLATE utf8mb4_general_ci;

DELIMITER $$

--
-- Create procedure `Proc_UpdateAccountPassword`
--
CREATE PROCEDURE Proc_UpdateAccountPassword(IN v_accountid CHAR(36), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_password VARCHAR(255))
  SQL SECURITY INVOKER
BEGIN
UPDATE account
SET Password = v_password,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedby
WHERE IsDeleted = FALSE
AND AccountID = v_accountid;
END
$$

--
-- Create procedure `Proc_UpdateAccount`
--
CREATE PROCEDURE Proc_UpdateAccount(IN v_accountid CHAR(36), IN v_email VARCHAR(100), IN v_fullname VARCHAR(255), IN v_address VARCHAR(255),IN v_username VARCHAR(255), IN v_phonenumber VARCHAR(100), IN v_avatar TEXT, IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
UPDATE account
SET Email = v_email,
    UserName = v_username,
    PhoneNumber = v_phonenumber,
    FullName = v_fullname,
    Avatar = v_avatar,
    ModifiedDate = v_modifieddate,
    ModifiedBy = v_modifiedby,
    Address = v_address,
    Status = v_status,
    IsDeleted = v_isdeleted
WHERE IsDeleted = FALSE
AND AccountID = v_accountid;
END
$$

--
-- Create procedure `Proc_LoginAccount`
--
CREATE PROCEDURE Proc_LoginAccount(IN v_email varchar(100), in v_password varchar(255))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM account
WHERE Email = v_email
AND Password = v_password
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_InsertAccount`
--
CREATE PROCEDURE Proc_InsertAccount(IN v_accountid CHAR(36), IN v_email VARCHAR(100), IN v_fullname VARCHAR(255), IN v_username VARCHAR(255), IN v_phonenumber VARCHAR(100), IN v_password VARCHAR(255), IN v_avatar TEXT, IN v_createddate TIMESTAMP, IN v_createdby VARCHAR(255), IN v_modifieddate TIMESTAMP, IN v_modifiedby VARCHAR(255), IN v_status BIT, IN v_isdeleted BIT)
  SQL SECURITY INVOKER
BEGIN
INSERT INTO account (AccountID, Email, FullName, UserName, PhoneNumber, Password, Avatar, CreatedDate, CreatedBy, ModifiedDate, ModifiedBy, Status, IsDeleted)
  VALUES (v_accountid, v_email, v_fullname, v_username, v_phonenumber, v_password, v_avatar, v_createddate, v_createdby, v_modifieddate, v_modifiedby, v_status, b'0');
END
$$

--
-- Create procedure `Proc_GetAccountsFilterPaging`
--
CREATE PROCEDURE Proc_GetAccountsFilterPaging(IN v_filter VARCHAR(255), IN v_page_number INT, IN v_page_size INT, OUT v_total_record INT)
  SQL SECURITY INVOKER
BEGIN
 
  SET @FilterValue = ( SELECT
    v_filter);
  SET v_page_number = (v_page_number - 1) * v_page_size;
  IF v_page_size > 0 THEN
IF @FilterValue IS NULL THEN
SELECT
  *
FROM account p
WHERE p.IsDeleted = FALSE LIMIT v_page_size OFFSET v_page_number;
      SET v_total_record = ( SELECT
    COUNT(*)
  FROM account p
  WHERE p.IsDeleted = FALSE);
ELSE

SELECT
  *
FROM account p
WHERE p.IsDeleted = FALSE
AND (p.UserName LIKE CONCAT('%', @FilterValue, '%')
OR p.Email LIKE CONCAT('%', @FilterValue, '%')
OR p.FullName LIKE CONCAT('%', @FilterValue, '%')
OR p.PhoneNumber LIKE CONCAT('%', @FilterValue, '%'))
LIMIT v_page_size OFFSET v_page_number;
    SET v_total_record = ( SELECT
    COUNT(*)
  FROM account p
  WHERE p.IsDeleted = FALSE
  AND (p.UserName LIKE CONCAT('%', @FilterValue, '%')
  OR p.Email LIKE CONCAT('%', @FilterValue, '%')
  OR p.FullName LIKE CONCAT('%', @FilterValue, '%')
  OR p.PhoneNumber LIKE CONCAT('%', @FilterValue, '%')));
END IF;
END IF;
END
$$

--
-- Create procedure `Proc_GetAccounts`
--
CREATE PROCEDURE Proc_GetAccounts()
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM account
WHERE IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_GetAccountById`
--
CREATE PROCEDURE Proc_GetAccountById(IN v_accountid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
SELECT
  *
FROM account
WHERE AccountID = v_accountid
AND IsDeleted = FALSE;
END
$$

--
-- Create procedure `Proc_DeleteAccountById`
--
CREATE PROCEDURE Proc_DeleteAccountById(IN v_accountid CHAR(36))
  SQL SECURITY INVOKER
BEGIN
UPDATE account
SET IsDeleted = TRUE
WHERE AccountID = v_accountid
AND IsDeleted = FALSE;
END
$$

DELIMITER ;

--
-- Create view `view_bookorderview`
--
CREATE 
	DEFINER = 'root'@'localhost'
	SQL SECURITY INVOKER
VIEW IF NOT EXISTS view_bookorderview
AS
SELECT
  `a`.`FullName` AS `FullName`,
  `a`.`PhoneNumber` AS `PhoneNumber`,
  `bo`.`BookOrderID` AS `BookOrderID`,
  `bo`.`BookOrderCode` AS `BookOrderCode`,
  `bo`.`AccountID` AS `AccountID`,
  `bo`.`BookOrderInformation` AS `BookOrderInformation`,
  `bo`.`Note` AS `Note`,
  `bo`.`FromDate` AS `FromDate`,
  `bo`.`DueDate` AS `DueDate`,
  `bo`.`OrderStatus` AS `OrderStatus`,
  `bo`.`CreatedBy` AS `CreatedBy`,
  `bo`.`CreatedDate` AS `CreatedDate`,
  `bo`.`ModifiedDate` AS `ModifiedDate`,
  `bo`.`ModifiedBy` AS `ModifiedBy`,
  `bo`.`Status` AS `Status`,
  `bo`.`IsDeleted` AS `IsDeleted`
FROM (`account` `a`
  JOIN `book_order` `bo`
    ON (`bo`.`AccountID` = `a`.`AccountID`));

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
-- Restore previous SQL mode
-- 
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;

-- 
-- Enable foreign keys
-- 
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;