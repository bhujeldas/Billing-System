IF NOT EXISTS(SELECT * FROM master.dbo.sysdatabases WHERE name = 'dbBilling')
CREATE DATABASE dbBilling
GO

USE dbBilling
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblOrganization' AND type = 'U')
CREATE TABLE tblOrganization (
name VARCHAR(256) NOT NULL,
address VARCHAR(256) NULL,
phoneNo VARCHAR(50) NULL,
email VARCHAR(256) NULL,
site VARCHAR(256) NULL,
panNo VARCHAR(50) NOT NULL,
contactPerson VARCHAR(256) NULL,
mobileNo VARCHAR(50) NULL,
contactEmail VARCHAR(256) NULL,
slogan VARCHAR(1000) NULL,
logo VARCHAR(256))
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblSetting' AND type = 'U')
CREATE TABLE tblSetting (
siVatRate MONEY NULL,
siDueDays INT NULL,
siPrefix VARCHAR(5) NULL,
siSuffix VARCHAR(5) NULL,
siFillChar CHAR(1) NULL,
siBodyLength INT NULL,
siStartNo INT NULL,
siEndNo	INT NULL,
piVatRate MONEY NULL,
piDueDays INT NULL,
piPrefix VARCHAR(5) NULL,
piSuffix VARCHAR(5) NULL,
piFillChar CHAR(1) NULL,
piBodyLength INT NULL,
piStartNo INT NULL,
piEndNo	INT NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblUserGroup' AND type = 'U')
CREATE TABLE tblUserGroup(
id INT PRIMARY KEY IDENTITY,
alias VARCHAR(25) NOT NULL UNIQUE,
name VARCHAR(256) NOT NULL UNIQUE,
remarks	VARCHAR(256) NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblUser' AND type = 'U')
CREATE TABLE tblUser (
id INT PRIMARY KEY IDENTITY,
userName VARCHAR(256) NOT NULL UNIQUE,
loginName VARCHAR(256) NOT NULL	UNIQUE,
password VARCHAR(256) NOT NULL,
ugId INT NOT NULL REFERENCES tblUserGroup(id),
remarks VARCHAR(256) NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblUOM' AND type = 'U')
CREATE TABLE tblUOM	(
id INT PRIMARY KEY IDENTITY,
alias VARCHAR(25) NOT NULL UNIQUE,
name VARCHAR(256) NOT NULL UNIQUE,
remarks VARCHAR(256) NULL)

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblItem' AND type = 'U')
CREATE TABLE tblItem (
id INT PRIMARY KEY IDENTITY,
alias VARCHAR(25) NOT NULL UNIQUE,
name VARCHAR(256) NOT NULL UNIQUE,
uId INT NULL REFERENCES tblUOM(id),
sellingRate MONEY NULL,
buyingRate MONEY NULL,
remarks VARCHAR(256) NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblParty' AND type = 'U')
CREATE TABLE tblParty (
id INT PRIMARY KEY IDENTITY,
type INT NOT NULL,
alias VARCHAR(25) NOT NULL UNIQUE,
name VARCHAR(256) NOT NULL UNIQUE,
streetAddress VARCHAR(256) NULL,
city VARCHAR(256) NULL,
state VARCHAR(256) NULL,
country	VARCHAR(256) NULL,
phoneNo	VARCHAR(50)	NULL,
contactPerson VARCHAR(256) NULL,
mobileNo VARCHAR(50) NULL,
contactEmail VARCHAR(256) NULL,
remarks VARCHAR(256) NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblSalesInvoiceMaster' AND type = 'U')
CREATE TABLE tblSalesInvoiceMaster (
siId INT PRIMARY KEY IDENTITY,
siNo VARCHAR(50) NOT NULL UNIQUE,
siDate SMALLDATETIME NOT NULL,
dueDate	SMALLDATETIME NULL,
partyId INT NOT NULL REFERENCES tblParty(id),
address VARCHAR(256) NULL,
panNo VARCHAR(50) NULL,
remarks	VARCHAR(256) NULL,
totalAmount	MONEY NULL,
disRate	MONEY NULL,
disAmount MONEY	NULL,
taxableAmount MONEY	NULL,
taxRate	MONEY NULL,
taxAmount MONEY	NULL,
netAmount MONEY	NULL,
printCount INT NULL,
canceled INT NULL,
userId INT NOT NULL,
entryDate SMALLDATETIME	NOT NULL)

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblSalesInvoiceDetails' AND type = 'U')
CREATE TABLE tblSalesInvoiceDetails	(
siId INT NOT NULL REFERENCES tblSalesInvoiceMaster (siId),
sno	INT NOT NULL,
itemId INT NOT NULL REFERENCES tblItem(id),
qty	MONEY NULL,
uId	INT NULL REFERENCES tblUOM(id),
rate MONEY NULL,
amount MONEY NULL,
narration VARCHAR(256) NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblPurchaseInvoiceMaster' AND type = 'U')
CREATE TABLE tblPurchaseInvoiceMaster (
piId INT PRIMARY KEY IDENTITY,
piNo VARCHAR(50) NOT NULL UNIQUE,
piDate SMALLDATETIME NOT NULL,
dueDate	SMALLDATETIME NULL,
partyId INT NOT NULL,
address VARCHAR(256) NULL,
panNo VARCHAR(50) NULL,
vendorInvNo VARCHAR(50)	NULL,
vendorInvDate SMALLDATETIME	NULL,	
remarks VARCHAR(256) NULL,
totalAmount	MONEY NULL,
disRate	MONEY NULL,
disAmount MONEY	NULL,	
taxableAmount MONEY NULL,
taxRate	MONEY NULL,
taxAmount MONEY	NULL,
netAmount MONEY	NULL,
printCount INT NULL,
canceled INT NULL,
userId INT NOT NULL,
entryDate SMALLDATETIME NOT NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblPurchaseInvoiceDetails' AND type = 'U')
CREATE TABLE tblPurchaseInvoiceDetails (
piId INT NOT NULL REFERENCES tblPurchaseInvoiceMaster (piId),
sno	INT	NOT NULL,
itemId INT NOT NULL,
qty	MONEY NULL,
uId	INT	NULL REFERENCES tblUOM (id),
rate MONEY NULL,
amount MONEY NULL,
narration VARCHAR(256) NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblUserLog' AND type = 'U')
CREATE TABLE tblUserLog (
id INT PRIMARY KEY IDENTITY,
userId INT NOT NULL REFERENCES tblUser(id),
loginTime SMALLDATETIME NOT NULL,
logoutTime SMALLDATETIME NULL)
GO

IF NOT EXISTS (SELECT name,type FROM sysobjects WHERE name = 'tblEntryLog' AND type = 'U')
CREATE TABLE tblEntryLog (
id INT PRIMARY KEY IDENTITY,
userId INT NOT NULL REFERENCES tblUser (id),
module VARCHAR(50) NOT NULL,
invNo VARCHAR(50) NOT NULL,
invDate SMALLDATETIME NOT NULL,
amount MONEY NOT NULL,
action VARCHAR(50) NOT NULL,
actionDate SMALLDATETIME NOT NULL)
GO




